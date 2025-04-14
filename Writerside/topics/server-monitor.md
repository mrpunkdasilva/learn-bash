# Monitor de Servidor 

## Visão Geral
Dashboard de monitoramento com métricas em tempo real, alertas configuráveis e interface web.

## Arquitetura
```bash
server-monitor/
├── backend/
│   ├── collector.sh
│   ├── api.py
│   └── alerts.sh
├── frontend/
│   ├── index.html
│   ├── css/
│   └── js/
├── config/
│   └── monitor.yaml
└── data/
```

## Implementação

### 1. Coletor de Métricas
```bash
#!/bin/bash
# backend/collector.sh

collect_metrics() {
    # CPU
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    
    # Memory
    mem_info=$(free -m | grep Mem)
    mem_total=$(echo $mem_info | awk '{print $2}')
    mem_used=$(echo $mem_info | awk '{print $3}')
    
    # Disk
    disk_usage=$(df -h / | tail -1 | awk '{print $5}')
    
    # Save to JSON
    cat > data/metrics.json << EOF
{
    "timestamp": "$(date +%s)",
    "cpu": $cpu_usage,
    "memory": {
        "total": $mem_total,
        "used": $mem_used
    },
    "disk": "${disk_usage}"
}
EOF
}

while true; do
    collect_metrics
    sleep 60
done
```

### 2. API REST (Python/Flask)
```python
# backend/api.py
from flask import Flask, jsonify
import json

app = Flask(__name__)

@app.route('/api/metrics')
def get_metrics():
    with open('data/metrics.json') as f:
        return jsonify(json.load(f))

if __name__ == '__main__':
    app.run(port=5000)
```

### 3. Frontend
```html
<!-- frontend/index.html -->
<!DOCTYPE html>
<html>
<head>
    <title>Server Monitor</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div id="dashboard">
        <div class="metric" id="cpu"></div>
        <div class="metric" id="memory"></div>
        <div class="metric" id="disk"></div>
    </div>
    <script src="js/dashboard.js"></script>
</body>
</html>
```

## Como Executar

1. Inicie o coletor:
```bash
./backend/collector.sh &
```

2. Inicie a API:
```bash
python backend/api.py
```

3. Abra `frontend/index.html` no navegador

## Recursos Adicionais

- Gráficos em tempo real com Chart.js
- Alertas configuráveis
- Histórico de métricas
- Exportação de relatórios