# Análise de Sistema

> Aprenda técnicas avançadas para análise profunda do seu sistema.
> {style="note"}

## Análise de Performance

### 🔍 Profiling Avançado
```bash
#!/bin/bash
# system_profiler.sh

profile_system() {
    echo "=== CPU Profile ==="
    perf stat -a sleep 10
    
    echo "=== Memory Analysis ==="
    vmstat -w 1 10
    
    echo "=== IO Statistics ==="
    iostat -xz 1 10
    
    echo "=== Network Profile ==="
    sar -n DEV 1 10
}

analyze_bottlenecks() {
    # CPU Bottlenecks
    if [ "$(mpstat 1 1 | awk '/Average:/ {print 100-$NF}')" -gt 80 ]; then
        echo "CPU bottleneck detected"
        top -b -n 1 | head -n 20
    fi
    
    # Memory Pressure
    if [ "$(free | awk '/Mem:/ {print $3/$2 * 100.0}')" -gt 90 ]; then
        echo "Memory pressure detected"
        ps aux --sort=-%mem | head -n 10
    fi
    
    # IO Stress
    if [ "$(iostat -x 1 1 | awk '/sda/ {print $NF}')" -gt 80 ]; then
        echo "IO stress detected"
        iotop -b -n 1
    fi
}
```

## Diagnóstico de Sistema

### 🔧 Ferramentas Especializadas
```bash
# Análise de Sistema de Arquivos
analyze_fs() {
    echo "=== File System Analysis ==="
    df -hT
    for mount in $(df -h | grep '^/dev' | awk '{print $NF}'); do
        echo "Analyzing $mount..."
        sudo dumpe2fs -h "$(df -P "$mount" | awk 'NR==2 {print $1}')"
    done
}

# Análise de Processos
analyze_processes() {
    echo "=== Process Analysis ==="
    ps aux --sort=-%cpu | head -n 10
    echo "=== Process Tree ==="
    pstree -p
    echo "=== Open Files ==="
    lsof | awk '{print $1}' | sort | uniq -c | sort -nr | head -n 10
}

# Análise de Rede
analyze_network() {
    echo "=== Network Analysis ==="
    ss -tunapl
    echo "=== Network Statistics ==="
    netstat -s
    echo "=== Interface Statistics ==="
    ip -s link
}
```

## Análise de Logs

### 📊 Log Analytics
```python
import re
from collections import defaultdict
import matplotlib.pyplot as plt

def analyze_logs(log_file):
    patterns = {
        'error': r'ERROR|FATAL|CRITICAL',
        'warning': r'WARN|WARNING',
        'info': r'INFO',
        'debug': r'DEBUG'
    }
    
    stats = defaultdict(int)
    timeline = defaultdict(list)
    
    with open(log_file) as f:
        for line in f:
            timestamp = extract_timestamp(line)
            for level, pattern in patterns.items():
                if re.search(pattern, line):
                    stats[level] += 1
                    timeline[level].append(timestamp)
    
    return stats, timeline

def visualize_logs(stats, timeline):
    # Gráfico de pizza para distribuição de logs
    plt.figure(figsize=(12, 6))
    plt.subplot(1, 2, 1)
    plt.pie(stats.values(), labels=stats.keys(), autopct='%1.1f%%')
    plt.title('Log Level Distribution')
    
    # Timeline de eventos
    plt.subplot(1, 2, 2)
    for level, times in timeline.items():
        plt.plot(times, [level]*len(times), 'o', label=level)
    plt.title('Log Events Timeline')
    plt.legend()
    
    plt.tight_layout()
    plt.show()
```

## Relatórios Automatizados

### 📑 Geração de Relatórios
```bash
#!/bin/bash
# system_report.sh

generate_report() {
    report_file="system_report_$(date +%Y%m%d).md"
    
    {
        echo "# System Analysis Report"
        echo "## Generated: $(date)"
        echo
        
        echo "### System Overview"
        uname -a
        echo
        
        echo "### Resource Usage"
        echo "\`\`\`"
        top -b -n 1 | head -n 10
        echo "\`\`\`"
        
        echo "### Memory Status"
        echo "\`\`\`"
        free -h
        echo "\`\`\`"
        
        echo "### Disk Usage"
        echo "\`\`\`"
        df -h
        echo "\`\`\`"
        
        echo "### Network Status"
        echo "\`\`\`"
        netstat -tuln
        echo "\`\`\`"
        
        echo "### Recent Issues"
        echo "\`\`\`"
        grep -i error /var/log/syslog | tail -n 10
        echo "\`\`\`"
    } > "$report_file"
    
    # Converter para PDF
    pandoc "$report_file" -o "${report_file%.md}.pdf"
}
```

## Exercícios Práticos

### 🎯 Desafio 1: Analisador Completo
Desenvolva um sistema que:
1. Colete métricas abrangentes
2. Analise padrões de uso
3. Identifique gargalos
4. Gere relatórios detalhados

### 🎯 Desafio 2: Dashboard Analítico
Crie um dashboard que:
1. Mostre métricas em tempo real
2. Visualize tendências
3. Destaque anomalias
4. Permita drill-down

## Próximos Passos

1. [Monitoramento Avançado](monitoring-advanced.md)
2. [Automação de Performance](performance-automation.md)
3. [Otimização de Sistema](system-optimization.md)