#!/bin/bash
# Monitor completo de servidor com alertas e relatórios

# Configurações
THRESHOLD_CPU=80
THRESHOLD_MEM=90
THRESHOLD_DISK=85
LOG_FILE="/var/log/server-monitor.log"
ALERT_EMAIL="admin@example.com"

# Funções de monitoramento
check_cpu() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    if [ "$cpu_usage" -gt "$THRESHOLD_CPU" ]; then
        return 1
    fi
    return 0
}

check_memory() {
    local mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)
    if [ "$mem_usage" -gt "$THRESHOLD_MEM" ]; then
        return 1
    fi
    return 0
}

check_disk() {
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d% -f1)
    if [ "$disk_usage" -gt "$THRESHOLD_DISK" ]; then
        return 1
    fi
    return 0
}

check_services() {
    local services=("nginx" "mysql" "redis")
    local failed_services=()

    for service in "${services[@]}"; do
        if ! systemctl is-active "$service" >/dev/null 2>&1; then
            failed_services+=("$service")
        fi
    done

    if [ ${#failed_services[@]} -gt 0 ]; then
        echo "${failed_services[*]}"
        return 1
    fi
    return 0
}

# Função de alerta
send_alert() {
    local subject="$1"
    local message="$2"
    echo "$message" | mail -s "ALERTA: $subject" "$ALERT_EMAIL"
}

# Geração de relatório
generate_report() {
    {
        echo "=== Relatório de Status do Servidor ==="
        echo "Data: $(date)"
        echo
        echo "=== CPU ==="
        top -bn1 | head -n 3
        echo
        echo "=== Memória ==="
        free -h
        echo
        echo "=== Disco ==="
        df -h
        echo
        echo "=== Processos ==="
        ps aux --sort=-%cpu | head -n 6
        echo
        echo "=== Conexões de Rede ==="
        netstat -tuln
    } > "/tmp/server_report_$(date +%Y%m%d).txt"
}

# Execução principal
main() {
    # Verificar CPU
    if ! check_cpu; then
        send_alert "CPU Alta" "Uso de CPU acima do threshold: $THRESHOLD_CPU%"
    fi

    # Verificar Memória
    if ! check_memory; then
        send_alert "Memória Alta" "Uso de memória acima do threshold: $THRESHOLD_MEM%"
    fi

    # Verificar Disco
    if ! check_disk; then
        send_alert "Disco Cheio" "Uso de disco acima do threshold: $THRESHOLD_DISK%"
    fi

    # Verificar Serviços
    local failed_services
    if ! failed_services=$(check_services); then
        send_alert "Serviços Parados" "Serviços com falha: $failed_services"
    fi

    # Gerar relatório diário
    generate_report
}

main "$@"