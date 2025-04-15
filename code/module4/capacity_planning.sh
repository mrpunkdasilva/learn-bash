#!/bin/bash
# Planejamento de Capacidade

# Configurações
readonly CAPACITY_LOG="/var/log/capacity.log"
readonly HISTORY_DIR="/var/log/capacity_history"
readonly THRESHOLD_CPU=80
readonly THRESHOLD_MEM=90
readonly THRESHOLD_DISK=85

# Logging
log_capacity() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$CAPACITY_LOG"
}

# Coleta de métricas
collect_metrics() {
    mkdir -p "$HISTORY_DIR"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    
    # CPU
    top -bn1 | grep "Cpu(s)" > "$HISTORY_DIR/cpu_$timestamp"
    
    # Memória
    free -m > "$HISTORY_DIR/memory_$timestamp"
    
    # Disco
    df -h > "$HISTORY_DIR/disk_$timestamp"
    
    # Load Average
    uptime > "$HISTORY_DIR/load_$timestamp"
    
    # Processos
    ps aux --sort=-%cpu | head -11 > "$HISTORY_DIR/top_processes_$timestamp"
}

# Análise de tendências
analyze_trends() {
    echo "=== Análise de Tendências ==="
    
    # CPU
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    echo "CPU Usage: $cpu_usage%"
    
    # Memória
    local mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "Memory Usage: ${mem_usage:.2f}%"
    
    # Disco
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    echo "Disk Usage: $disk_usage%"
    
    # Alertas
    if (( $(echo "$cpu_usage > $THRESHOLD_CPU" | bc -l) )); then
        log_capacity "ALERTA: CPU acima do threshold ($cpu_usage%)"
    fi
    
    if (( $(echo "$mem_usage > $THRESHOLD_MEM" | bc -l) )); then
        log_capacity "ALERTA: Memória acima do threshold ($mem_usage%)"
    fi
    
    if (( disk_usage > THRESHOLD_DISK )); then
        log_capacity "ALERTA: Disco acima do threshold ($disk_usage%)"
    fi
}

# Previsão de crescimento
predict_growth() {
    local days=$1
    
    echo "=== Previsão de Crescimento ($days dias) ==="
    
    # Crescimento do disco
    local current_usage=$(df -h / | awk 'NR==2 {print $3}')
    local daily_growth=$(du -s /var/log | awk '{print $1/1024/1024}')  # GB por dia
    local predicted_usage=$(echo "$current_usage + ($daily_growth * $days)" | bc)
    
    echo "Uso atual do disco: $current_usage GB"
    echo "Crescimento diário estimado: ${daily_growth:.2f} GB"
    echo "Uso previsto em $days dias: ${predicted_usage:.2f} GB"
    
    # Previsão de memória
    local mem_trend=$(free -g | grep Mem | awk '{print $3}')
    echo "Uso atual de memória: $mem_trend GB"
    
    # Previsão de CPU
    local cpu_trend=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    echo "Uso atual de CPU: $cpu_trend%"
}

# Recomendações de capacidade
generate_recommendations() {
    echo "=== Recomendações de Capacidade ==="
    
    # CPU
    local cpu_count=$(nproc)
    local load_avg=$(uptime | awk -F'load average:' '{print $2}' | awk -F, '{print $1}')
    
    if (( $(echo "$load_avg > $cpu_count" | bc -l) )); then
        echo "Recomendação: Considerar upgrade de CPU"
        echo "- Load average ($load_avg) excede número de cores ($cpu_count)"
    fi
    
    # Memória
    local mem_free=$(free -g | grep Mem | awk '{print $4}')
    if (( mem_free < 2 )); then
        echo "Recomendação: Aumentar memória RAM"
        echo "- Menos de 2GB de memória livre"
    fi
    
    # Disco
    local disk_free=$(df -h / | awk 'NR==2 {print $4}')
    if [[ $disk_free =~ ^[0-9]+G$ ]] && (( ${disk_free%G} < 10 )); then
        echo "Recomendação: Expandir espaço em disco"
        echo "- Menos de 10GB livre no disco"
    fi
}

# Relatório de capacidade
generate_report() {
    local report_file="capacity_report_$(date +%Y%m%d).txt"
    
    {
        echo "=== Relatório de Capacidade ==="
        echo "Data: $(date)"
        echo
        
        echo "--- Utilização Atual ---"
        analyze_trends
        echo
        
        echo "--- Previsões ---"
        predict_growth 30
        echo
        
        echo "--- Recomendações ---"
        generate_recommendations
        
    } > "$report_file"
    
    echo "Relatório gerado: $report_file"
}

# Verificar se é root
if [[ $EUID -ne 0 ]]; then
    echo "Este script precisa ser executado como root"
    exit 1
fi

# Verificar dependências
check_dependencies() {
    local deps=("bc" "top" "df" "free" "awk" "sed")
    local missing=()

    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing+=("$dep")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo "Dependências faltando: ${missing[*]}"
        echo "Por favor, instale as dependências necessárias"
        exit 1
    fi
}

# Limpeza de logs antigos
cleanup_old_logs() {
    local retention_days=30
    
    find "$HISTORY_DIR" -type f -mtime +$retention_days -delete
    find "$CAPACITY_LOG" -type f -mtime +$retention_days -delete
    
    echo "Logs mais antigos que $retention_days dias foram removidos"
}

# Exportar métricas
export_metrics() {
    local format=$1
    local output_file="capacity_metrics_$(date +%Y%m%d).$format"
    
    case $format in
        "csv")
            {
                echo "timestamp,cpu_usage,mem_usage,disk_usage"
                echo "$(date +%s),$(top -bn1 | grep 'Cpu(s)' | awk '{print $2}'),$(free | grep Mem | awk '{print $3/$2 * 100.0}'),$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')"
            } > "$output_file"
            ;;
        "json")
            {
                echo "{"
                echo "  \"timestamp\": \"$(date +%s)\","
                echo "  \"cpu_usage\": \"$(top -bn1 | grep 'Cpu(s)' | awk '{print $2}')\","
                echo "  \"mem_usage\": \"$(free | grep Mem | awk '{print $3/$2 * 100.0}')\","
                echo "  \"disk_usage\": \"$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')\""
                echo "}"
            } > "$output_file"
            ;;
        *)
            echo "Formato não suportado. Use 'csv' ou 'json'"
            return 1
            ;;
    esac
    
    echo "Métricas exportadas para $output_file"
}

# Atualizar menu principal com novas opções
main_menu() {
    check_dependencies

    while true; do
        echo -e "\n=== Planejamento de Capacidade ==="
        echo "1. Coletar métricas"
        echo "2. Analisar tendências"
        echo "3. Previsão de crescimento"
        echo "4. Gerar recomendações"
        echo "5. Gerar relatório completo"
        echo "6. Limpar logs antigos"
        echo "7. Exportar métricas"
        echo "8. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                collect_metrics
                echo "Métricas coletadas"
                ;;
            2)
                analyze_trends
                ;;
            3)
                read -p "Número de dias para previsão: " days
                predict_growth "$days"
                ;;
            4)
                generate_recommendations
                ;;
            5)
                generate_report
                ;;
            6)
                cleanup_old_logs
                ;;
            7)
                read -p "Formato de exportação (csv/json): " format
                export_metrics "$format"
                ;;
            8)
                echo "Encerrando..."
                exit 0
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
    done
}

# Execução principal
main_menu