# Monitoramento Avançado

> Aprenda técnicas avançadas de monitoramento para manter seu sistema sob controle total.
> {style="note"}

## Ferramentas Especializadas

### 🔍 Monitoramento Profundo
```bash
# Análise detalhada de CPU
pidstat -u -p ALL 1    # Estatísticas por processo
perf top              # Análise de performance em tempo real
perf record -a        # Gravação de eventos
perf report          # Análise dos dados gravados

# Monitoramento de Memória
vmstat -w 1          # Estatísticas de memória virtual
slabtop             # Uso do kernel slab
valgrind --tool=massif ./programa  # Análise de heap
```

### 📊 Métricas Avançadas
```bash
# Coleta de métricas customizadas
#!/bin/bash
collect_metrics() {
    while true; do
        # CPU por core
        mpstat -P ALL 1 1
        
        # IO detalhado
        iostat -xz 1
        
        # Conexões de rede
        ss -s
        
        sleep 60
    done
}
```

## Sistemas de Monitoramento

### 🎯 Prometheus Integration
```bash
# node_exporter configuration
NODE_EXPORTER_VERSION="1.3.1"
wget "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
tar xvfz "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"
```

### 📈 Grafana Dashboard
```yaml
# dashboard.yaml
apiVersion: 1
providers:
- name: 'System Dashboard'
  orgId: 1
  folder: ''
  type: file
  options:
    path: /var/lib/grafana/dashboards
```

## Alertas Inteligentes

### 🚨 Sistema de Alertas
```bash
#!/bin/bash
# smart_alerts.sh

THRESHOLD_CPU=90
THRESHOLD_MEM=85
THRESHOLD_DISK=90

check_resources() {
    # CPU Load
    cpu_load=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    if [ "$cpu_load" -gt "$THRESHOLD_CPU" ]; then
        send_alert "CPU" "$cpu_load"
    fi
    
    # Memory Usage
    mem_used=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)
    if [ "$mem_used" -gt "$THRESHOLD_MEM" ]; then
        send_alert "Memory" "$mem_used"
    fi
    
    # Disk Usage
    disk_used=$(df -h / | awk 'NR==2 {print $5}' | cut -d% -f1)
    if [ "$disk_used" -gt "$THRESHOLD_DISK" ]; then
        send_alert "Disk" "$disk_used"
    fi
}

send_alert() {
    local resource=$1
    local value=$2
    curl -X POST "https://api.alerting.com/webhook" \
         -H "Content-Type: application/json" \
         -d "{\"resource\":\"$resource\",\"value\":$value}"
}
```

### 📱 Notificações
```bash
#!/bin/bash
# notification_system.sh

# Canais de notificação
notify_slack() {
    curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$1\"}" \
    "$SLACK_WEBHOOK_URL"
}

notify_email() {
    echo "$1" | mail -s "System Alert" admin@example.com
}

notify_telegram() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -d "chat_id=${TELEGRAM_CHAT_ID}" \
    -d "text=$1"
}
```

## Análise Preditiva

### 🔮 Previsão de Problemas
```bash
#!/bin/bash
# predictive_analysis.sh

analyze_trends() {
    # Análise de tendências de CPU
    sar -u 1 60 > cpu_trends.log
    
    # Análise de crescimento de disco
    df -h --output=source,used,size | awk '
    NR>1 {
        used=$2
        size=$3
        growth_rate=(used/size)*100
        print $1, growth_rate
    }' > disk_trends.log
    
    # Análise de conexões
    netstat -an | awk '
    /ESTABLISHED/ {count++}
    END {print count}' > conn_trends.log
}
```

## Automação de Respostas

### 🤖 Ações Automáticas
```bash
#!/bin/bash
# auto_response.sh

handle_high_load() {
    # Identificar processos problemáticos
    top_processes=$(ps aux --sort=-%cpu | head -n 5)
    
    # Ajustar nice de processos não críticos
    for pid in $(ps aux | awk '$3>50.0 {print $2}'); do
        renice +10 "$pid"
    done
    
    # Limpar caches se necessário
    sync && echo 3 > /proc/sys/vm/drop_caches
}

handle_disk_space() {
    # Limpar logs antigos
    find /var/log -type f -mtime +30 -delete
    
    # Limpar diretório /tmp
    find /tmp -type f -atime +10 -delete
    
    # Rotacionar logs
    logrotate -f /etc/logrotate.conf
}
```

## Exercícios Práticos

### 🎯 Missão 1: Sistema Completo
```bash
# Implemente um sistema que:
# 1. Colete métricas avançadas
# 2. Analise tendências
# 3. Gere alertas inteligentes
# 4. Execute ações automáticas
```

### 🎯 Missão 2: Dashboard
```bash
# Crie um dashboard que:
# 1. Mostre métricas em tempo real
# 2. Exiba tendências históricas
# 3. Integre múltiplas fontes
# 4. Permita análise detalhada
```

## Próximos Passos

1. [Otimização de Performance](performance-tuning.md)
2. [Automação Avançada](advanced-automation.md)

---

> "Monitoramento efetivo é a chave para prevenir problemas antes que eles ocorram."

```ascii
    MONITORING STATUS
    [📊📊📊📊📊] 100%
    SISTEMA: MONITORADO
    ALERTAS: ATIVOS
    ANÁLISE: PREDITIVA
```