#!/bin/bash
# Tratamento avançado de erros

# Configuração de debug e tratamento de erros
set -e  # Sai em caso de erro
set -u  # Trata variáveis não definidas como erro
set -o pipefail  # Propaga erros em pipes

# Log de erros personalizado
error_log() {
    local message="$1"
    local error_code="${2:-1}"
    echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $message (Code: $error_code)" >&2
}

# Try-catch simulado
try() {
    local cmd="$1"
    local error_handler="${2:-default_error_handler}"
    
    if ! eval "$cmd"; then
        $error_handler "$cmd" $?
    fi
}

# Handler de erro padrão
default_error_handler() {
    local cmd="$1"
    local exit_code="$2"
    error_log "Comando falhou: $cmd" "$exit_code"
}

# Recuperação de erros
recover_from_error() {
    local error_type="$1"
    
    case "$error_type" in
        "network")
            systemctl restart networking
            ;;
        "disk")
            df -h > /dev/null
            sync
            ;;
        "service")
            systemctl restart "$2"
            ;;
        *)
            error_log "Tipo de erro desconhecido: $error_type"
            return 1
            ;;
    esac
}

# Exemplo de uso
main() {
    try "ping -c 1 google.com" || recover_from_error "network"
    try "df -h /nonexistent" "custom_disk_error_handler"
}

main "$@"