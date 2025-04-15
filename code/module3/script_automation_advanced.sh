#!/bin/bash
# Automação avançada de scripts

# Configuração de logging avançado
setup_logging() {
    local log_file=$1
    local log_level=${2:-"INFO"}
    
    exec 3>&1 4>&2
    exec 1> >(tee -a "$log_file")
    exec 2> >(tee -a "$log_file" >&2)
    
    trap 'exec 1>&3 2>&4' EXIT
}

# Sistema de plugins
load_plugins() {
    local plugin_dir="/usr/local/lib/myapp/plugins"
    
    for plugin in "$plugin_dir"/*.sh; do
        if [[ -f "$plugin" ]]; then
            source "$plugin"
            echo "Plugin carregado: $(basename "$plugin")"
        fi
    done
}

# Gerenciamento de configuração
declare -A config
load_config() {
    local config_file=$1
    
    while IFS='=' read -r key value; do
        [[ $key =~ ^[[:space:]]*# ]] && continue
        [[ -z $key ]] && continue
        config["${key// /}"]="${value// /}"
    done < "$config_file"
}

# Sistema de jobs em background
declare -A background_jobs
run_background_job() {
    local job_name=$1
    local cmd="${@:2}"
    
    eval "$cmd" &
    background_jobs["$job_name"]=$!
    echo "Job iniciado: $job_name (PID: ${background_jobs["$job_name"]})"
}

check_jobs() {
    for job in "${!background_jobs[@]}"; do
        if kill -0 "${background_jobs["$job"]}" 2>/dev/null; then
            echo "Job $job ainda em execução"
        else
            echo "Job $job finalizado"
            unset background_jobs["$job"]
        fi
    done
}

# Sistema de backup incremental
incremental_backup() {
    local source_dir=$1
    local backup_dir=$2
    local date_str=$(date +%Y%m%d)
    local last_backup=$(find "$backup_dir" -name "backup_*" | sort -r | head -n1)
    
    if [[ -n "$last_backup" ]]; then
        rsync -av --link-dest="$last_backup" "$source_dir" "$backup_dir/backup_$date_str"
    else
        rsync -av "$source_dir" "$backup_dir/backup_$date_str"
    fi
}

# Monitoramento de recursos com alertas
monitor_resources() {
    while true; do
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
        mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
        disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
        
        if (( $(echo "$cpu_usage > 80" | bc -l) )); then
            send_alert "CPU usage high: $cpu_usage%"
        fi
        
        if (( $(echo "$mem_usage > 90" | bc -l) )); then
            send_alert "Memory usage high: $mem_usage%"
        fi
        
        if (( disk_usage > 85 )); then
            send_alert "Disk usage high: $disk_usage%"
        fi
        
        sleep 300
    done
}

# Inicialização
main() {
    setup_logging "/var/log/myapp.log" "DEBUG"
    load_plugins
    load_config "/etc/myapp/config.conf"
    
    run_background_job "monitor" "monitor_resources"
    run_background_job "backup" "incremental_backup /data /backup"
    
    while true; do
        check_jobs
        sleep 60
    done
}

main "$@"