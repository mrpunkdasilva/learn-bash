# Automação Avançada 

> Aprenda técnicas avançadas de automação para maximizar sua produtividade.
> {style="note"}

## Automação de Deploy

### 🚀 Pipeline CI/CD
```bash
#!/bin/bash
# pipeline.sh
set -e

# Configurações
source .env
VERSION=$(git describe --tags)

# Etapas do pipeline
run_tests() {
    echo "Executando testes..."
    make test
}

build_app() {
    echo "Construindo aplicação..."
    docker build -t app:${VERSION} .
}

deploy() {
    echo "Realizando deploy..."
    kubectl apply -f k8s/
}

main() {
    run_tests
    build_app
    deploy
}

main "$@"
```

### 📊 Monitoramento
```bash
#!/bin/bash
# monitor.sh
THRESHOLD=90

check_resources() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    disk_usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d% -f1)

    if [ "$cpu_usage" -gt "$THRESHOLD" ] || 
       [ "${mem_usage%.*}" -gt "$THRESHOLD" ] || 
       [ "$disk_usage" -gt "$THRESHOLD" ]; then
        send_alert
    fi
}

send_alert() {
    curl -X POST "${WEBHOOK_URL}" \
         -H "Content-Type: application/json" \
         -d "{\"text\":\"Alerta: Uso de recursos alto!\"}"
}
```

## Automação de Tarefas

### ⏰ Agendamento
```bash
#!/bin/bash
# scheduler.sh
BACKUP_DIR="/backups"
LOG_FILE="/var/log/backup.log"

backup_database() {
    timestamp=$(date +%Y%m%d_%H%M%S)
    pg_dump -U postgres db_name > "${BACKUP_DIR}/backup_${timestamp}.sql"
    
    # Manter apenas últimos 7 backups
    find "${BACKUP_DIR}" -name "backup_*.sql" -mtime +7 -delete
}

rotate_logs() {
    find /var/log -name "*.log" -size +100M | while read log; do
        gzip -9 "${log}"
    done
}
```

### 🔄 Sincronização
```bash
#!/bin/bash
# sync.sh
DIRS=("config" "data" "logs")
REMOTE="user@server:/path"

for dir in "${DIRS[@]}"; do
    rsync -avz --delete "${dir}/" "${REMOTE}/${dir}/"
done
```

## Automação de Desenvolvimento

### 🛠️ Setup de Ambiente
```bash
#!/bin/bash
# setup_dev.sh
setup_env() {
    # Instalar dependências
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y docker docker-compose git
    elif command -v brew &> /dev/null; then
        brew install docker docker-compose git
    fi

    # Configurar git
    git config --global user.name "${GIT_NAME}"
    git config --global user.email "${GIT_EMAIL}"
}
```

### 📦 Gestão de Dependências
```bash
#!/bin/bash
# deps_check.sh
check_deps() {
    local deps=("docker" "git" "kubectl" "helm")
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "Erro: $dep não encontrado"
            exit 1
        fi
    done
}
```

## Boas Práticas

### ✅ Recomendações
1. Use controle de versão
2. Implemente logging adequado
3. Trate erros apropriadamente
4. Documente suas automações
5. Faça backup antes de alterações

### ⚠️ Pontos de Atenção
1. Teste em ambiente seguro
2. Valide inputs
3. Monitore execuções
4. Implemente rollback
5. Mantenha logs de auditoria

## Próximos Passos

1. [Orquestração de Containers](container-orchestration.md)
2. [Monitoramento Avançado](advanced-monitoring.md)
3. [Infraestrutura como Código](infrastructure-as-code.md)

---

> "A automação é a arte de fazer máquinas trabalharem para você."

```
    AUTOMATION MASTER
    [🤖🤖🤖🤖🤖] 100%
    STATUS: AUTOMAÇÃO DOMINADA
    PRÓXIMO: ORQUESTRAÇÃO
```