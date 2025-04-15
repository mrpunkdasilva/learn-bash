#!/bin/bash
# Controle avançado de processos

# Configurações
readonly PROCESS_LOG="/var/log/process_control.log"
readonly CGROUP_BASE="/sys/fs/cgroup"
readonly MONITOR_INTERVAL=60

# Logging
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$PROCESS_LOG"
}

# Gerenciamento de processos
manage_process() {
    local pid=$1
    local action=$2
    
    case "$action" in
        "limit")
            # Limitar recursos do processo
            cpulimit -p "$pid" -l 50  # Limita CPU a 50%
            ;;
        "nice")
            # Ajustar prioridade
            renice -n 10 -p "$pid"
            ;;
        "isolate")
            # Isolar processo em cgroup
            local cgroup_name="isolated_$pid"
            mkdir -p "$CGROUP_BASE/cpu/$cgroup_name"
            echo "$pid" > "$CGROUP_BASE/cpu/$cgroup_name/tasks"
            echo "50000" > "$CGROUP_BASE/cpu/$cgroup_name/cpu.cfs_quota_us"
            ;;
        *)
            echo "Ação inválida: $action"
            return 1
            ;;
    esac
    
    log_action "Processo $pid: $action aplicado"
}

# Monitoramento de processos críticos
monitor_critical_processes() {
    local process_list=("sshd" "nginx" "mysql" "postgresql")
    
    for proc in "${process_list[@]}"; do
        if ! pgrep -x "$proc" >/dev/null; then
            log_action "Processo crítico parado: $proc"
            systemctl restart "$proc"
        fi
    done
}

# Análise de recursos por processo
analyze_process_resources() {
    local pid=$1
    
    echo "=== Análise de Recursos do PID $pid ==="
    ps -p "$pid" -o pid,ppid,cmd,%cpu,%mem,state
    
    # Análise de I/O
    if [ -f "/proc/$pid/io" ]; then
        cat "/proc/$pid/io"
    fi
    
    # Análise de limites
    prlimit --pid "$pid"
}

# Gerenciamento de processos zumbis
cleanup_zombies() {
    local zombies=$(ps aux | awk '$8=="Z" {print $2}')
    
    for pid in $zombies; do
        local ppid=$(ps -o ppid= -p "$pid")
        kill -9 "$ppid" 2>/dev/null
        log_action "Processo zumbi eliminado: $pid (PPID: $ppid)"
    done
}

# Menu principal
main_menu() {
    while true; do
        echo -e "\n=== Controle de Processos ==="
        echo "1. Listar processos críticos"
        echo "2. Analisar processo específico"
        echo "3. Limitar recursos de processo"
        echo "4. Limpar processos zumbis"
        echo "5. Iniciar monitoramento"
        echo "6. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                ps aux | head -1
                for proc in sshd nginx mysql postgresql; do
                    ps aux | grep "$proc" | grep -v grep
                done
                ;;
            2)
                read -p "PID do processo: " pid
                analyze_process_resources "$pid"
                ;;
            3)
                read -p "PID do processo: " pid
                read -p "Ação (limit/nice/isolate): " action
                manage_process "$pid" "$action"
                ;;
            4)
                cleanup_zombies
                ;;
            5)
                while true; do
                    monitor_critical_processes
                    sleep "$MONITOR_INTERVAL"
                done &
                echo "Monitoramento iniciado em background"
                ;;
            6)
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