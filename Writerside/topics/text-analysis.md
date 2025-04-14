# Análise de Texto 

> Aprenda técnicas avançadas para analisar e extrair insights de dados textuais.
> {style="note"}

## Análise Básica

### 📊 Estatísticas de Texto
```bash
# Contagens básicas
wc -l arquivo.txt           # Total de linhas
wc -w texto.txt            # Total de palavras
wc -c dados.txt            # Total de caracteres

# Análise de vocabulário
cat texto.txt | \
    tr -cs '[:alpha:]' '\n' | \
    sort | uniq -c | \
    sort -nr | head -10     # Top 10 palavras
```

### 📈 Análise Numérica
```bash
# Estatísticas numéricas
cat números.txt | \
    sort -n | \
    awk '
        BEGIN { print "=== Análise Numérica ===" }
        { 
            sum += $1
            values[NR] = $1 
        }
        END {
            print "Mínimo:", values[1]
            print "Máximo:", values[NR]
            print "Total:", sum
            print "Média:", sum/NR
            print "Registros:", NR
        }'
```

## Análise de Logs

### 🔍 Padrões de Acesso
```bash
# Análise de logs de acesso
cat access.log | \
    awk '{print $1}' | \
    sort | uniq -c | \
    sort -nr | head -10     # Top 10 IPs

# Códigos de status HTTP
cat access.log | \
    awk '{print $9}' | \
    sort | uniq -c | \
    sort -nr                # Distribuição de status
```

### ⚠️ Análise de Erros
```bash
# Detecção de erros
grep -i "error" error.log | \
    awk -F'[][]' '{print $2}' | \
    sort | uniq -c | \
    sort -nr                # Tipos de erro

# Timeline de erros
grep -i "error" error.log | \
    awk '{print $1, $2}' | \
    sort -k1,2              # Ordenado por timestamp
```

## Análise de Dados

### 📊 Análise de CSV
```bash
# Estatísticas por coluna
awk -F',' '
    NR > 1 {               # Pula cabeçalho
        sum[$1] += $2      # Soma por categoria
        count[$1]++        # Conta ocorrências
    }
    END {
        for (cat in sum)
            print cat, sum[cat]/count[cat]
    }' dados.csv | sort -k2nr

# Filtragem e agregação
awk -F',' '$3 > 1000 {     # Filtra valores
    sum += $4              # Soma coluna 4
    count++                # Conta registros
} END {
    print "Média:", sum/count
}' dados.csv
```

### 📈 Séries Temporais
```bash
# Análise por período
awk '
    {
        hora = substr($4, 14, 2)    # Extrai hora
        count[hora]++               # Conta por hora
    }
    END {
        for (h in count)
            print h, count[h]
    }' access.log | sort -n

# Tendências
cat métricas.log | \
    awk '{print $1, $2}' | \
    sort -k1,1 | \
    awk '
        {
            sum += $2
            values[NR] = $2
        }
        END {
            print "Tendência:", 
            values[NR] > values[1] ? "↑" : "↓"
        }'
```

## Ferramentas de Análise

### 🔧 Scripts Úteis
```bash
#!/bin/bash
# Análise completa de texto
analyze_text() {
    local file=$1
    echo "=== Análise de $file ==="
    echo "Linhas: $(wc -l < "$file")"
    echo "Palavras: $(wc -w < "$file")"
    echo "Caracteres: $(wc -c < "$file")"
    echo "Top 5 palavras:"
    tr -cs '[:alpha:]' '\n' < "$file" | \
        sort | uniq -c | sort -nr | head -5
}

# Análise de performance
analyze_perf() {
    local log=$1
    echo "=== Performance ==="
    awk '
        $9 >= 500 { erros++ }
        { tempo += $10 }
        END {
            print "Erros:", erros
            print "Tempo médio:", tempo/NR
        }' "$log"
}
```

### 📊 Visualização Básica
```bash
# Histograma ASCII
cat dados.txt | \
    sort -n | uniq -c | \
    awk '{ printf "%3d: %s\n", $2, 
          repeat("█", int($1/5)) }
    function repeat(s,n) {
        return n <= 0 ? "" : s repeat(s,n-1)
    }'

# Gráfico de barras
cat stats.txt | \
    awk '{ printf "%-10s |%s\n", $1,
          repeat("=", int($2/100)) }
    function repeat(s,n) {
        return n <= 0 ? "" : s repeat(s,n-1)
    }'
```

## Exercícios Práticos

### 🎯 Missão 1: Análise de Logs
```bash
#!/bin/bash
# Objetivos:
# 1. Identificar padrões de acesso
# 2. Detectar anomalias
# 3. Gerar relatório de performance
# 4. Visualizar tendências

analyze_logs() {
    local log=$1
    # Sua implementação aqui
}
```

### 🎯 Missão 2: Análise de Dados
```bash
#!/bin/bash
# Objetivos:
# 1. Calcular estatísticas
# 2. Identificar outliers
# 3. Gerar visualizações
# 4. Exportar relatório

analyze_data() {
    local data=$1
    # Sua implementação aqui
}
```

## Próximos Passos

1. [Automação de Análise](text-processing-automation.md)
2. [Visualização Avançada](data-visualization.md)
3. [Machine Learning Básico](basic-ml.md)

---

> "Dados são apenas dados até serem analisados. Depois, tornam-se conhecimento."

```ascii
    TEXT ANALYSIS
    [📊📊📊📊📊] 100%
    STATUS: ANALISTA DE DADOS
    PRÓXIMO: AUTOMAÇÃO AVANÇADA
```