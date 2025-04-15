#!/bin/bash
# Gerenciador principal de processamento avançado

# Configurações
readonly CONFIG_FILE="/etc/processing/config.yml"
readonly LOG_DIR="/var/log/processing"
readonly NODES_FILE="/etc/processing/nodes.txt"

# Verificar dependências
check_dependencies() {
    local deps=("parallel" "ssh" "rsync" "bc" "awk")
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "Erro: $dep não encontrado. Por favor instale-o."
            exit 1
        fi
    done
}

# Inicializar ambiente
init_environment() {
    mkdir -p "$LOG_DIR"
    
    if [[ ! -f "$CONFIG_FILE" ]]; then
        cat > "$CONFIG_FILE" <<EOF
processing:
  max_nodes: 5
  chunk_size: 1000
  timeout: 3600
  retry_count: 3
  
monitoring:
  interval: 60
  metrics_retention: 30
  
logging:
  level: INFO
  rotate: weekly
EOF
    fi
}

# Gerenciar nós
manage_nodes() {
    local action=$1
    local node=$2
    
    case $action in
        "add")
            echo "$node" >> "$NODES_FILE"
            echo "Nó $node adicionado"
            ;;
        "remove")
            sed -i "/^$node$/d" "$NODES_FILE"
            echo "Nó $node removido"
            ;;
        "list")
            echo "Nós disponíveis:"
            cat "$NODES_FILE"
            ;;
        *)
            echo "Ação inválida"
            return 1
            ;;
    esac
}

# Distribuir trabalho
distribute_work() {
    local input_file=$1
    local chunk_size=$2
    
    if [[ ! -f "$input_file" ]]; then
        echo "Arquivo de entrada não encontrado"
        return 1
    fi
    
    # Dividir arquivo em chunks
    split -l "$chunk_size" "$input_file" chunk_
    
    # Distribuir para nós
    while read -r node; do
        for chunk in chunk_*; do
            echo "Enviando $chunk para $node"
            scp "$chunk" "$node:/tmp/"
            ssh "$node" "./process_chunk.sh /tmp/$chunk" &
        done
    done < "$NODES_FILE"
    
    wait
    echo "Processamento distribuído concluído"
}

# Monitorar processamento
monitor_processing() {
    while read -r node; do
        echo "=== Status do nó: $node ==="
        ssh "$node" "top -bn1 | head -n 3"
        ssh "$node" "df -h | grep '^/dev'"
    done < "$NODES_FILE"
}

# Menu principal
main_menu() {
    while true; do
        echo -e "\n=== Gerenciador de Processamento Avançado ==="
        echo "1. Inicializar ambiente"
        echo "2. Gerenciar nós"
        echo "3. Distribuir trabalho"
        echo "4. Monitorar processamento"
        echo "5. Visualizar logs"
        echo "6. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                init_environment
                ;;
            2)
                echo "a. Adicionar nó"
                echo "b. Remover nó"
                echo "c. Listar nós"
                read -p "Escolha uma ação: " node_action
                case $node_action in
                    a)
                        read -p "Digite o endereço do nó: " node
                        manage_nodes "add" "$node"
                        ;;
                    b)
                        read -p "Digite o endereço do nó: " node
                        manage_nodes "remove" "$node"
                        ;;
                    c)
                        manage_nodes "list"
                        ;;
                esac
                ;;
            3)
                read -p "Arquivo de entrada: " input_file
                read -p "Tamanho do chunk: " chunk_size
                distribute_work "$input_file" "$chunk_size"
                ;;
            4)
                monitor_processing
                ;;
            5)
                tail -f "$LOG_DIR/processing.log"
                ;;
            6)
                echo "Encerrando..."
                exit 0
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
    done
}

# Verificar se é root
if [[ $EUID -ne 0 ]]; then
    echo "Este script precisa ser executado como root"
    exit 1
fi

# Iniciar
check_dependencies
main_menu