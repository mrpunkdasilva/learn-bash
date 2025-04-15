#!/bin/bash
# Sistema completo de backup com rotação, compressão e notificações

# Configurações
BACKUP_ROOT="/var/backups"
SOURCES=("/etc" "/home" "/var/www")
RETENTION_DAYS=30
LOG_FILE="/var/log/backup.log"
NOTIFY_EMAIL="admin@example.com"

# Funções de logging
log() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" | tee -a "$LOG_FILE"
}

# Função de notificação
notify() {
    local subject="$1"
    local message="$2"
    echo "$message" | mail -s "$subject" "$NOTIFY_EMAIL"
}

# Função principal de backup
perform_backup() {
    local source_dir="$1"
    local backup_name="$(basename "$source_dir")"
    local date_stamp="$(date +%Y%m%d_%H%M%S)"
    local backup_file="${BACKUP_ROOT}/${backup_name}_${date_stamp}.tar.gz"

    log "Iniciando backup de $source_dir"
    
    if tar -czf "$backup_file" "$source_dir" 2>/dev/null; then
        log "Backup concluído: $backup_file"
        return 0
    else
        log "ERRO: Falha no backup de $source_dir"
        return 1
    fi
}

# Rotação de backups
rotate_backups() {
    log "Iniciando rotação de backups"
    find "$BACKUP_ROOT" -type f -name "*.tar.gz" -mtime +$RETENTION_DAYS -delete
    log "Rotação concluída"
}

# Execução principal
main() {
    local errors=0

    # Criar diretório de backup se não existir
    mkdir -p "$BACKUP_ROOT"

    # Realizar backup de cada fonte
    for source in "${SOURCES[@]}"; do
        if ! perform_backup "$source"; then
            ((errors++))
        fi
    done

    # Rotação de backups antigos
    rotate_backups

    # Notificação final
    if [ $errors -eq 0 ]; then
        notify "Backup Concluído" "Todos os backups foram realizados com sucesso."
    else
        notify "ALERTA: Falhas no Backup" "$errors fontes apresentaram erro durante o backup."
    fi
}

main "$@"