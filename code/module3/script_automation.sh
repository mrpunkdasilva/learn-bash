#!/bin/bash
# Demonstração de automação de scripts

# Configurações
LOG_FILE="/var/log/automation.log"
BACKUP_DIR="/backup"

# Logging
log() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$LOG_FILE"
}

# Backup automatizado
backup_files() {
    local source_dir="$1"
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    local backup_file="${BACKUP_DIR}/backup_${timestamp}.tar.gz"
    
    tar -czf "$backup_file" "$source_dir" && \
    log "Backup criado: $backup_file"
}

# Limpeza automática
cleanup() {
    find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -delete
    log "Limpeza de backups antigos concluída"
}

# Agendamento (exemplo para crontab)
# 0 2 * * * /path/to/script_automation.sh backup /data