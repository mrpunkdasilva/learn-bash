# Integração Sed e AWK

> Aprenda a combinar o poder do Sed e AWK para criar soluções robustas de processamento de texto.
> {style="note"}

## Combinando Ferramentas

### 🔄 Pipeline Básico
```bash
# Sed prepara, AWK processa
sed 's/^[[:space:]]*//; s/[[:space:]]*$//' arquivo.txt | \
awk '{sum += $1} END {print "Total:", sum}'

# AWK filtra, Sed formata
awk '$3 > 1000 {print}' dados.txt | \
sed 's/^/>> /; s/$/ <</'
```

### 🛠️ Scripts Híbridos
```bash
#!/bin/bash
# process_data.sh

# Pré-processamento com Sed
preprocess() {
    sed -e 's/^[[:space:]]*//g' \
        -e 's/[[:space:]]*$//g' \
        -e '/^$/d' \
        -e 's/[[:space:]]\+/ /g'
}

# Processamento com AWK
process() {
    awk -F',' '
        BEGIN {print "Processando dados..."}
        {
            gsub(/"/, "")
            print $1 "\t" $2
        }
    '
}

# Pipeline completo
cat dados.txt | preprocess | process
```

## Casos de Uso

### 📊 Análise de Logs
```bash
#!/bin/bash
# analyze_logs.sh

# Limpa e filtra logs com Sed
sed -e 's/\[[0-9]\+\]//' \
    -e '/^DEBUG/d' \
    -e 's/ERROR/*** ERROR ***/' \
    log.txt |
# Analisa com AWK
awk '
    /ERROR/ {errors++}
    /WARN/  {warnings++}
    END {
        print "Erros:", errors
        print "Avisos:", warnings
    }
'
```

### 📝 Processamento de CSV
```bash
#!/bin/bash
# process_csv.sh

# Normaliza CSV com Sed
sed -e 's/,,/,NA,/g' \
    -e 's/,$/,NA/' \
    -e 's/^,/NA,/' \
    dados.csv |
# Calcula estatísticas com AWK
awk -F',' '
    NR == 1 {
        print "Análise de Dados"
        print "---------------"
        next
    }
    {
        sum[$1] += $2
        count[$1]++
    }
    END {
        for (grupo in sum) {
            printf "%s: %.2f\n", 
                   grupo, 
                   sum[grupo]/count[grupo]
        }
    }
'
```

## Padrões de Integração

### 🎯 Pré-processamento
```bash
# Sed para limpeza inicial
sed -e 's/[[:space:]]*$//' \
    -e '/^#/d' \
    -e '/^$/d' arquivo.txt |
# AWK para transformação
awk '
    BEGIN {
        FS=","
        OFS="\t"
    }
    {
        for(i=1; i<=NF; i++) {
            gsub(/^[[:space:]]+|[[:space:]]+$/, "", $i)
        }
        print
    }
'
```

### 🔄 Transformação de Dados
```bash
# Sed para estruturação
sed -e 's/|/ /g' \
    -e 's/:/,/g' \
    -e 's/  */ /g' dados.txt |
# AWK para formatação
awk -F',' '
    BEGIN {
        printf "%-20s %10s %10s\n",
               "Nome", "Valor", "Total"
        print "-" * 42
    }
    {
        printf "%-20s %10.2f %10.2f\n",
               $1, $2, $2 * $3
    }
'
```

## Boas Práticas

### 💡 Recomendações
1. Use Sed para limpeza inicial
2. AWK para processamento complexo
3. Divida tarefas logicamente
4. Mantenha pipeline legível
5. Documente transformações

### ⚠️ Pontos de Atenção
1. Ordem de processamento
2. Escape de caracteres
3. Consistência de delimitadores
4. Performance em grandes arquivos
5. Tratamento de erros

## Exemplos Práticos

### 📊 Relatório de Dados
```bash
#!/bin/bash
# generate_report.sh

# Configurações
INPUT="dados.csv"
OUTPUT="relatorio.txt"

# Processamento
sed -e 's/,,*/,/g' \
    -e 's/^,//' \
    -e 's/,$//' "$INPUT" |
awk -F',' '
    BEGIN {
        print "Relatório de Dados" > "'$OUTPUT'"
        print "=================" > "'$OUTPUT'"
    }
    NR == 1 {
        for (i=1; i<=NF; i++) {
            headers[i] = $i
        }
        next
    }
    {
        for (i=1; i<=NF; i++) {
            sum[i] += $i
            if (min[i] == "" || $i < min[i]) min[i] = $i
            if (max[i] == "" || $i > max[i]) max[i] = $i
        }
    }
    END {
        for (i=1; i<=NF; i++) {
            printf "\n%s:\n", headers[i] > "'$OUTPUT'"
            printf "  Média: %.2f\n", sum[i]/(NR-1) > "'$OUTPUT'"
            printf "  Min: %s\n", min[i] > "'$OUTPUT'"
            printf "  Max: %s\n", max[i] > "'$OUTPUT'"
        }
    }
'
```

## Próximos Passos

1. [Expressões Regulares Avançadas](regex-advanced.md)
2. [Processamento de Texto Avançado](text-processing-advanced.md)
3. [Automação de Scripts](script-automation.md)

---

> "A combinação de Sed e AWK é como ter uma fábrica de processamento de texto completa em suas mãos."

```ascii
    INTEGRATION MASTERY
    [⚙️⚙️⚙️⚙️⚙️] 100%
    STATUS: INTEGRAÇÃO DOMINADA
    PRÓXIMO: REGEX AVANÇADO
```