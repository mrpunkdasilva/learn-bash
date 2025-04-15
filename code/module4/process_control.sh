#!/bin/bash
# Controle avançado de processos

# Configurações
readonly PROCESS_LOG="/var/log/process_control.log"
readonly RESOURCE_LIMITS="/etc/resource_limits.conf"

# Logging
log_process() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$PROCESS_LOG"
}

# Monitoramento de processos
monitor_process() {
    local process_name=$1
    local max_cpu=${2:-80}
    local max_mem=${3:-1024}
    
    while true; do
        # Obter PID e estatísticas
        pid=$(pgrep -x "$process_name")
        if [[ -n "$pid" ]]; then
            cpu_usage=$(ps -p "$pid" -o %cpu | tail -1)
            mem_usage=$(ps -p "$pid" -o rss | tail -1)
            
            # Verificar limites
            if (( $(echo "$cpu_usage > $max_cpu" | bc -l) )); then
                log_process "ALERTA: CPU alta ($cpu_usage%) para $process_name"
                send_alert "CPU alta para $process_name"
            fi
            
            if (( mem_usage > max_mem * 1024 )); then
                log_process "ALERTA: Memória alta (${mem_usage}KB) para $process_name"
                send_alert "Memória alta para $process_name"
            fi
        else
            log_process "Processo $process_name não encontrado"
        fi
        
        sleep 60
    done
}

# Controle de recursos
set_process_limits() {
    local process_name=$1
    local cpu_limit=$2
    local mem_limit=$3
    
    # Encontrar PID
    pid=$(pgrep -x "$process_name")
    if [[ -n "$pid" ]]; then
        # Definir limites de CPU
        cpulimit -p "$pid" -l "$cpu_limit" &
        
        # Definir limites de memória
        systemctl set-property "$process_name.service" MemoryMax="${mem_limit}M"
        
        log_process "Limites definidos para $process_name"
    fi
}

# Reinicialização automática
auto_restart() {
    local process_name=$1
    local max_restarts=${2:-3}
    local restart_interval=${3:-300}
    
    local restarts=0
    while true; do
        if ! pgrep -x "$process_name" > /dev/null; then
            ((restarts++))
            
            if (( restarts > max_restarts )); then
                log_process "Máximo de reinicializações atingido para $process_name"
                send_alert "Falha na reinicialização de $process_name"
                break
            fi
            
            systemctl restart "$process_name"
            log_process "Processo $process_name reiniciado (tentativa $restarts)"
        else
            restarts=0
        fi
        
        sleep "$restart_interval"
    done
}

# Gerenciamento de prioridade
adjust_priority() {
    local process_name=$1
    local nice_value=$2
    
    for pid in $(pgrep "$process_name"); do
        renice "$nice_value" -p "$pid"
        log_process "Prioridade ajustada para $process_name (PID: $pid)"
    done
}

# Menu principal
main_menu() {
    while true; do
        echo -e "\n=== Controle de Processos ==="
        echo "1. Monitorar processo"
        echo "2. Definir limites"
        echo "3. Configurar reinicialização automática"
        echo "4. Ajustar prioridade"
        echo "5. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                read -p "Nome do processo: " process
                read -p "Limite de CPU (%): " cpu
                read -p "Limite de memória (MB): " mem
                monitor_process "$process" "$cpu" "$mem" &
                ;;
            2)
                read -p "Nome do processo: " process
                read -p "Limite de CPU (%): " cpu
                read -p "Limite de memória (MB): " mem
                set_process_limits "$process" "$cpu" "$mem"
                ;;
            3)
                read -p "Nome do processo: " process
                read -p "Máximo de reinicializações: " max
                read -p "Intervalo (segundos): " interval
                auto_restart "$process" "$max" "$interval" &
                ;;
            4)
                read -p "Nome do processo: " process
                read -p "Valor nice (-20 a 19): " nice
                adjust_priority "$process" "$nice"
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

# Verificar se é root
if [[ $EUID -ne 0 ]]; then
    echo "Este script precisa ser executado como root"
    exit 1
fi

main_menu