# Manipulação de Texto

> Aprenda técnicas avançadas para manipulação e transformação de texto no terminal.
> {style="note"}

## Transformações Básicas

### 🔄 Substituição de Texto
```bash
# Substituições simples
tr 'a-z' 'A-Z' < texto.txt     # Converte para maiúsculas
tr -d '\r' < arquivo.dos       # Remove retornos de carro
tr -s '[:space:]' ' '          # Comprime espaços

# Substituições com sed
sed 's/antigo/novo/g'          # Substitui todas ocorrências
sed 's/^/    /'               # Indenta linhas
sed 's/[[:space:]]*$//'       # Remove espaços no fim
```

### ✂️ Recorte e Junção
```bash
# Manipulação de linhas
cut -d',' -f1-3 dados.csv     # Seleciona campos
paste arq1 arq2               # Combina arquivos
join -t',' arq1 arq2          # Join em campo comum
split -l 1000 arquivo.txt     # Divide em arquivos menores
```

## Transformações Avançadas

### 📊 Formatação de Dados
```bash
# Conversão de formatos
# CSV para TSV
sed 's/,/\t/g' dados.csv

# JSON para linha única
tr -d '\n' < dados.json | \
    sed 's/} /}\n/g'

# Tabela para CSV
column -t -s'|' dados.txt | \
    sed 's/  */,/g'
```

### 🔠 Manipulação de Strings
```bash
# Operações com strings
# Extrai substring
cut -c1-10 arquivo.txt

# Inverte string
rev texto.txt

# Capitaliza primeira letra
sed 's/\b\(.\)/\u\1/g'

# Remove caracteres especiais
tr -cd '[:alnum:][:space:]'
```

## Casos de Uso Comuns

### 📝 Limpeza de Dados
```bash
# Pipeline de limpeza
cat dados.txt | \
    tr -d '\r' | \                  # Remove CR
    tr -s '[:space:]' ' ' | \       # Normaliza espaços
    sed 's/^ *//;s/ *$//' | \       # Remove espaços
    grep -v '^$' | \                # Remove linhas vazias
    tr '[:upper:]' '[:lower:]'      # Converte case
```

### 🔍 Extração de Informações
```bash
# Extrai emails
grep -Eo '[[:alnum:].]+@[[:alnum:].]+\.[[:alpha:]]{2,}'

# Extrai URLs
grep -Eo 'https?://[^[:space:]]+'

# Extrai números de telefone
grep -Eo '[0-9]{2}[ -]?[0-9]{4,5}[-]?[0-9]{4}'
```

## Automação de Tarefas

### 📋 Templates e Substituição
```bash
# Template com variáveis
cat template.txt | \
    sed "s/{{nome}}/$NOME/g" | \
    sed "s/{{data}}/$DATA/g" | \
    sed "s/{{versao}}/$VERSAO/g"

# Geração de código
cat << EOF > config.json
{
    "app": "$APP_NAME",
    "version": "$VERSION",
    "env": "$ENV"
}
EOF
```

### 🔄 Processamento em Lote
```bash
# Renomeia arquivos em lote
for f in *.txt; do
    mv "$f" "${f%.txt}.md"
done

# Processa múltiplos arquivos
find . -name "*.log" -type f | \
    while read file; do
        sed -i 's/ERROR/ERRO/g' "$file"
    done
```

## Exercícios Práticos

### 🎯 Missão 1: Formatação de Dados
```bash
#!/bin/bash
# Objetivos:
# 1. Converter CSV para formato tabular
# 2. Alinhar colunas
# 3. Adicionar cabeçalho
# 4. Numerar linhas

cat dados.csv | \
    tr ',' '\t' | \
    column -t | \
    nl -w3 -s'. ' > tabela.txt
```

### 🎯 Missão 2: Transformação de Logs
```bash
#!/bin/bash
# Objetivos:
# 1. Extrair campos específicos
# 2. Formatar timestamps
# 3. Categorizar eventos
# 4. Gerar relatório

cat access.log | \
    awk '{print $4, $6, $7}' | \
    sed 's/\[//;s/\]//' | \
    sort -k1,1 | \
    uniq -c > report.txt
```

## Dicas e Truques

### 💡 Boas Práticas
1. Faça backup antes de transformações
2. Use expressões regulares com moderação
3. Teste em amostra pequena primeiro
4. Documente transformações complexas
5. Mantenha scripts reutilizáveis

### ⚠️ Armadilhas Comuns
1. Encoding incorreto
2. Caracteres especiais não tratados
3. Substituições muito agressivas
4. Perda de dados não intencional

## Próximos Passos

1. [Análise de Texto](text-analysis.md)
2. [Automação de Processamento](text-processing-automation.md)
3. [Expressões Regulares Avançadas](advanced-regex.md)

---

> "A arte da manipulação de texto está em transformar dados brutos em informação útil."

```
    TEXT MANIPULATION
    [🔧🔧🔧🔧🔧] 100%
    STATUS: TRANSFORMADOR DE TEXTO
    PRÓXIMO: ANÁLISE AVANÇADA
```