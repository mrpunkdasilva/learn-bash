# Gerenciamento de Processos 🔄

> Este módulo aborda o gerenciamento de processos no Linux, incluindo monitoramento, controle e otimização.
> {style="note"}

## Comandos Básicos

### 🔍 Visualização de Processos
```bash
# Listar processos
ps aux                # Lista todos os processos
ps -ef               # Formato alternativo
ps -u $USER          # Processos do usuário
top                  # Monitor em tempo real
htop                 # Versão melhorada do top
```

### 🎮 Controle de Processos
```bash
# Sinais básicos
kill PID             # Encerra processo (SIGTERM)
kill -9 PID          # Força encerramento (SIGKILL)
killall processo     # Encerra por nome
pkill processo       # Variação do killall

# Controle de jobs
ctrl+z               # Suspende processo
bg                   # Executa em background
fg                   # Traz para foreground
jobs                 # Lista jobs ativos
```

## Monitoramento Avançado

### 📊 Recursos do Sistema
```bash
# Memória
free -h              # Uso de memória
vmstat 1             # Estatísticas de VM
swapon --show        # Info de swap

# CPU
uptime               # Carga do sistema
mpstat 1             # Estatísticas CPU
iostat               # E/S e CPU
```

### 📈 Monitoramento em Tempo Real
```bash
# Script de monitoramento
watch -n 1 'ps aux --sort=-%cpu | head'  # Top processos CPU
watch -n 1 'ps aux --sort=-%mem | head'  # Top processos memória
```

## Gerenciamento de Prioridade

### ⚡ Nice e Renice
```bash
# Ajuste de prioridade
nice -n 10 comando           # Inicia com prioridade menor
renice -n 10 -p PID         # Ajusta prioridade
renice -n 10 -u usuario     # Ajusta para usuário
```

### 🎯 Limites de Recursos
```bash
# Configurar limites
ulimit -n 2048              # Limite de arquivos
ulimit -u 100              # Limite de processos
ulimit -a                  # Mostra todos limites
```

## Automação e Scripts

### 🤖 Monitoramento Automático
```bash
#!/bin/bash
# monitor_system.sh

while true; do
    # Coleta métricas
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    MEM=$(free -m | awk '/Mem:/ {print $3}')
    
    # Alerta se limites excedidos
    if (( $(echo "$CPU > 80" | bc -l) )); then
        echo "Alerta: CPU alta ($CPU%)"
    fi
    
    sleep 60
done
```

### 🔄 Reinício Automático
```bash
#!/bin/bash
# auto_restart.sh

SERVICE="nginx"

if ! pgrep -x "$SERVICE" > /dev/null; then
    echo "Reiniciando $SERVICE..."
    systemctl restart "$SERVICE"
fi
```

## Técnicas Avançadas

### 🛠️ Diagnóstico de Problemas
```bash
# Análise de processos
strace -p PID        # Trace de syscalls
lsof -p PID         # Arquivos abertos
pmap PID            # Mapa de memória

# Análise de performance
perf top            # Análise CPU
perf record         # Grava dados
perf report         # Analisa dados
```

### 🔒 Isolamento de Processos
```bash
# Controle de recursos
cgcreate -g cpu,memory:grupo1
cgset -r cpu.shares=512 grupo1
cgexec -g cpu,memory:grupo1 comando
```

## Exercícios Práticos

### 🎯 Missão 1: Monitor de Recursos
```bash
#!/bin/bash
# resource_monitor.sh

LOG_FILE="/var/log/resources.log"

monitor_resources() {
    while true; do
        date >> "$LOG_FILE"
        echo "CPU:" >> "$LOG_FILE"
        top -bn1 | head -n 3 >> "$LOG_FILE"
        echo "Memory:" >> "$LOG_FILE"
        free -h >> "$LOG_FILE"
        echo "---" >> "$LOG_FILE"
        sleep 300
    done
}

monitor_resources &
```

### 🎯 Missão 2: Controle de Processos
```bash
#!/bin/bash
# process_control.sh

# Lista processos consumindo muita CPU
find_heavy_processes() {
    ps aux | awk '$3 > 50.0 {print $2,$11,$3"%"}'
}

# Ajusta prioridade automaticamente
auto_adjust() {
    find_heavy_processes | while read pid name cpu; do
        renice -n 10 -p "$pid"
        echo "Ajustado: $name ($pid) - CPU: $cpu"
    done
}
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Processo Zumbi**: Use `ps aux | grep Z`
- **Alto Consumo**: Identifique com `top` ou `htop`
- **Travamento**: Verifique logs com `dmesg`
- **Memória**: Analise com `free` e `vmstat`

---

> "Um sistema bem gerenciado é um sistema eficiente."

```ascii
    MONITORAMENTO ATIVO
    [██████████████] 100%
    STATUS: OTIMIZADO
    PROCESSOS: CONTROLADOS
```