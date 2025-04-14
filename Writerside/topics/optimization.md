# Otimização

> Técnicas e estratégias para melhorar a eficiência e performance de scripts.
> {style="note"}

## Estratégias Básicas

### 🚀 Otimização de Loop
```bash
# ❌ Não otimizado
for file in $(ls); do
    process "$file"
done

# ✅ Otimizado
for file in *; do
    process "$file"
done
```

### 💾 I/O Eficiente
```bash
#!/bin/bash
# io_optimizer.sh

# ❌ Não otimizado
while read -r line; do
    echo "$line" >> output.txt
done < input.txt

# ✅ Otimizado
{
    while read -r line; do
        process "$line"
    done
} < input.txt > output.txt
```

## Técnicas Avançadas

### 🔄 Paralelização
```bash
#!/bin/bash
# parallel_processor.sh

process_parallel() {
    local input_dir="$1"
    local max_jobs="${2:-$(nproc)}"
    
    find "$input_dir" -type f | \
    parallel --jobs "$max_jobs" \
             --load 80% \
             ./process_file.sh {}
}
```

### 🗃️ Cache
```bash
#!/bin/bash
# cache_manager.sh

cache_result() {
    local key="$1"
    local value="$2"
    local cache_file="/tmp/cache.txt"
    
    echo "$key:$value" >> "$cache_file"
}

get_cached() {
    local key="$1"
    local cache_file="/tmp/cache.txt"
    
    grep "^$key:" "$cache_file" | cut -d: -f2
}
```

## Otimizações Específicas

### 📝 Processamento de Texto
```bash
#!/bin/bash
# text_optimizer.sh

# ❌ Não otimizado
cat file.txt | grep pattern | sort | uniq

# ✅ Otimizado
grep -h pattern file.txt | sort -u
```

### 🔍 Busca
```bash
#!/bin/bash
# search_optimizer.sh

# ❌ Não otimizado
find . -type f -exec grep "pattern" {} \;

# ✅ Otimizado
find . -type f -print0 | xargs -0 grep -l "pattern"
```

## Ferramentas de Análise

### 📊 Profiling
```bash
#!/bin/bash
# profiler.sh

profile_script() {
    local script="$1"
    PS4='+ $(date "+%s.%N") ' bash -x "$script" 2>&1 | \
        grep '^+' | \
        sort -n -k2
}
```

### ⏱️ Benchmarking
```bash
#!/bin/bash
# benchmark.sh

benchmark() {
    local cmd="$1"
    local iterations="${2:-3}"
    
    for ((i=1; i<=iterations; i++)); do
        time eval "$cmd"
    done
}
```

## Boas Práticas

### 💡 Recomendações
1. Profile antes de otimizar
2. Otimize os gargalos
3. Use ferramentas nativas
4. Evite subshells desnecessários
5. Minimize I/O em disco

### ⚠️ Pontos de Atenção
1. Legibilidade vs Performance
2. Uso de memória
3. Complexidade do código
4. Manutenibilidade
5. Trade-offs

## Exemplos Práticos

### 📈 Script Otimizado
```bash
#!/bin/bash
# optimized_processor.sh

readonly BUFFER_SIZE="64k"
readonly MAX_JOBS="$(nproc)"

process_files() {
    local input_dir="$1"
    local output_dir="$2"
    
    mkdir -p "$output_dir"
    
    find "$input_dir" -type f -print0 | \
    parallel -0 \
            --jobs "$MAX_JOBS" \
            --buffer-size "$BUFFER_SIZE" \
            ./process_single.sh {} "$output_dir"
}
```

## Próximos Passos

1. [Performance Tuning](performance-tuning.md)
2. [Monitoramento](monitoring.md)
3. [Automação](automation.md)

---

> "Otimização é a arte de fazer mais com menos."

```ascii
    OPTIMIZATION
    [⚡⚡⚡⚡⚡] 100%
    STATUS: OTIMIZADO
    PRÓXIMO: PERFORMANCE
```