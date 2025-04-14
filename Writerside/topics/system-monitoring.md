# Monitoramento de Sistema: Vigilância Contínua 🔍

## Ferramentas Essenciais

### 📊 Monitoramento em Tempo Real
```bash
# Monitoramento básico
top         # Visão geral do sistema
htop        # Interface interativa
atop        # Histórico de processos
iotop       # Monitoramento de I/O
```

### 📈 Análise de Recursos
```bash
# CPU e Memória
vmstat 1    # Estatísticas de VM
free -h     # Uso de memória
mpstat -P ALL  # Estatísticas por CPU
sar -u 1 5    # Utilização de CPU
```

## Scripts de Monitoramento

### 🔄 Monitor de Recursos
```bash
#!/bin/bash
# resource_monitor.sh

monitor_resources() {
    while true; do
        printf "\n=== %s ===\n" "$(date)"
        
        echo "CPU Usage:"
        top -bn1 | head -n 3
        
        echo -e "\nMemory Usage:"
        free -h
        
        echo -e "\nDisk Usage:"
        df -h
        
        sleep 60
    done
}
```

### 🚨 Sistema de Alertas
```bash
#!/bin/bash
# alert_system.sh

check_threshold() {
    local metric="$1"
    local threshold="$2"
    local current="$3"
    
    if (( $(echo "$current > $threshold" | bc -l) )); then
        send_alert "$metric" "$current" "$threshold"
    fi
}

monitor_with_alerts() {
    # CPU threshold (80%)
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    check_threshold "CPU" 80 "$cpu_usage"
    
    # Memory threshold (90%)
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    check_threshold "Memory" 90 "$mem_usage"
    
    # Disk threshold (85%)
    disk_usage=$(df -h / | tail -1 | awk '{print $5}' | tr -d '%')
    check_threshold "Disk" 85 "$disk_usage"
}
```

## Logging e Análise

### 📝 Sistema de Logs
```bash
#!/bin/bash
# system_logger.sh

log_system_stats() {
    local log_file="/var/log/system_stats.log"
    local date_format="+%Y-%m-%d %H:%M:%S"
    
    while true; do
        {
            echo "=== $(date "$date_format") ==="
            echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
            echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')"
            echo "Memory Free: $(free -h | grep Mem | awk '{print $4}')"
            echo "Disk Usage: $(df -h / | tail -1 | awk '{print $5}')"
            echo "---"
        } >> "$log_file"
        
        sleep 300
    done
}
```

### 📊 Análise de Logs
```bash
#!/bin/bash
# log_analyzer.sh

analyze_logs() {
    local log_file="$1"
    local start_date="$2"
    local end_date="$3"
    
    echo "=== Análise de Logs ==="
    echo "Período: $start_date até $end_date"
    
    # CPU médio
    echo -n "CPU Médio: "
    awk '/CPU Usage:/ {sum+=$3; count++} 
         END {print sum/count "%"}' "$log_file"
    
    # Picos de memória
    echo "Picos de Memória:"
    grep "Memory Free:" "$log_file" | sort -k4 -h | head -5
    
    # Tendência de disco
    echo "Tendência de Uso de Disco:"
    grep "Disk Usage:" "$log_file" | 
        awk '{print $3}' | 
        sort -n | 
        uniq -c
}
```

## Visualização de Dados

### 📈 Geração de Gráficos
```bash
#!/bin/bash
# graph_generator.sh

generate_graphs() {
    local data_file="$1"
    local output_dir="$2"
    
    # Requer gnuplot
    gnuplot <<EOF
    set terminal png
    set output "$output_dir/cpu_usage.png"
    set title "CPU Usage Over Time"
    set xlabel "Time"
    set ylabel "Usage %"
    plot "$data_file" using 1:2 with lines
EOF
}
```

## Exercícios Práticos

### 🎯 Missão 1: Monitor Completo
```bash
# Desenvolva um sistema que:
# 1. Monitore todos recursos críticos
# 2. Gere alertas configuráveis
# 3. Mantenha histórico de métricas
# 4. Gere relatórios periódicos
```

### 🎯 Missão 2: Análise Preditiva
```bash
# Crie um sistema que:
# 1. Identifique padrões de uso
# 2. Preveja possíveis problemas
# 3. Sugira otimizações
# 4. Gere relatórios de tendências
```

## Próximos Passos

1. [Performance Tuning](performance-tuning.md)
2. [Capacity Planning](capacity-planning.md)
3. [Automation Strategies](automation-strategies.md)

---

> "Monitorar é prever. Prever é prevenir."

```ascii
    MONITORAMENTO
    [📊📊📊📊📊] 100%
    STATUS: ATIVO
    SISTEMA: MONITORADO
```