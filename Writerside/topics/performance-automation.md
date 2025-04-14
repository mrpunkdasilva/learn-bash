# Automação de Performance

> Aprenda a automatizar a otimização de performance do seu sistema.
> {style="note"}

## Otimização Automática

### 🚀 Auto-tuning
```bash
#!/bin/bash
# auto_tuning.sh

# Configurações de Sistema
optimize_system() {
    # Otimizar kernel parameters
    sysctl -w vm.swappiness=10
    sysctl -w vm.vfs_cache_pressure=50
    sysctl -w net.core.somaxconn=65535
    
    # Ajustar limites do sistema
    ulimit -n 65535
    
    # Otimizar I/O scheduler
    for disk in /sys/block/sd*/queue/scheduler; do
        echo "deadline" > "$disk"
    done
}

# Otimização de Processos
optimize_processes() {
    # Ajustar nice level de processos não críticos
    for pid in $(ps aux | awk '$3>50.0 {print $2}'); do
        renice +10 "$pid"
    done
    
    # Limitar recursos de processos intensivos
    for pid in $(ps aux | awk '$3>80.0 {print $2}'); do
        cpulimit -p "$pid" -l 50
    done
}
```

## Performance Monitoring

### 📊 Coleta Automatizada
```python
import psutil
import time
from influxdb_client import InfluxDBClient

def collect_metrics():
    metrics = {
        'cpu_percent': psutil.cpu_percent(interval=1),
        'memory_percent': psutil.virtual_memory().percent,
        'disk_usage': psutil.disk_usage('/').percent,
        'network_io': psutil.net_io_counters()
    }
    
    # Armazenar métricas
    with InfluxDBClient(url="http://localhost:8086", token="your-token") as client:
        write_api = client.write_api()
        write_api.write(
            bucket="performance_metrics",
            record=metrics
        )
    
    return metrics

def analyze_performance(metrics_history):
    # Análise de tendências
    trends = {
        'cpu_trend': calculate_trend(metrics_history['cpu_percent']),
        'memory_trend': calculate_trend(metrics_history['memory_percent']),
        'disk_trend': calculate_trend(metrics_history['disk_usage'])
    }
    
    # Detecção de anomalias
    anomalies = detect_anomalies(metrics_history)
    
    return trends, anomalies
```

## Otimização Automática

### 🔧 Performance Tuning
```bash
#!/bin/bash
# performance_tuner.sh

# Configurações
THRESHOLD_CPU=80
THRESHOLD_MEM=90
THRESHOLD_DISK_IO=70

tune_system() {
    # Monitorar recursos
    while true; do
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
        mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
        disk_io=$(iostat -x 1 1 | awk '/sda/ {print $NF}')
        
        # Ajustes baseados em uso
        if [ "${cpu_usage%.*}" -gt "$THRESHOLD_CPU" ]; then
            optimize_cpu
        fi
        
        if [ "${mem_usage%.*}" -gt "$THRESHOLD_MEM" ]; then
            optimize_memory
        fi
        
        if [ "${disk_io%.*}" -gt "$THRESHOLD_DISK_IO" ]; then
            optimize_io
        fi
        
        sleep 60
    done
}

optimize_cpu() {
    # Identificar processos intensivos
    top_processes=$(ps aux --sort=-%cpu | head -n 5)
    
    # Ajustar prioridades
    while read -r process; do
        pid=$(echo "$process" | awk '{print $2}')
        renice +10 "$pid"
    done <<< "$top_processes"
    
    # Ajustar CPU governor
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        echo "performance" > "$cpu"
    done
}

optimize_memory() {
    # Limpar caches
    sync && echo 3 > /proc/sys/vm/drop_caches
    
    # Ajustar swappiness
    sysctl -w vm.swappiness=10
    
    # Limitar processos com alto uso de memória
    while read -r process; do
        pid=$(echo "$process" | awk '{print $2}')
        memory_limit=$(($(free -m | awk '/Mem:/ {print $2}') / 4))
        cgcreate -g memory:/limited
        cgset -r memory.limit_in_bytes="${memory_limit}M" limited
        cgclassify -g memory:/limited "$pid"
    done <<< "$(ps aux --sort=-%mem | head -n 3)"
}

optimize_io() {
    # Ajustar I/O scheduler
    for disk in /sys/block/sd*/queue/scheduler; do
        echo "deadline" > "$disk"
    done
    
    # Ajustar read ahead
    blockdev --setra 4096 /dev/sda
    
    # Limitar I/O de processos intensivos
    for pid in $(iotop -b -n 1 | awk '$NF>50 {print $1}'); do
        ionice -c 2 -n 7 -p "$pid"
    done
}
```

## Automação de Testes

### 🔬 Performance Testing
```python
import locust
from locust import HttpUser, task, between

class PerformanceTest(HttpUser):
    wait_time = between(1, 3)
    
    @task
    def test_endpoint(self):
        self.client.get("/api/endpoint")
        
    @task
    def test_heavy_operation(self):
        self.client.post("/api/heavy", json={
            "operation": "complex_calculation",
            "data": "large_dataset"
        })
    
    def on_start(self):
        # Setup antes dos testes