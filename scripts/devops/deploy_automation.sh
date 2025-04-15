#!/bin/bash
# Sistema de automação DevOps para deploy e integração contínua

# Configurações
REPO_URL="git@github.com:user/repo.git"
DEPLOY_DIR="/var/www/app"
BACKUP_DIR="/var/www/backups"
LOG_FILE="/var/log/deploy.log"
SLACK_WEBHOOK="https://hooks.slack.com/services/xxx/yyy/zzz"

# Funções de logging e notificação
log() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" | tee -a "$LOG_FILE"
}

notify_slack() {
    local message="$1"
    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$message\"}" \
        "$SLACK_WEBHOOK"
}

# Funções de deploy
backup_current() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    tar -czf "${BACKUP_DIR}/backup_${timestamp}.tar.gz" "$DEPLOY_DIR"
}

update_code() {
    if [ -d "$DEPLOY_DIR/.git" ]; then
        cd "$DEPLOY_DIR" && git pull
    else
        git clone "$REPO_URL" "$DEPLOY_DIR"
    fi
}

run_tests() {
    cd "$DEPLOY_DIR"
    if [ -f "package.json" ]; then
        npm test
    elif [ -f "composer.json" ]; then
        composer test
    else
        echo "No test configuration found"
        return 1
    fi
}

build_application() {
    cd "$DEPLOY_DIR"
    if [ -f "package.json" ]; then
        npm run build
    elif [ -f "composer.json" ]; then
        composer install --no-dev --optimize-autoloader
    fi
}

update_services() {
    # Restart necessary services
    systemctl restart nginx
    systemctl restart php-fpm
}

# Função de rollback
rollback() {
    local latest_backup=$(ls -t "${BACKUP_DIR}"/*.tar.gz | head -n1)
    if [ -n "$latest_backup" ]; then
        rm -rf "$DEPLOY_DIR"/*
        tar -xzf "$latest_backup" -C /
        update_services
        notify_slack "🔄 Rollback realizado para backup: $(basename "$latest_backup")"
    fi
}

# Execução principal
main() {
    log "Iniciando processo de deploy"
    notify_slack "🚀 Iniciando novo deploy"

    # Backup
    log "Realizando backup"
    backup_current

    # Update
    log "Atualizando código"
    if ! update_code; then
        log "ERRO: Falha ao atualizar código"
        notify_slack "❌ Falha no deploy: erro ao atualizar código"
        exit 1
    fi

    # Testes
    log "Executando testes"
    if ! run_tests; then
        log "ERRO: Falha nos testes"
        notify_slack "❌ Falha no deploy: testes falharam"
        rollback
        exit 1
    fi

    # Build
    log "Realizando build"
    if ! build_application; then
        log "ERRO: Falha no build"
        notify_slack "❌ Falha no deploy: erro no build"
        rollback
        exit 1
    fi

    # Update services
    log "Atualizando serviços"
    update_services

    log "Deploy concluído com sucesso"
    notify_slack "✅ Deploy concluído com sucesso!"
}

# Tratamento de erros
set -e
trap 'notify_slack "❌ Erro inesperado durante o deploy"; rollback' ERR

main "$@"