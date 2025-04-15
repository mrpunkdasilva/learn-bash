#!/bin/bash
# Processador distribuído

# Configurações
readonly WORK_DIR="/tmp/processing"
readonly LOG_FILE="/var/log/processing/distributed.log"
readonly MAX_RETRIES=3
readonly TIMEOUT=3600

# Logging
log() {
    local level=$1
    local message=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$level] $message" >> "$LOG_FILE"
}

# Processar chunk
process_chunk() {
    local chunk_file=$1
    local output_file="${chunk_file}.processed"
    
    # Processamento real aqui
    while IFS= read -r line; do
        # Exemplo de processamento
        processed_line=$(echo "$line" | tr '[:lower:]' '[:upper:]')
        echo "$processed_line" >> "$output_file"
    done < "$chunk_file"
}

# Sincronizar resultados
sync_results() {
    local source_dir=$1
    local target_node=$2
    
    rsync -avz "$source_dir/" "$target_node:$WORK_DIR/results/"
}

# Verificar saúde do nó
check_node_health() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    local mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    if (( $(echo "$cpu_usage > 90" | bc -l) )); then
        log "WARNING" "CPU usage too high: $cpu_usage%"
        return 1
    fi
    
    if (( $(echo "$mem_usage > 90" | bc -l) )); then
        log "WARNING" "Memory usage too high: $mem_usage%"
        return 1
    fi
    
    if (( disk_usage > 90 )); then
        log "WARNING" "Disk usage too high: $disk_usage%"
        return 1
    fi
    
    return 0
}

# Processar trabalho distribuído
process_distributed() {
    local input_dir=$1
    local retry_count=0
    
    mkdir -p "$WORK_DIR"
    
    while [[ $retry_count -lt $MAX_RETRIES ]]; do
        if ! check_node_health; then
            log "ERROR" "Node health check failed"
            ((retry_count++))
            sleep 60
            continue
        fi
        
        for file in "$input_dir"/*; do
            if [[ -f "$file" ]]; then
                log "INFO" "Processing file: $file"
                
                timeout "$TIMEOUT" process_chunk "$file"
                
                if [[ $? -eq 0 ]]; then
                    log "INFO" "Successfully processed: $file"
                else
                    log "ERROR" "Failed to process: $file"
                    ((retry_count++))
                    continue
                fi
            fi
        done
        
        break
    done
    
    if [[ $retry_count -eq $MAX_RETRIES ]]; then
        log "ERROR" "Max retries reached. Some files may not be processed."
        return 1
    fi
    
    return 0
}

# Menu principal
main_menu() {
    while true; do
        echo -e "\n=== Processador Distribuído ==="
        echo "1. Iniciar processamento"
        echo "2. Verificar status"
        echo "3. Sincronizar resultados"
        echo "4. Visualizar logs"
        echo "5. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                read -p "Diretório de entrada: " input_dir
                process_distributed "$input_dir"
                ;;
            2)
                check_node_health
                ;;
            3)
                read -p "Nó de destino: " target_node
                sync_results "$WORK_DIR" "$target_node"
                ;;
            4)
                tail -f "$LOG_FILE"
                ;;
            5)
                echo "Encerrando..."
                exit 0
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
    done
}

# Iniciar
main_menu