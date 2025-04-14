# Planejamento de Capacidade

> Aprenda a planejar e dimensionar recursos do sistema de forma eficiente para garantir performance e disponibilidade.
> {style="note"}

## Análise de Recursos

### 📊 Métricas Essenciais
```bash
#!/bin/bash
# capacity_metrics.sh

collect_metrics() {
    # CPU
    echo "=== CPU Usage ==="
    mpstat -P ALL 1 1
    
    # Memory
    echo -e "\n=== Memory Usage ==="
    free -h
    
    # Disk
    echo -e "\n=== Disk Usage ==="
    df -h
    
    # I/O
    echo -e "\n=== I/O Statistics ==="
    iostat -x 1 1
}
```

### 📈 Projeção de Crescimento
```bash
#!/bin/bash
# growth_projection.sh

analyze_growth() {
    local log_file="$1"
    local days="$2"
    
    # Análise de tendências
    echo "Tendência de crescimento (últimos $days dias):"
    awk -v days="$days" '
        BEGIN { 
            split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec", month)
            for (i=1; i<=12; i++) months[month[i]]=i
        }
        /Disk Usage:/ {
            gsub(/%/,"",$3)
            usage[$1]=$3
        }
        END {
            for (date in usage) {
                print date, usage[date]
            }
        }' "$log_file" | sort -k1
}
```

## Ferramentas de Planejamento

### 🔍 Análise de Carga
```bash
#!/bin/bash
# load_analysis.sh

monitor_load() {
    local threshold="$1"
    local interval="$2"
    
    while true; do
        load=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1)
        if (( $(echo "$load > $threshold" | bc -l) )); then
            echo "[ALERTA] Carga alta detectada: $load"
            collect_diagnostics
        fi
        sleep "$interval"
    done
}

collect_diagnostics() {
    ps aux --sort=-%cpu | head -n 10
    netstat -tuln
    iostat -x 1 5
}
```

### 📋 Recomendações Automáticas
```bash
#!/bin/bash
# recommendations.sh

generate_recommendations() {
    local cpu_threshold=80
    local mem_threshold=90
    local disk_threshold=85
    
    # CPU Check
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    if (( $(echo "$cpu_usage > $cpu_threshold" | bc -l) )); then
        echo "⚠️ Considere upgrade de CPU ou otimização de processos"
    fi
    
    # Memory Check
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$mem_usage > $mem_threshold" | bc -l) )); then
        echo "⚠️ Aumente a memória RAM ou implemente swap"
    fi
    
    # Disk Check
    disk_usage=$(df -h / | tail -1 | awk '{print $5}' | tr -d '%')
    if (( disk_usage > disk_threshold )); then
        echo "⚠️ Planeje expansão de disco ou limpeza"
    fi
}
```

## Exercícios Práticos

### 🎯 Missão 1: Análise de Capacidade
```bash
# Objetivos:
# 1. Implementar coleta de métricas
# 2. Criar projeções de crescimento
# 3. Estabelecer alertas preventivos
# 4. Documentar recomendações
```

### 🎯 Missão 2: Planejamento Estratégico
```bash
# Desenvolva um plano que:
# 1. Identifique gargalos
# 2. Projete necessidades futuras
# 3. Recomende upgrades
# 4. Otimize recursos existentes
```

## Próximos Passos

1. [Performance Tuning](performance-tuning.md)
2. [Automation Strategies](automation-strategies.md)

---

> "Planeje o futuro hoje para evitar problemas amanhã."

```ascii
    CAPACITY PLANNING
    [📈📈📈📈📈] 100%
    STATUS: OTIMIZADO
    SISTEMA: DIMENSIONADO
```