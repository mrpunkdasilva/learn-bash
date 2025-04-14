# Fundamentos do Grep 

> O grep é uma ferramenta poderosa para busca de padrões em texto. Seu nome vem de "Global Regular Expression Print".
> {style="note"}

## Sintaxe Básica

### 🎯 Busca Simples
```bash
grep "palavra" arquivo.txt      # Busca básica
grep "erro" *.log              # Busca em múltiplos arquivos
grep "padrão" arquivo1 arquivo2 # Busca em arquivos específicos
cat arquivo.txt | grep "texto"  # Busca via pipe
```

## Opções Essenciais

### 🛠️ Flags Comuns
```bash
grep -i "TEXTO"    # Ignora case
grep -v "excluir"  # Inverte seleção
grep -n "linha"    # Mostra número da linha
grep -c "contar"   # Conta ocorrências
grep -w "palavra"  # Palavra exata
```

### 📂 Busca em Diretórios
```bash
grep -r "texto" .           # Busca recursiva
grep -R "config" /etc      # Segue symlinks
grep -l "padrão" *.txt     # Lista arquivos
grep -L "ausente" *.conf   # Arquivos sem match
```

## Contexto e Formatação

### 👀 Exibindo Contexto
```bash
grep -A 2 "erro"    # 2 linhas após
grep -B 3 "início"  # 3 linhas antes
grep -C 1 "meio"    # 1 linha antes e depois
```

### 🎨 Formatação da Saída
```bash
grep --color "destaque"     # Colorir matches
grep -h "sem-arquivo"       # Omite nome do arquivo
grep -H "com-arquivo"       # Força nome do arquivo
```

## Padrões Básicos

### 🎨 Caracteres Especiais
```bash
grep "^início"     # Começa com
grep "fim$"        # Termina com
grep "^$"          # Linhas vazias
grep "."           # Qualquer caractere
```

### 🎲 Quantificadores
```bash
grep "ca*t"        # 'ct', 'cat', 'caat'...
grep "ca\?"        # 'c', 'ca'
grep "ca\+"        # 'ca', 'caa'...
```

## Exemplos Práticos

### 📊 Análise de Logs
```bash
# Encontra erros em logs
grep "ERROR" /var/log/*.log

# Busca IPs em access.log
grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" access.log

# Encontra requisições POST
grep -i "POST" access.log
```

### 🔧 Manutenção de Sistema
```bash
# Busca processos
ps aux | grep "nginx"

# Encontra configurações
grep -r "DocumentRoot" /etc/apache2/

# Busca usuários
grep "bash$" /etc/passwd
```

## Exercícios Práticos

### 🎯 Missão 1: Análise de Log
```bash
# Objetivos:
# 1. Encontre todas as linhas com "ERROR"
# 2. Mostre 2 linhas de contexto
# 3. Salve resultado em erro.log
grep -C 2 "ERROR" app.log > erro.log
```

### 🎯 Missão 2: Busca Avançada
```bash
# Objetivos:
# 1. Busque recursivamente por "TODO"
# 2. Apenas em arquivos .py
# 3. Ignore case
find . -name "*.py" -exec grep -i "TODO" {} \;
```

## Dicas de Performance

### ⚡ Otimizações
1. Use `grep -F` para strings fixas
2. Evite recursão desnecessária
3. Combine com `find` para maior controle
4. Use `--exclude` e `--include` para filtrar

### 🚫 Armadilhas Comuns
1. Esquecimento de aspas
2. Uso incorreto de regex
3. Recursão em diretórios grandes
4. Ignorar case quando necessário

## Próximos Passos

1. [Expressões Regulares](regular-expressions.md)
2. [Sed Básico](sed-basics.md)
3. [Awk Básico](awk-basics.md)

---

> "grep é como uma lupa para seu texto - quanto melhor você a usa, mais detalhes encontra."

```ascii
    GREP MASTERY
    [🔍🔍🔍🔍🔍] 100%
    STATUS: PADRÕES DOMINADOS
    PRÓXIMO: REGEX AVANÇADO
```