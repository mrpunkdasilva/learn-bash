# Processamento de Texto

> Todos os exemplos de processamento de texto estão disponíveis em `code/module2/text-proc/text_processing.sh`. Pratique cada comando para dominar o processamento de texto.
> {style="note"}

```ascii
    PROCESSADOR DE TEXTO INICIADO...
    ===============================
    STATUS: PRONTO PARA PROCESSAR
    MODO: TRANSFORMAÇÃO DE DADOS
    ===============================
```

## Ferramentas Fundamentais

### 🔍 Busca e Filtragem
```bash
# Busca com grep
grep "padrão" arquivo.txt     # Busca básica
grep -i "TEXTO" *.log        # Case insensitive
grep -r "TODO" .             # Busca recursiva
grep -v "excluir" dados.txt  # Inverte seleção
```

### ✏️ Edição e Substituição
```bash
# Substituição com sed
sed 's/antigo/novo/' arquivo.txt    # Primeira ocorrência
sed 's/antigo/novo/g' arquivo.txt   # Todas ocorrências
sed -i 's/erro/log/' *.txt         # Edição in-place
sed '1,5d' arquivo.txt             # Remove linhas 1-5
```

### 🔧 Processamento com AWK
```bash
# Processamento de campos
awk '{print $1}' dados.txt         # Primeiro campo
awk '{print $NF}' arquivo.txt      # Último campo
awk -F: '{print $1,$3}' /etc/passwd # Define separador
awk '$3 > 100' números.txt         # Filtra valores
```

## Filtros de Texto

### 📊 Ordenação e Contagem
```bash
# Manipulação básica
sort arquivo.txt              # Ordena linhas
sort -n números.txt          # Ordena numericamente
uniq -c lista.txt           # Conta ocorrências
wc -l arquivo.txt           # Conta linhas
```

### ✂️ Extração e Transformação
```bash
# Manipulação de campos
cut -d',' -f1,3 dados.csv   # Extrai campos
tr 'a-z' 'A-Z' < texto.txt  # Converte case
paste arq1.txt arq2.txt     # Combina arquivos
join -t',' arq1.txt arq2.txt # Join de arquivos
```

## Pipeline de Processamento

### 🔄 Combinando Comandos
```bash
# Análise complexa
cat log.txt | \
    grep "ERROR" | \
    cut -d' ' -f3 | \
    sort | uniq -c | \
    sort -nr

# Extração de dados
cat access.log | \
    awk '{print $1}' | \
    sort | uniq -c | \
    sort -nr | head -10
```

### 📈 Análise de Dados
```bash
# Estatísticas básicas
cat números.txt | \
    awk '{ sum += $1 } 
         END { 
           print "Soma:", sum;
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
# Analise um arquivo de log e extraia:
# 1. Top 10 IPs com mais acessos
# 2. Requisições com erro (código 5xx)
# 3. Total de bytes transferidos
# 4. Horários de pico de acesso
```

### 🎯 Missão 2: Processamento de CSV
```bash
#!/bin/bash
# Processe um arquivo CSV para:
# 1. Calcular média por coluna
# 2. Filtrar registros específicos
# 3. Transformar formato dos dados
# 4. Gerar relatório resumido
```

## Próximos Passos

1. [Expressões Regulares](regular-expressions.md)
2. [Automação de Processamento](text-processing-automation.md)
3. [Análise Avançada](text-analysis.md)

---

> "Texto é o DNA dos dados. Processá-lo é entender a vida do sistema."

```ascii
    PROCESSAMENTO
    [⚙️⚙️⚙️⚙️⚙️] 100%
    STATUS: TEXTO DOMINADO
    PRÓXIMO: REGEX AVANÇADO
```

## Referências Rápidas

### 📚 Comandos Essenciais
- `grep`: Busca padrões em texto
- `sed`: Editor de stream
- `awk`: Processamento de texto por padrões
- `sort`: Ordenação de linhas
- `uniq`: Remove duplicatas
- `cut`: Extrai campos
- `tr`: Traduz/substitui caracteres
- `join`: Combina arquivos por campo comum
- `paste`: Combina arquivos linha a linha
- `wc`: Conta linhas, palavras e caracteres

### 🚀 Dicas de Performance
1. Use `grep -v` ao invés de `sed '/padrão/d'`
2. Prefira `awk` para cálculos numéricos
3. Combine comandos com pipes
4. Use `sort -u` ao invés de `sort | uniq`
5. Aproveite o poder das regex