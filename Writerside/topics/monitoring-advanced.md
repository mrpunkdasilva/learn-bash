# Monitoramento Avançado

> Este guia apresenta técnicas avançadas de monitoramento para manter seu sistema sob controle total.
> {style="note"}

## Monitoramento Distribuído

### 🌐 Coleta Centralizada
```bash
#!/bin/bash
# central_collector.sh

NODES=("server1" "server2" "server3")
LOG_DIR="/var/log/monitoring"

collect_metrics() {
    for node in "${NODES[@]}"; do
        ssh "$node" '
            cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk "{print \$2}")
            mem_usage=$(free | grep Mem | awk "{print \$3/\$2 * 100.0}")
            disk_usage=$(df -h / | awk "NR==2 {print \$5}" | cut -d% -f1)
            echo "$cpu_usage,$mem_usage,$disk_usage"
        ' >> "$LOG_DIR/${node}_metrics.log"
    done
}

analyze_metrics() {
    for node in "${NODES[@]}"; do
        awk -F',' '
            {
                cpu+=$1; mem+=$2; disk+=$3; count++
            }
            END {
                print "Node: '${node}'"
                print "Avg CPU: " cpu/count "%"
                print "Avg Memory: " mem/count "%"
                print "Avg Disk: " disk/count "%"
            }
        ' "$LOG_DIR/${node}_metrics.log"
    done
}
```

## Análise Preditiva

### 📊 Machine Learning Integration
```python
from sklearn.linear_model import LinearRegression
import pandas as pd

def predict_resource_usage(metrics_file, hours_ahead=24):
    # Carregar dados históricos
    df = pd.read_csv(metrics_file)
    
    # Preparar dados para previsão
    X = df.index.values.reshape(-1, 1)
    y = df['cpu_usage'].values
    
    # Treinar modelo
    model = LinearRegression()
    model.fit(X, y)
    
    # Fazer previsão
    future_points = np.array(range(len(X), len(X) + hours_ahead))
    predictions = model.predict(future_points.reshape(-1, 1))
    
    return predictions
```

## Visualização em Tempo Real

### 📈 Dashboard Dinâmico
```javascript
// dashboard.js
const createDashboard = () => {
    const ctx = document.getElementById('metrics').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: timeLabels,
            datasets: [{
                label: 'CPU Usage',
                data: cpuData,
                borderColor: 'rgb(75, 192, 192)'
            }]
        },
        options: {
            responsive: true,
            realtime: {
                duration: 20000,
                refresh: 1000
            }
        }
    });
};
```

## Alertas Inteligentes

### 🚨 Sistema de Alertas Adaptativo
```bash
#!/bin/bash
# adaptive_alerts.sh

# Configurações dinâmicas
declare -A THRESHOLDS
THRESHOLDS[cpu]=85
THRESHOLDS[memory]=80
THRESHOLDS[disk]=90

# Histórico de alertas
HISTORY_FILE="/var/log/alerts_history.log"

adjust_thresholds() {
    local resource=$1
    local current_value=$2
    
    # Análise do histórico recente
    local alert_frequency=$(grep "$resource" "$HISTORY_FILE" | wc -l)
    
    # Ajuste baseado em padrões
    if [ "$alert_frequency" -gt 10 ]; then
        THRESHOLDS[$resource]=$((THRESHOLDS[$resource] + 5))
    elif [ "$alert_frequency" -eq 0 ]; then
        THRESHOLDS[$resource]=$((THRESHOLDS[$resource] - 2))
    fi
}

send_smart_alert() {
    local resource=$1
    local value=$2
    local threshold=${THRESHOLDS[$resource]}
    
    if [ "$value" -gt "$threshold" ]; then
        # Envia alerta com contexto
        curl -X POST "${WEBHOOK_URL}" \
             -H "Content-Type: application/json" \
             -d "{
                 \"resource\": \"$resource\",
                 \"value\": $value,
                 \"threshold\": $threshold,
                 \"trend\": \"$(analyze_trend $resource)\"
             }"
        
        # Registra no histórico
        echo "$(date) - $resource - $value%" >> "$HISTORY_FILE"
        
        # Ajusta thresholds
        adjust_thresholds "$resource" "$value"
    fi
}
```

## Exercícios Práticos

### 🎯 Desafio 1: Sistema de Monitoramento Completo
Implemente um sistema que:
1. Colete métricas de múltiplos servidores
2. Analise tendências usando ML
3. Gere alertas inteligentes
4. Mantenha dashboard em tempo real

### 🎯 Desafio 2: Análise Preditiva
Desenvolva um sistema que:
1. Preveja problemas de recursos
2. Ajuste thresholds automaticamente
3. Gere relatórios de tendências
4. Sugira otimizações

## Próximos Passos

1. [Análise de Sistema](system-analysis.md)
2. [Automação de Performance](performance-automation.md)
3. [Otimização de Recursos](resource-optimization.md)