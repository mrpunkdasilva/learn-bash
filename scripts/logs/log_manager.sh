#!/bin/bash
# Gerenciador de logs com rotação, análise e alertas

# Configurações
LOG_DIR="/var/log"
ARCHIVE_DIR="/var/log/archives"
MAX_LOG_SIZE="100M"
RETENTION_DAYS=30
ALERT_PATTERNS=("ERROR" "CRITICAL" "FATAL" "EXCEPTION")
NOTIFY_EMAIL="admin@example.com"

# Funções de gerenciamento de logs
rotate_logs() {
    local log_file="$1"
    if [ -f "$log_file" ] && [ "$(stat -f%z "$log_file")" -gt "$((1024*1024*100))" ]; then
        local timestamp=$(date +%Y%m%d_%H%M%S)
        gzip -c "$log_file" > "${ARCHIVE_DIR}/$(basename "$log_file")_${timestamp}.gz"
        cat /dev/null > "$log_file"
    fi
}

analyze_logs() {
    local log_file="$1"
    local alerts=()

    for pattern in "${ALERT_PATTERNS[@]}"; do
        if grep -q "$pattern" "$log_file"; then
            alerts+=("$pattern: $(grep "$pattern" "$log_file" | wc -l) ocorrências")
        fi
    done

    if [ ${#alerts[@]} -gt 0 ]; then
        send_alert "Alertas nos Logs" "${alerts[*]}"
    fi
}

cleanup_old_logs() {
    find "$ARCHIVE_DIR" -type f -name "*.gz" -mtime +$RETENTION_DAYS -delete
}

send_alert() {
    local subject="$1"
    local message="$2"
    echo "$message" | mail -s "$subject" "$NOTIFY_EMAIL"
}

generate_log_report() {
    local report_file="${ARCHIVE_DIR}/log_report_$(date +%Y%m%d).txt"
    
    {
        echo "=== Relatório de Logs ==="
        echo "Data: $(date)"
        echo
        echo "=== Sumário de Erros ==="
        for pattern in "${ALERT_PATTERNS[@]}"; do
            echo "$pattern: $(grep -r "$pattern" "$LOG_DIR" | wc -l) ocorrências"
        done
        echo
        echo "=== Top 10 IPs (access.log) ==="
        awk '{print $1}' "${LOG_DIR}/access.log" | sort | uniq -c | sort -rn | head -n 10
        echo
        echo "=== Uso de Espaço ==="
        du -sh "$LOG_DIR"/*
    } > "$report_file"
}

# Execução principal
main() {
    # Criar diretório de arquivo se não existir
    mkdir -p "$ARCHIVE_DIR"

    # Processar cada arquivo de log
    while IFS= read -r -d '' log_file; do
        rotate_logs "$log_file"
        analyze_logs "$log_file"
    done < <(find "$LOG_DIR" -type f -name "*.log" -print0)

    # Limpeza de logs antigos
    cleanup_old_logs

    # Gerar relatório diário
    generate_log_report
}

main "$@"