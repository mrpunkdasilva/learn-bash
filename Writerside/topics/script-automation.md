# Automação de Scripts

>Aprenda a criar scripts de automação eficientes e reutilizáveis para tarefas repetitivas.
>{style="note"}

## Fundamentos da Automação

### 🔄 Estrutura Básica
```bash
#!/bin/bash
# automation_base.sh

# Configurações
set -e  # Encerra em caso de erro
set -u  # Variáveis não definidas geram erro

# Variáveis globais
readonly LOG_FILE="/var/log/automation.log"
readonly CONFIG_FILE="/etc/automation/config.conf"

# Funções de utilidade
log_message() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$LOG_FILE"
}

check_dependencies() {
    local deps=("docker" "git" "curl")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            log_message "ERROR: Dependência não encontrada: $dep"
            exit 1
        fi
    done
}
```

## Padrões de Automação

### 📋 Template Base
```bash
#!/bin/bash
# template.sh

# Configuração
source "$(dirname "$0")/config.sh"

# Tratamento de erros
trap 'echo "Erro na linha $LINENO. Comando: $BASH_COMMAND"' ERR

# Funções principais
setup() {
    log_message "Iniciando setup..."
    check_dependencies
}

cleanup() {
    log_message "Realizando limpeza..."
    # Adicione código de limpeza aqui
}

# Execução principal
main() {
    setup
    trap cleanup EXIT
    
    # Lógica principal aqui
}

main "$@"
```

## Técnicas Avançadas

### 🔒 Controle de Execução
```bash
#!/bin/bash
# process_control.sh

LOCK_FILE="/var/run/automation.lock"

# Garante execução única
if ! mkdir "$LOCK_FILE" 2>/dev/null; then
    echo "Processo já em execução"
    exit 1
fi

trap 'rm -rf "$LOCK_FILE"' EXIT
```

### 📊 Monitoramento
```bash
#!/bin/bash
# monitoring.sh

monitor_resources() {
    while true; do
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
        mem_usage=$(free -m | awk '/Mem:/ {print $3}')
        
        if (( $(echo "$cpu_usage > 80" | bc -l) )); then
            notify_admin "Alto uso de CPU: $cpu_usage%"
        fi
        
        sleep 60
    done
}
```

## Melhores Práticas

1. **Modularização**
   - Divida scripts grandes em módulos menores
   - Use funções para código reutilizável
   - Mantenha uma estrutura organizada

2. **Logging**
   - Implemente logs detalhados
   - Use níveis de log (INFO, WARN, ERROR)
   - Rotacione logs regularmente

3. **Tratamento de Erros**
   - Sempre valide entradas
   - Use trap para cleanup
   - Implemente retry em operações críticas

4. **Segurança**
   - Evite injeção de comandos
   - Proteja dados sensíveis
   - Use permissões adequadas

## Exemplos Práticos

### 🔄 Backup Automatizado
```bash
#!/bin/bash
# backup_automation.sh

# Configurações
BACKUP_DIR="/backups"
SOURCES=("/etc" "/var/www" "/home")
DATE=$(date +%Y%m%d)

# Função de backup
create_backup() {
    local source="$1"
    local basename=$(basename "$source")
    local backup_file="${BACKUP_DIR}/${basename}_${DATE}.tar.gz"
    
    tar -czf "$backup_file" "$source" 2>/dev/null || {
        log_message "ERROR: Falha no backup de $source"
        return 1
    }
    
    log_message "SUCCESS: Backup criado: $backup_file"
}

# Execução
for source in "${SOURCES[@]}"; do
    create_backup "$source"
done
```

### 🔄 Deploy Automatizado
```bash
#!/bin/bash
# deploy_automation.sh

deploy_application() {
    local version="$1"
    local env="$2"
    
    log_message "Iniciando deploy v${version} em ${env}"
    
    # Pull da nova versão
    docker pull "app:${version}"
    
    # Update do serviço
    docker service update \
        --image "app:${version}" \
        --with-registry-auth \
        "app_${env}"
    
    # Verificação
    check_deployment_status
}
```

## Dicas e Truques

1. **Automação Inteligente**
   - Use variáveis de ambiente
   - Implemente verificações de sanidade
   - Adicione timeouts em operações

2. **Debug**
   - Use `set -x` para debug
   - Implemente modo verbose
   - Mantenha logs detalhados

3. **Performance**
   - Otimize operações I/O
   - Use paralelismo quando possível
   - Monitore uso de recursos

4. **Manutenção**
   - Documente bem o código
   - Mantenha versionamento
   - Faça revisões regulares