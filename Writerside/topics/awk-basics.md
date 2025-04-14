# Fundamentos do AWK 

> AWK é uma linguagem de programação projetada para processamento de texto, especialmente poderosa para trabalhar com dados tabulares.
> {style="note"}

## Sintaxe Básica

### 🎯 Estrutura Fundamental
```bash
# Formato básico
awk 'padrão { ação }' arquivo.txt

# Exemplos simples
awk '{print $1}' dados.txt      # Primeiro campo
awk '{print $NF}' arquivo.txt   # Último campo
awk '{print NR, $0}' texto.txt  # Número da linha e conteúdo
```

### 🔄 Separadores de Campo
```bash
# Separador padrão (espaço/tab)
awk '{print $1, $2}' dados.txt

# Definindo separador
awk -F: '{print $1}' /etc/passwd
awk -F',' '{print $1}' dados.csv
awk 'BEGIN{FS=":"} {print $1}' arquivo.txt
```

## Variáveis Especiais

### 📝 Variáveis Internas
```bash
NR      # Número da linha atual
NF      # Número de campos na linha
$0      # Linha inteira
$1-$n   # Campos individuais
FILENAME # Nome do arquivo atual
FS      # Separador de campo (input)
OFS     # Separador de campo (output)
RS      # Separador de registro (input)
ORS     # Separador de registro (output)
```

## Padrões e Ações

### 🎯 Seleção de Linhas
```bash
# Filtragem básica
awk 'NR==1' arquivo.txt         # Primeira linha
awk 'NR>1' arquivo.txt          # Pula cabeçalho
awk '/padrão/' arquivo.txt      # Linhas com padrão
awk 'length>80' arquivo.txt     # Linhas longas
```

### 🔢 Operações Matemáticas
```bash
# Soma de coluna
awk '{sum += $1} END {print sum}' números.txt

# Média
awk '{sum += $1} END {print sum/NR}' dados.txt

# Contagem
awk '{count[$1]++} END {for (i in count) print i, count[i]}' log.txt
```

## Controle de Fluxo

### 🔄 Estruturas de Controle
```bash
# If-else
awk '{
    if ($3 > 100) 
        print "Alto: " $0
    else 
        print "Baixo: " $0
}' dados.txt

# Loops
awk '{
    for (i=1; i<=NF; i++) 
        print $i
}' arquivo.txt
```

### 🎬 Blocos Especiais
```bash
# BEGIN - antes de processar
awk 'BEGIN {print "Iniciando..."} 
     {print $0} 
     END {print "Fim!"}' arquivo.txt

# END - após processar
awk '{sum += $1} 
     END {print "Total:", sum}' números.txt
```

## Funções Integradas

### 📚 Funções de String
```bash
# Manipulação de texto
length($0)           # Comprimento
substr($1, 1, 3)     # Substring
toupper($1)          # Maiúsculas
tolower($1)          # Minúsculas
gsub(/a/, "b")       # Substituição global
```

### 🔢 Funções Matemáticas
```bash
# Operações matemáticas
int($1)              # Parte inteira
sqrt($1)             # Raiz quadrada
rand()               # Número aleatório
sin($1), cos($1)     # Trigonometria
```

## Exemplos Práticos

### 📊 Análise de Dados
```bash
# Estatísticas básicas
awk '
    {
        sum += $1
        if(min == "" || $1 < min) min = $1
        if(max == "" || $1 > max) max = $1
    }
    END {
        print "Min:", min
        print "Max:", max
        print "Média:", sum/NR
    }
' dados.txt
```

### 📝 Processamento de Logs
```bash
# Análise de log Apache
awk '
    /ERROR/ {errors++}
    /WARNING/ {warnings++}
    END {
        print "Erros:", errors
        print "Avisos:", warnings
    }
' access.log
```

## Exercícios Práticos

### 🎯 Missão 1: Análise de CSV
```bash
# Objetivos:
# 1. Calcular média por coluna
# 2. Encontrar valores máximos
# 3. Contar ocorrências únicas

awk -F',' '
    {
        sum[$1] += $2
        count[$1]++
    }
    END {
        for (i in sum)
            print i, sum[i]/count[i]
    }
' dados.csv
```

### 🎯 Missão 2: Formatação de Saída
```bash
# Objetivos:
# 1. Formatar tabela
# 2. Alinhar colunas
# 3. Adicionar cabeçalho

awk 'BEGIN {
        printf "%-20s %10s %10s\n", "Nome", "Valor", "Total"
        print "----------------------------------------"
    }
    {
        printf "%-20s %10.2f %10.2f\n", $1, $2, $2 * $3
    }' dados.txt
```

## Dicas e Truques

### 💡 Boas Práticas
1. Use variáveis descritivas
2. Quebre scripts longos em funções
3. Comente código complexo
4. Valide entrada de dados

### ⚠️ Armadilhas Comuns
1. Esquecimento de aspas
2. Confusão com separadores
3. Não tratamento de erros
4. Overhead em arquivos grandes

## Próximos Passos

1. [Expressões Regulares Avançadas](regex-advanced.md)
2. [AWK Scripts Complexos](awk-advanced.md)
3. [Integração com Sed](sed-awk-integration.md)

---

> "AWK é como uma calculadora programável para seus dados - quanto mais você aprende, mais poderosa ela se torna."

```ascii
    AWK MASTERY
    [🔢🔢🔢🔢🔢] 100%
    STATUS: DADOS DOMINADOS
    PRÓXIMO: PROCESSAMENTO AVANÇADO
```