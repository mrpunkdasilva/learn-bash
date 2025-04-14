# Templates de Scripts 📝

## Templates Básicos

### Script Base
```bash
#!/bin/bash
#
# Nome: script_base.sh
# Descrição: Template básico para scripts Bash
# Autor: Seu Nome
# Data: YYYY-MM-DD

# Configurações
set -euo pipefail
IFS=$'\n\t'

# Variáveis
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/script.log"

# Funções
log() {
    local msg="[$(date +'%Y-%m-%d %H:%M:%S')] $1"
    echo "$msg" | tee -a "$LOG_FILE"
}

cleanup() {
    log "Limpando recursos..."
    # Adicione código de limpeza aqui
}

# Tratamento de erros
trap cleanup EXIT
trap 'log "Erro na linha $LINENO. Comando: $BASH_COMMAND"' ERR

# Código principal
main() {
    log "Iniciando script..."
    # Seu código aqui
    log "Script finalizado."
}

main "$@"
```

### Script de Backup
```bash
#!/bin/bash
#
# Nome: backup.sh
# Descrição: Template para script de backup

# Configurações
SOURCE_DIR="/caminho/origem"
BACKUP_DIR="/caminho/backup"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_${DATE}.tar.gz"

# Criar backup
backup() {
    tar -czf "${BACKUP_DIR}/${BACKUP_FILE}" "$SOURCE_DIR"
}

# Limpar backups antigos
cleanup_old() {
    find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -delete
}

# Executar
backup
cleanup_old
```

### Script de Monitoramento
```bash
#!/bin/bash
#
# Nome: monitor.sh
# Descrição: Template para monitoramento

# Configurações
THRESHOLD_CPU=80
THRESHOLD_MEM=90
LOG_FILE="/var/log/monitor.log"

# Funções de monitoramento
check_cpu() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    if [ "$cpu_usage" -gt "$THRESHOLD_CPU" ]; then
        echo "ALERTA: CPU em $cpu_usage%"
    fi
}

check_memory() {
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if [ "${mem_usage%.*}" -gt "$THRESHOLD_MEM" ]; then
        echo "ALERTA: Memória em $mem_usage%"
    fi
}

# Loop principal
while true; do
    check_cpu
    check_memory
    sleep 60
done
```

## Templates Avançados

### API Client
```bash
#!/bin/bash
#
# Nome: api_client.sh
# Descrição: Template para cliente API

# Configurações
API_URL="https://api.exemplo.com"
API_TOKEN="seu_token"

# Funções API
api_get() {
    local endpoint="$1"
    curl -s -H "Authorization: Bearer $API_TOKEN" \
         "${API_URL}${endpoint}"
}

api_post() {
    local endpoint="$1"
    local data="$2"
    curl -s -X POST \
         -H "Authorization: Bearer $API_TOKEN" \
         -H "Content-Type: application/json" \
         -d "$data" \
         "${API_URL}${endpoint}"
}

# Uso
response=$(api_get "/users")
echo "$response" | jq '.'
```

### Parser de Logs
```bash
#!/bin/bash
#
# Nome: log_parser.sh
# Descrição: Template para análise de logs

# Configurações
LOG_FILE="/var/log/app.log"
PATTERN='ERROR|WARN'
OUTPUT_FILE="analysis.txt"

# Funções de análise
analyze_logs() {
    echo "=== Análise de Logs ===" > "$OUTPUT_FILE"
    echo "Data: $(date)" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    echo "Erros encontrados:" >> "$OUTPUT_FILE"
    grep -E "$PATTERN" "$LOG_FILE" >> "$OUTPUT_FILE"
    
    echo "" >> "$OUTPUT_FILE"
    echo "Sumário:" >> "$OUTPUT_FILE"
    grep -E "$PATTERN" "$LOG_FILE" | awk '{print $1}' | sort | uniq -c >> "$OUTPUT_FILE"
}

# Executar
analyze_logs
```

### Gerenciador de Serviços
```bash
#!/bin/bash
#
# Nome: service_manager.sh
# Descrição: Template para gerenciamento de serviços

# Configurações
SERVICES=("nginx" "mysql" "redis")
LOG_DIR="/var/log/services"

# Funções
check_service() {
    local service="$1"
    systemctl is-active "$service" >/dev/null 2>&1
}

restart_service() {
    local service="$1"
    systemctl restart "$service"
}

log_status() {
    local service="$1"
    local status="$2"
    echo "[$(date)] $service: $status" >> "${LOG_DIR}/status.log"
}

# Loop principal
for service in "${SERVICES[@]}"; do
    if ! check_service "$service"; then
        log_status "$service" "DOWN - Tentando reiniciar"
        restart_service "$service"
        sleep 5
        if check_service "$service"; then
            log_status "$service" "RECUPERADO"
        else
            log_status "$service" "FALHA NA RECUPERAÇÃO"
        fi
    else
        log_status "$service" "OK"
    fi
done
```

## Dicas de Uso

1. **Personalização**
   - Ajuste variáveis e configurações
   - Modifique funções conforme necessidade
   - Adicione logs específicos

2. **Boas Práticas**
   - Mantenha documentação atualizada
   - Use funções para organizar código
   - Implemente tratamento de erros

3. **Segurança**
   - Valide entradas
   - Use permissões adequadas
   - Proteja dados sensíveis

---

> "Um bom template é meio caminho andado."