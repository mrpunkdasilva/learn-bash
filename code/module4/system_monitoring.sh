#!/bin/bash
# Monitoramento avançado do sistema

# Configurações
readonly MONITOR_LOG="/var/log/system_monitor.log"
readonly ALERT_THRESHOLD="/etc/monitor_thresholds.conf"
readonly METRICS_DIR="/var/lib/system_metrics"

# Inicialização
setup_monitoring() {
    mkdir -p "$METRICS_DIR"
    touch "$MONITOR_LOG"
    
    # Verificar dependências
    for cmd in iostat vmstat netstat; do
        if ! command -v "$cmd" &>/dev/null; then
            echo "Comando necessário não encontrado: $cmd"
            exit 1
        fi
    done
}

# Coleta de métricas
collect_system_metrics() {
    while true; do
        # CPU
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
        
        # Memória
        mem_info=$(free -m)
        mem_total=$(echo "$mem_info" | awk '/Mem:/ {print $2}')
        mem_used=$(echo "$mem_info" | awk '/Mem:/ {print $3}')
        mem_usage=$((mem_used * 100 / mem_total))
        
        # Disco
        disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
        io_stats=$(iostat -x 1 1 | awk '/sda/ {print $14}')
        
        # Rede
        net_stats=$(netstat -i | awk 'NR>2 {print $3 + $7}')
        
        # Salvar métricas
        timestamp=$(date +%s)
        echo "$timestamp,$cpu_usage,$mem_usage,$disk_usage,$io_stats,$net_stats" >> \
            "$METRICS_DIR/metrics_$(date +%Y%m%d).csv"
        
        sleep 60
    done
}

# Análise de métricas
analyze_metrics() {
    local file="$METRICS_DIR/metrics_$(date +%Y%m%d).csv"
    
    echo "=== Análise do Sistema ==="
    echo "Média de CPU: $(awk -F, '{sum+=$2} END {print sum/NR}' "$file")%"
    echo "Média de Memória: $(awk -F, '{sum+=$3} END {print sum/NR}' "$file")%"
    echo "Média de Disco: $(awk -F, '{sum+=$4} END {print sum/NR}' "$file")%"
    echo "Pico de CPU: $(awk -F, '{if($2>max)max=$2} END {print max}' "$file")%"
    echo "Pico de Memória: $(awk -F, '{if($3>max)max=$3} END {print max}' "$file")%"
}

# Alertas
check_alerts() {
    # Carregar thresholds
    source "$ALERT_THRESHOLD"
    
    while true; do
        current_metrics=$(tail -n 1 "$METRICS_DIR/metrics_$(date +%Y%m%d).csv")
        IFS=',' read -r timestamp cpu mem disk io net <<< "$current_metrics"
        
        # Verificar limites
        if (( $(echo "$cpu > $CPU_THRESHOLD" | bc -l) )); then
            send_alert "CPU acima do limite: $cpu%"
        fi
        
        if (( $(echo "$mem > $MEM_THRESHOLD" | bc -l) )); then
            send_alert "Memória acima do limite: $mem%"
        fi
        
        if (( $(echo "$disk > $DISK_THRESHOLD" | bc -l) )); then
            send_alert "Disco acima do limite: $disk%"
        fi
        
        sleep 300
    done
}

# Relatórios
generate_report() {
    local start_date=$1
    local end_date=${2:-$(date +%Y%m%d)}
    
    echo "=== Relatório de Sistema ==="
    echo "Período: $start_date a $end_date"
    echo
    
    for date in $(seq "$start_date" "$end_date"); do
        if [[ -f "$METRICS_DIR/metrics_$date.csv" ]]; then
            echo "=== Data: $date ==="
            analyze_metrics "$METRICS_DIR/metrics_$date.csv"
            echo
        fi
    done
}

# Menu principal
main_menu() {
    while true; do
        echo -e "\n=== Monitoramento do Sistema ==="
        echo "1. Iniciar coleta de métricas"
        echo "2. Analisar métricas atuais"
        echo "3. Iniciar verificação de alertas"
        echo "4. Gerar relatório"
        echo "5. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                collect_system_metrics &
                echo "Coleta de métricas iniciada"
                ;;
            2)
                analyze_metrics
                ;;
            3)
                check_alerts &
                echo "Verificação de alertas iniciada"
                ;;
            4)
                read -p "Data inicial (YYYYMMDD): " start_date
                read -p "Data final (YYYYMMDD) [hoje]: " end_date
                generate_report "$start_date" "${end_date:-$(date +%Y%m%d)}"
                ;;
            5)
                exit 0
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
    done
}

# Inicialização
setup_monitoring
main_menu