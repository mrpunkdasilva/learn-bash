# Controle de Processos

> Este tópico aborda o gerenciamento e controle de processos no Linux, incluindo monitoramento, manipulação e otimização.
> {style="note"}

## Comandos Básicos

### 🔍 Visualização de Processos
```bash
# Listar processos
ps aux                # Lista detalhada
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
# Memória e CPU
free -h              # Uso de memória
vmstat 1             # Estatísticas de VM
mpstat 1             # Estatísticas CPU
iostat               # E/S e CPU

# Monitoramento em tempo real
watch -n 1 'ps aux --sort=-%cpu | head'  # Top processos CPU
watch -n 1 'ps aux --sort=-%mem | head'  # Top processos memória
```

### ⚡ Prioridade e Recursos
```bash
# Ajuste de prioridade
nice -n 10 comando           # Inicia com prioridade menor
renice -n 10 -p PID         # Ajusta prioridade
renice -n 10 -u usuario     # Ajusta para usuário

# Limites de recursos
ulimit -n 2048              # Limite de arquivos
ulimit -u 100              # Limite de processos
ulimit -a                  # Mostra todos limites
```

## Scripts de Automação

### 🤖 Monitor de Processos
```bash
#!/bin/bash
# process_monitor.sh

monitor_process() {
    local processo="$1"
    local max_cpu="$2"
    local max_mem="$3"
    
    while true; do
        # Obtém uso de CPU e memória
        cpu=$(ps -p $(pgrep "$processo") -o %cpu= 2>/dev/null)
        mem=$(ps -p $(pgrep "$processo") -o %mem= 2>/dev/null)
        
        # Verifica limites
        if (( $(echo "$cpu > $max_cpu" | bc -l) )); then
            echo "ALERTA: $processo usando muita CPU ($cpu%)"
        fi
        
        if (( $(echo "$mem > $max_mem" | bc -l) )); then
            echo "ALERTA: $processo usando muita memória ($mem%)"
        fi
        
        sleep 60
    done
}
```

### 🔄 Reinício Automático
```bash
#!/bin/bash
# auto_restart.sh

watch_and_restart() {
    local processo="$1"
    local max_restarts=3
    local count=0
    
    while true; do
        if ! pgrep -x "$processo" > /dev/null; then
            if [ $count -lt $max_restarts ]; then
                echo "Reiniciando $processo..."
                systemctl restart "$processo"
                ((count++))
            else
                echo "Limite de reinícios atingido para $processo"
                break
            fi
        fi
        sleep 30
    done
}
```

## Técnicas Avançadas

### 🔍 Diagnóstico
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

### 🔒 Isolamento
```bash
# Controle de recursos com cgroups
cgcreate -g cpu,memory:grupo1
cgset -r cpu.shares=512 grupo1
cgexec -g cpu,memory:grupo1 comando
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Processo Zumbi**: Use `ps aux | grep Z`
- **Alto Consumo**: Identifique com `top` ou `htop`
- **Travamento**: Verifique logs com `dmesg`
- **Memória**: Analise com `free` e `vmstat`

---

> "Um processo bem controlado é um sistema estável."