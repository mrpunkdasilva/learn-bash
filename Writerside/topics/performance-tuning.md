# Performance Tuning

> Aprenda técnicas avançadas para otimizar o desempenho de scripts e operações em lote.
> {style="note"}

## Otimização de Recursos

### 🔄 Gerenciamento de Memória
```bash
# Monitoramento de uso
free -h
vmstat 1
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head

# Limpeza de cache
sync && echo 3 > /proc/sys/vm/drop_caches
```

### ⚡ Controle de CPU
```bash
#!/bin/bash
# cpu_control.sh

optimize_cpu_usage() {
    local pid="$1"
    local cpu_limit="$2"
    
    # Define afinidade CPU
    taskset -pc 0-1 "$pid"
    
    # Limita uso CPU
    cpulimit -p "$pid" -l "$cpu_limit"
}
```

## Técnicas de Otimização

### 📊 Processamento Paralelo
```bash
#!/bin/bash
# parallel_processor.sh

process_data() {
    local input_dir="$1"
    local num_threads="${2:-$(nproc)}"
    
    find "$input_dir" -type f | \
    parallel --jobs "$num_threads" \
             --load 80% \
             --progress \
             './process_file.sh {}'
}
```

### 💾 I/O Otimizado
```bash
#!/bin/bash
# io_optimizer.sh

optimize_io() {
    local file="$1"
    
    # Buffer otimizado
    dd if="$file" of="$file.tmp" bs=1M
    
    # I/O scheduling
    ionice -c 2 -n 7 -p $$
    
    # Async I/O
    aio-stress -s 1G -r 4
}
```

## Monitoramento

### 📈 Métricas de Performance
```bash
#!/bin/bash
# performance_metrics.sh

collect_metrics() {
    local pid="$1"
    local interval="$2"
    
    while true; do
        ps -p "$pid" -o %cpu,%mem,rss,vsz
        sleep "$interval"
    done
}
```

### 🔍 Análise de Gargalos
```bash
#!/bin/bash
# bottleneck_analyzer.sh

analyze_bottlenecks() {
    # CPU
    mpstat 1 5
    
    # Memória
    vmstat 1 5
    
    # I/O
    iostat -xz 1 5
    
    # Rede
    sar -n DEV 1 5
}
```

## Otimizações Específicas

### 🗄️ Banco de Dados
```bash
# Otimização de queries
EXPLAIN ANALYZE SELECT * FROM tabela;

# Índices
CREATE INDEX idx_campo ON tabela(campo);

# Vacuum
VACUUM ANALYZE tabela;
```

### 🌐 Rede
```bash
# Tuning de rede
sysctl -w net.ipv4.tcp_window_scaling=1
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
```

## Ferramentas de Diagnóstico

### 🔧 Profiling
```bash
# Análise de CPU
perf record -F 99 -p "$pid" -g -- sleep 30
perf report

# Análise de memória
valgrind --tool=massif ./programa
ms_print massif.out.*
```

### 📊 Benchmarking
```bash
#!/bin/bash
# benchmark.sh

run_benchmark() {
    local cmd="$1"
    local iterations="$2"
    
    time for ((i=0; i<iterations; i++)); do
        eval "$cmd" >/dev/null 2>&1
    done
}
```

## Boas Práticas

### 💡 Recomendações
1. Profile antes de otimizar
2. Estabeleça métricas base
3. Otimize gargalos principais
4. Monitore continuamente
5. Documente mudanças

### ⚠️ Pontos de Atenção
1. Complexidade vs. Performance
2. Uso de recursos
3. Escalabilidade
4. Manutenibilidade
5. Trade-offs

## Exemplos Práticos

### 📈 Otimização de Script
```bash
#!/bin/bash
# optimized_processor.sh

process_large_file() {
    local input="$1"
    local output="$2"
    
    # Uso de buffer otimizado
    buffer_size="64k"
    
    # Processamento paralelo
    parallel --pipe \
             --block "$buffer_size" \
             --jobs "$(nproc)" \
             "sort | uniq" \
             < "$input" > "$output"
}
```

## Próximos Passos

1. [Monitoramento Avançado](monitoring-advanced.md)
2. [Análise de Sistema](system-analysis.md)
3. [Automação de Performance](performance-automation.md)

---

> "Performance não é um acidente. É o resultado de planejamento inteligente e execução focada."

```ascii
    PERFORMANCE TUNING
    [⚡⚡⚡⚡⚡] 100%
    STATUS: OTIMIZADO
    EFICIÊNCIA: MÁXIMA
```