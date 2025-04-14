# Filtros de Texto 🔍

> Domine os filtros essenciais para manipulação e transformação de texto no terminal.
> {style="note"}

## Filtros Básicos

### 🔤 Ordenação
```bash
# sort - ordenação de linhas
sort arquivo.txt              # Ordem alfabética
sort -n números.txt          # Ordem numérica
sort -r lista.txt           # Ordem reversa
sort -k2 dados.txt          # Ordena pela coluna 2
sort -u nomes.txt           # Remove duplicatas
```

### 📊 Contagem e Estatísticas
```bash
# uniq - remove/conta duplicatas
uniq -c lista.txt           # Conta ocorrências
uniq -d repetidos.txt       # Mostra só duplicatas
uniq -u únicos.txt         # Mostra só únicos

# wc - conta linhas/palavras/caracteres
wc arquivo.txt              # Todas contagens
wc -l logs/*.log           # Conta linhas
wc -w texto.txt            # Conta palavras
wc -c dados.bin            # Conta bytes
```

## Filtros de Transformação

### ✂️ Extração de Campos
```bash
# cut - extrai colunas
cut -d',' -f1,3 dados.csv   # Campos 1 e 3
cut -c1-10 arquivo.txt      # Primeiros 10 chars
cut -d':' -f1 /etc/passwd   # Extrai usernames

# paste - combina arquivos
paste arq1.txt arq2.txt     # Lado a lado
paste -d',' *.txt           # Une com vírgula
paste -s números.txt        # Uma linha
```

### 🔄 Transformação de Caracteres
```bash
# tr - traduz/deleta caracteres
tr 'a-z' 'A-Z' < texto.txt  # Maiúsculas
tr -d '\r' < dos.txt        # Remove CR
tr -s '\n' < dados.txt      # Comprime vazios
tr '[:space:]' ',' < arq    # Espaços para vírgulas

# expand/unexpand - tabs/espaços
expand arquivo.txt          # Tab para espaços
unexpand -a texto.txt      # Espaços para tab
```

## Filtros Avançados

### 🎯 Seleção de Linhas
```bash
# head/tail - início/fim do arquivo
head -n 5 arquivo.txt       # Primeiras 5 linhas
tail -f log.txt            # Monitora arquivo
head -c 1K dados.bin       # Primeiros 1K bytes
tail -n +10 arquivo.txt    # A partir da linha 10

# sed como filtro
sed -n '10,20p' arquivo    # Linhas 10-20
sed '/^$/d' texto.txt      # Remove vazias
```

### 📝 Formatação de Saída
```bash
# column - formata em colunas
column -t dados.txt         # Alinha colunas
column -s',' -t dados.csv   # CSV em tabela
column -n arquivo.txt       # Numera linhas

# fmt - formata parágrafos
fmt -w 60 texto.txt         # Largura 60
fmt -u arquivo.txt         # Uniforme
```

## Combinando Filtros

### 🔄 Pipelines Comuns
```bash
# Análise de logs
cat access.log | \
    cut -d' ' -f1 | \
    sort | uniq -c | \
    sort -nr | head -10

# Processamento de CSV
cat dados.csv | \
    tr -d '\r' | \
    cut -d',' -f2,4 | \
    sort -t',' -k1 | \
    uniq > resultado.csv
```

### 📊 Análise de Dados
```bash
# Estatísticas básicas
cat números.txt | \
    sort -n | \
    awk '
        BEGIN {print "Análise Numérica"}
        {sum += $1; values[NR] = $1}
        END {
            print "Min:", values[1]
            print "Max:", values[NR]
            print "Média:", sum/NR
        }'

# Contagem de palavras
cat texto.txt | \
    tr -cs '[:alpha:]' '\n' | \
    tr '[:upper:]' '[:lower:]' | \
    sort | uniq -c | sort -nr
```

## Exercícios Práticos

### 🎯 Missão 1: Análise de Logs
```bash
#!/bin/bash
# Objetivos:
# 1. Extrair IPs únicos
# 2. Contar códigos HTTP
# 3. Calcular bytes transferidos
# 4. Identificar User Agents

cat access.log | \
    awk '{print $1}' | sort -u > ips.txt

cat access.log | \
    cut -d'"' -f3 | cut -d' ' -f1 | \
    sort | uniq -c | sort -nr
```

### 🎯 Missão 2: Processamento de Dados
```bash
#!/bin/bash
# Objetivos:
# 1. Limpar dados CSV
# 2. Extrair colunas específicas
# 3. Remover duplicatas
# 4. Formatar saída

cat dados.csv | \
    tr -d '\r' | \
    cut -d',' -f1,3,5 | \
    sort -t',' -k1 | uniq | \
    column -s',' -t > limpo.txt
```

## Dicas e Truques

### 💡 Boas Práticas
1. Use `sort | uniq` em vez de apenas `uniq`
2. Prefira `cut` a `awk` para extrações simples
3. Use `column -t` para saída legível
4. Monitore logs com `tail -f`
5. Combine filtros com pipes

### ⚠️ Armadilhas Comuns
1. Esquecimento de ordenar antes do `uniq`
2. Problemas com delimitadores
3. Encoding incorreto
4. Consumo excessivo de memória

## Próximos Passos

1. [Expressões Regulares](regular-expressions.md)
2. [AWK Avançado](awk-advanced.md)
3. [Sed Avançado](sed-advanced.md)

---

> "Filtros são como LEGO: simples sozinhos, poderosos quando combinados."

```ascii
    FILTER MASTERY
    [⚡⚡⚡⚡⚡] 100%
    STATUS: FILTROS DOMINADOS
    PRÓXIMO: REGEX AVANÇADO
```