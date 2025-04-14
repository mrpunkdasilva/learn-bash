# AWK Avançado 🚀

> Domine técnicas avançadas de processamento de texto com AWK.
> {style="note"}

## Programação Avançada em AWK

### 🔧 Arrays Associativos
```awk
# Contagem de ocorrências
{
    count[$1]++
}
END {
    for (item in count) {
        printf "%-20s %d\n", item, count[item]
    }
}

# Arrays multidimensionais
{
    data[$1][$2] = $3
}
END {
    for (i in data) {
        for (j in data[i]) {
            print i, j, data[i][j]
        }
    }
}
```

### 🎯 Funções Customizadas
```awk
# Função de formatação
function format_bytes(bytes) {
    units["B"] = 1
    units["KB"] = 1024
    units["MB"] = 1024**2
    units["GB"] = 1024**3
    
    for (unit in units) {
        if (bytes < units[unit] * 1024 || unit == "GB") {
            return sprintf("%.2f %s", bytes/units[unit], unit)
        }
    }
}

# Uso da função
{
    print $1, format_bytes($2)
}
```

## Técnicas Avançadas

### 📊 Processamento de Dados
```awk
# Estatísticas descritivas
{
    sum += $1
    sumsq += $1 * $1
    count++
}
END {
    mean = sum/count
    variance = (sumsq - sum*sum/count)/count
    stddev = sqrt(variance)
    print "Média:", mean
    print "Desvio Padrão:", stddev
}

# Agregações complexas
{
    by_group[$1]["sum"] += $2
    by_group[$1]["count"]++
}
END {
    for (group in by_group) {
        avg = by_group[group]["sum"] / by_group[group]["count"]
        print group, avg
    }
}
```

### 🔄 Processamento de Texto
```awk
# Parser CSV avançado
BEGIN { FS = "," }
{
    gsub(/"([^"]+)"/, "\\1")    # Remove aspas
    gsub(/^\s+|\s+$/, "", $0)   # Trim
    
    for (i=1; i<=NF; i++) {
        gsub(/^\s+|\s+$/, "", $i)
        print "Campo " i ":", $i
    }
}

# Transformação de formato
{
    split($0, fields, ",")    # CSV para array
    json = "{"
    for (i=1; i<=NF; i++) {
        json = json sprintf("\"%s\":\"%s\"%s", 
                          headers[i], 
                          fields[i], 
                          (i==NF ? "" : ","))
    }
    json = json "}"
    print json
}
```

## Integração com Sistema

### 🛠️ Comandos do Sistema
```awk
# Execução de comandos
{
    cmd = sprintf("curl -s %s", $1)
    while ((cmd | getline result) > 0) {
        process_data(result)
    }
    close(cmd)
}

# Logging avançado
function log(level, message) {
    cmd = sprintf("logger -p user.%s \"[AWK] %s\"", 
                 level, 
                 message)
    system(cmd)
}
```

### 📁 Manipulação de Arquivos
```awk
# Processamento multi-arquivo
BEGINFILE {
    print "Processando:", FILENAME
}
{
    # Processamento por arquivo
    file_stats[FILENAME]["lines"]++
    file_stats[FILENAME]["bytes"] += length($0)
}
ENDFILE {
    print "Finalizado:", FILENAME
}
END {
    for (file in file_stats) {
        print file, file_stats[file]["lines"], "linhas"
    }
}
```

## Otimização e Performance

### ⚡ Técnicas de Otimização
```awk
# Cache de resultados
{
    key = $1 SUBSEP $2
    if (!(key in cache)) {
        cache[key] = expensive_calculation($1, $2)
    }
    print cache[key]
}

# Processamento em lote
{
    buffer[NR] = $0
    if (NR % 1000 == 0) {
        process_batch()
        delete buffer
    }
}
END {
    process_batch()
}
```

## Exercícios Práticos

### 🎯 Missão 1: Análise de Logs
```awk
#!/usr/bin/awk -f
# Análise avançada de logs

BEGIN {
    FS = "\\|"
    print "Iniciando análise..."
}

{
    # Agregação por tipo
    types[$1]++
    
    # Análise temporal
    split($2, time, ":")
    hour = time[1]
    hourly[hour]++
    
    # Métricas
    if ($3 > max_value) max_value = $3
}

END {
    report()
}

function report() {
    print "\nDistribuição por tipo:"
    for (t in types) print t ":", types[t]
    
    print "\nDistribuição horária:"
    for (h in hourly) print h "h:", hourly[h]
}
```

### 🎯 Missão 2: ETL
```awk
#!/usr/bin/awk -f
# Transformação de dados

BEGIN {
    FS = ","
    OFS = "\t"
    
    # Configuração
    load_config()
}

function load_config() {
    while ((getline < "config.txt") > 0) {
        config[$1] = $2
    }
}

{
    # Transformação
    for (i=1; i<=NF; i++) {
        $i = transform_field(i, $i)
    }
    print
}

function transform_field(col, val) {
    if (col in config) {
        return apply_rules(val, config[col])
    }
    return val
}
```

## Troubleshooting

### 🔧 Problemas Comuns
1. Gerenciamento de Memória
2. Performance com Grandes Arquivos
3. Encoding e Caracteres Especiais
4. Integração com Sistema

### 💡 Soluções
1. Use processamento em lote
2. Evite arrays desnecessários
3. Configure LOCALE apropriadamente
4. Gerencie recursos do sistema

## Próximos Passos

1. [Sed Avançado](sed-advanced.md)
2. [Automação de Texto](text-automation.md)
3. [Shell Scripting](shell-scripting.md)

---

> "AWK é como uma faca suíça para processamento de texto - versátil e poderosa."

```ascii
    AWK MASTERY
    [🔧🔧🔧🔧🔧] 100%
    STATUS: PROCESSAMENTO DOMINADO
    PRÓXIMO: AUTOMAÇÃO TOTAL
```