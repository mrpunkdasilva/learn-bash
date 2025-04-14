# Processamento Distribuído

> Aprenda a implementar processamento distribuído para lidar com grandes volumes de dados de forma eficiente.
> {style="note"}

## Conceitos Básicos

### 🌐 Arquitetura Distribuída
```bash
#!/bin/bash
# Configuração básica de nós
setup_nodes() {
    local nodes=($@)
    for node in "${nodes[@]}"; do
        echo "Configurando nó: $node"
        ssh "$node" "mkdir -p ~/processing"
        scp ./worker.sh "$node:~/processing/"
    done
}
```

### 📦 Divisão de Trabalho
```bash
#!/bin/bash
# Divide dados entre nós
split_workload() {
    local input=$1
    local chunks=$2
    
    # Calcula tamanho de cada chunk
    local total_lines=$(wc -l < "$input")
    local chunk_size=$((total_lines / chunks))
    
    # Divide arquivo em chunks
    split -l "$chunk_size" "$input" chunk_
}
```

## Implementação

### 🚀 Processamento Paralelo
```bash
#!/bin/bash
# Executa processamento em múltiplos nós
distribute_process() {
    local input=$1
    local nodes=("${@:2}")
    
    # Divide trabalho
    split_workload "$input" "${#nodes[@]}"
    
    # Distribui para nós
    local i=0
    for chunk in chunk_*; do
        node="${nodes[i]}"
        echo "Enviando $chunk para $node"
        scp "$chunk" "$node:~/processing/data.txt"
        ssh "$node" "cd ~/processing && ./worker.sh data.txt" &
        ((i++))
    done
    
    # Aguarda conclusão
    wait
    
    # Combina resultados
    for node in "${nodes[@]}"; do
        scp "$node:~/processing/result.txt" "result_${node}.txt"
    done
    cat result_*.txt > final_result.txt
}
```

### 🔄 Sincronização
```bash
#!/bin/bash
# Gerencia sincronização entre nós
sync_nodes() {
    local master=$1
    local nodes=("${@:2}")
    
    # Configura diretório compartilhado
    for node in "${nodes[@]}"; do
        rsync -avz "$master/" "$node:~/shared/"
        ssh "$node" "echo $(date) > ~/shared/sync_status"
    done
}
```

## Monitoramento

### 📊 Status dos Nós
```bash
#!/bin/bash
# Monitora status de cada nó
check_nodes() {
    local nodes=($@)
    for node in "${nodes[@]}"; do
        echo "=== Status de $node ==="
        ssh "$node" "uptime && df -h && free -m"
    done
}
```

### 📈 Métricas de Performance
```bash
#!/bin/bash
# Coleta métricas de processamento
collect_metrics() {
    local nodes=($@)
    echo "timestamp,node,cpu,memory,io" > metrics.csv
    
    for node in "${nodes[@]}"; do
        ssh "$node" "sar 1 1" | \
            awk 'NR==4 {printf "%s,%s,%.2f,%.2f,%.2f\n",
                strftime("%Y-%m-%d %H:%M:%S"),"'$node'",$3,$4,$6
            }' >> metrics.csv
    done
}
```

## Exercícios Práticos

### 🎯 Missão 1: Cluster Básico
```bash
#!/bin/bash
# Objetivos:
# 1. Configurar 3 nós
# 2. Implementar processamento distribuído
# 3. Monitorar performance
# 4. Coletar resultados

# Exemplo de uso
nodes=("node1" "node2" "node3")
setup_nodes "${nodes[@]}"
distribute_process "big_data.txt" "${nodes[@]}"
collect_metrics "${nodes[@]}"
```

## Próximos Passos

1. [Balanceamento de Carga](load-balancing.md)
2. [Tolerância a Falhas](fault-tolerance.md)
3. [Otimização de Performance](performance-optimization.md)

---

> "Divida para conquistar: a essência do processamento distribuído."

```ascii
    DISTRIBUTED PROCESSING
    [⚡⚡⚡⚡⚡] 100%
    STATUS: CLUSTER DOMINADO
    PRÓXIMO: INTEGRAÇÃO COM APIS
```