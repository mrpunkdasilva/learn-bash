# Automação de Processamento de Texto

> Aprenda a automatizar tarefas repetitivas de processamento de texto com scripts e ferramentas eficientes.
> {style="note"}

## Scripts de Processamento

### 🔄 Processamento em Lote
```bash
#!/bin/bash
# Processa múltiplos arquivos
process_files() {
    local dir=$1
    local pattern=$2
    
    find "$dir" -type f -name "$pattern" | while read -r file; do
        echo "Processando: $file"
        # Remove linhas vazias
        sed -i '/^$/d' "$file"
        # Converte para minúsculas
        tr '[:upper:]' '[:lower:]' < "$file" > "${file}.tmp"
        mv "${file}.tmp" "$file"
        # Remove espaços extras
        sed -i 's/[[:space:]]\+/ /g' "$file"
    done
}

# Uso: process_files "./logs" "*.log"
```

### 📝 Transformação de Dados
```bash
#!/bin/bash
# Converte formatos de dados
convert_data() {
    local input=$1
    local output=$2
    local format=$3

    case $format in
        "csv2json")
            awk -F',' '
                BEGIN { print "[" }
                NR == 1 { 
                    split($0, headers)
                    next 
                }
                {
                    printf "  {"
                    for (i=1; i<=NF; i++)
                        printf "\"%s\": \"%s\"%s", 
                               headers[i], $i, 
                               (i==NF ? "" : ",")
                    print "}" (NR==NR ? "" : ",")
                }
                END { print "]" }
            ' "$input" > "$output"
            ;;
        "json2csv")
            # Implementar conversão JSON para CSV
            ;;
    esac
}
```

## Monitoramento e Processamento

### 👀 Monitoramento de Arquivos
```bash
#!/bin/bash
# Monitor de mudanças em arquivos
watch_and_process() {
    local dir=$1
    local pattern=$2
    local cmd=$3

    inotifywait -m -e modify,create "$dir" |
        while read -r directory events filename; do
            if [[ "$filename" =~ $pattern ]]; then
                echo "Mudança detectada em: $filename"
                eval "$cmd \"$directory/$filename\""
            fi
        done
}

# Uso: watch_and_process "./logs" "*.log" "process_log"
```

### 🔄 Processamento Contínuo
```bash
#!/bin/bash
# Processamento em tempo real
stream_process() {
    local input=$1
    
    tail -f "$input" | while read -r line; do
        # Processa cada linha em tempo real
        echo "$line" | \
            grep -v '^#' | \
            awk '{print strftime("%Y-%m-%d %H:%M:%S"), $0}'
    done
}
```

## Templates e Geradores

### 📋 Geração de Relatórios
```bash
#!/bin/bash
# Gerador de relatórios
generate_report() {
    local data=$1
    local template=$2
    local output=$3

    # Carrega template
    cat "$template" | while read -r line; do
        # Substitui variáveis
        line=${line//\{\{DATA\}\}/$(date +%Y-%m-%d)}
        line=${line//\{\{STATS\}\}/$(calculate_stats "$data")}
        echo "$line" >> "$output"
    done
}

# Template exemplo:
# Relatório de {{DATA}}
# ===================
# Estatísticas:
# {{STATS}}
```

### 🔧 Processamento Customizado
```bash
#!/bin/bash
# Framework de processamento
process_framework() {
    local input=$1
    local config=$2

    # Carrega configurações
    source "$config"

    # Pipeline de processamento
    cat "$input" | \
        ${PRE_PROCESS:-cat} | \
        ${MAIN_PROCESS:-cat} | \
        ${POST_PROCESS:-cat} > \
        "${input}.processed"
}

# Arquivo de configuração exemplo:
# PRE_PROCESS="tr -d '\r'"
# MAIN_PROCESS="awk -F',' '{print \$1,\$3}'"
# POST_PROCESS="sort | uniq"
```

## Automação Avançada

### 🚀 Paralelização
```bash
#!/bin/bash
# Processamento paralelo
parallel_process() {
    local dir=$1
    local workers=${2:-4}

    find "$dir" -type f -name "*.txt" | \
        parallel --jobs "$workers" \
        'echo "Processando {}"; process_file "{}"'
}

# Processamento em lotes
batch_process() {
    local input=$1
    local batch_size=${2:-1000}
    
    split -l "$batch_size" "$input" temp_batch_
    ls temp_batch_* | parallel process_batch
    rm temp_batch_*
}
```

### 📊 Agregação de Resultados
```bash
#!/bin/bash
# Combina resultados
aggregate_results() {
    local dir=$1
    local pattern=$2

    # Cabeçalho
    echo "Data,Total,Média,Máximo" > resultados.csv

    # Combina e processa resultados
    find "$dir" -name "$pattern" -type f | \
        while read -r file; do
            awk -F',' '
                NR > 1 {
                    sum += $2
                    if ($2 > max) max = $2
                    count++
                }
                END {
                    printf "%s,%.2f,%.2f,%.2f\n",
                        FILENAME, sum, sum/count, max
                }' "$file" >> resultados.csv
        done
}
```

## Exercícios Práticos

### 🎯 Missão 1: Pipeline de Logs
```bash
#!/bin/bash
# Objetivos:
# 1. Monitorar diretório de logs
# 2. Processar novos arquivos
# 3. Gerar alertas
# 4. Arquivar processados

# Implementação básica
monitor_logs() {
    watch_and_process "./logs" "*.log" \
        'process_log "{}" && \
         generate_alert "{}" && \
         archive_log "{}"'
}
```

### 🎯 Missão 2: ETL Automatizado
```bash
#!/bin/bash
# Objetivos:
# 1. Extrair dados de múltiplas fontes
# 2. Transformar formatos
# 3. Carregar em destino
# 4. Validar resultados

# Implementação básica
etl_pipeline() {
    extract_data
    transform_data
    load_data
    validate_results
}
```

## Dicas e Boas Práticas

### 💡 Recomendações
1. Use funções para código reutilizável
2. Implemente logging adequado
3. Trate erros apropriadamente
4. Documente configurações
5. Faça backup antes de processamentos

### ⚠️ Pontos de Atenção
1. Monitore uso de recursos
2. Implemente timeouts
3. Valide entradas
4. Teste com amostras pequenas
5. Mantenha logs de execução

## Próximos Passos

1. [Processamento Distribuído](distributed-processing.md)
2. [Integração com APIs](api-integration.md)
3. [Orquestração de Workflows](workflow-orchestration.md)

---

> "Automatize o repetitivo, foque no criativo."

```ascii
    AUTOMATION MASTER
    [🤖🤖🤖🤖🤖] 100%
    STATUS: AUTOMAÇÃO DOMINADA
    PRÓXIMO: PROCESSAMENTO DISTRIBUÍDO
```