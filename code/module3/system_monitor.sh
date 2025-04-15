#!/bin/bash
# Sistema de monitoramento avançado

# Configurações
THRESHOLD_CPU=80
THRESHOLD_MEM=90
THRESHOLD_DISK=85
LOG_FILE="/var/log/system_monitor.log"

# Função de logging
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Monitoramento de CPU
check_cpu() {
    local cpu_usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    
    if [ "$cpu_usage" -gt "$THRESHOLD_CPU" ]; then
        log_message "ALERTA: Uso de CPU alto: ${cpu_usage}%"
        return 1
    fi
    return 0
}

# Monitoramento de Memória
check_memory() {
    local mem_usage
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100}' | cut -d. -f1)
    
    if [ "$mem_usage" -gt "$THRESHOLD_MEM" ]; then
        log_message "ALERTA: Uso de memória alto: ${mem_usage}%"
        return 1
    fi
    return 0
}

# Monitoramento de Disco
check_disk() {
    local disk_usage
    disk_usage=$(df -h / | tail -1 | awk '{print $5}' | cut -d% -f1)
    
    if [ "$disk_usage" -gt "$THRESHOLD_DISK" ]; then
        log_message "ALERTA: Uso de disco alto: ${disk_usage}%"
        return 1
    fi
    return 0
}

# Loop principal de monitoramento
main() {
    while true; do
        check_cpu || send_notification "CPU"
        check_memory || send_notification "Memória"
        check_disk || send_notification "Disco"
        sleep 300
    done
}

main "$@"