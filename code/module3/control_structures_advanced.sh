#!/bin/bash
# Estruturas de controle avançadas

# Select com menu dinâmico
options=("Opção 1" "Opção 2" "Opção 3" "Sair")
select opt in "${options[@]}"; do
    case $opt in
        "Opção 1")
            echo "Selecionou opção 1"
            ;;
        "Opção 2")
            echo "Selecionou opção 2"
            ;;
        "Opção 3")
            echo "Selecionou opção 3"
            ;;
        "Sair")
            break
            ;;
        *) 
            echo "Opção inválida"
            ;;
    esac
done

# Loop com controle de erro
for cmd in gcc make cmake; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Comando não encontrado: $cmd"
        continue
    fi
    echo "Comando disponível: $cmd"
done

# While com read
while IFS=, read -r nome idade cidade; do
    [[ $nome = "Nome" ]] && continue  # Pula cabeçalho
    echo "Processando: $nome, $idade anos, $cidade"
done < "dados.csv"

# Until com timeout
timeout=30
start_time=$(date +%s)
until [[ -f "/tmp/ready.flag" ]]; do
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    
    if ((elapsed > timeout)); then
        echo "Timeout após $timeout segundos"
        exit 1
    fi
    sleep 1
done

# Case com padrões complexos
read -p "Digite um valor: " input
case $input in
    *[[:digit:]]*)
        echo "Contém números"
        ;;
    *[[:upper:]]*)
        echo "Contém maiúsculas"
        ;;
    *[[:lower:]]*)
        echo "Contém minúsculas"
        ;;
    *)
        echo "Outro tipo de entrada"
        ;;
esac