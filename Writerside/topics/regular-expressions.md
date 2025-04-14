# Expressões Regulares 

> Expressões Regulares (regex) são padrões de busca poderosos que permitem encontrar e manipular texto de forma precisa.
> {style="note"}

## Fundamentos

### 🎨 Caracteres Básicos
```bash
.        # Qualquer caractere único
^        # Início da linha
$        # Fim da linha
\        # Escape de caracteres especiais
[]       # Conjunto de caracteres
[^]      # Negação do conjunto
```

### 🔢 Quantificadores
```bash
*        # Zero ou mais (0+)
+        # Um ou mais (1+)
?        # Zero ou um (0-1)
{n}      # Exatamente n
{n,}     # n ou mais
{n,m}    # Entre n e m
```

## Classes de Caracteres

### 📝 Classes Predefinidas
```bash
\w       # Caractere de palavra [a-zA-Z0-9_]
\W       # Não-palavra [^a-zA-Z0-9_]
\d       # Dígito [0-9]
\D       # Não-dígito [^0-9]
\s       # Espaço em branco [ \t\n\r\f]
\S       # Não-espaço [^ \t\n\r\f]
```

### 🎯 Conjuntos Personalizados
```bash
[aeiou]  # Qualquer vogal
[0-9]    # Qualquer dígito
[A-Z]    # Letra maiúscula
[a-z]    # Letra minúscula
[^0-9]   # Qualquer não-dígito
```

## Padrões Comuns

### 📧 Validações Úteis
```bash
# Email
^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$

# IP
^([0-9]{1,3}\.){3}[0-9]{1,3}$

# Data (DD/MM/YYYY)
^([0-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/[0-9]{4}$

# URL
^https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$
```

## Uso com Grep

### 🔍 Busca Avançada
```bash
# Encontra emails
grep -E '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' arquivo.txt

# Encontra IPs
grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' ips.txt

# Encontra datas
grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}' logs.txt
```

### ⚡ Flags Úteis
```bash
grep -E  # Extended regex
grep -P  # Perl regex (mais recursos)
grep -v  # Inverte match
grep -i  # Ignora case
```

## Uso com Sed

### ✏️ Substituições
```bash
# Substitui emails
sed -E 's/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/EMAIL/g'

# Formata datas
sed -E 's/([0-9]{2})\/([0-9]{2})\/([0-9]{4})/\3-\2-\1/g'

# Remove linhas vazias
sed -E '/^[[:space:]]*$/d'
```

## Exercícios Práticos

### 🎯 Missão 1: Validação
```bash
#!/bin/bash
# Crie expressões regulares para validar:
# 1. Números de telefone
# 2. CPF/CNPJ
# 3. Nomes de usuário
# 4. Senhas fortes

# Exemplo de validação de telefone
telefone='^(\+55|0)?([0-9]{2})?[0-9]{8,9}$'
if [[ $1 =~ $telefone ]]; then
    echo "Telefone válido"
fi
```

### 🎯 Missão 2: Extração
```bash
#!/bin/bash
# Extraia de um arquivo de log:
# 1. Todos os IPs únicos
# 2. Todas as URLs acessadas
# 3. Todos os códigos de erro
# 4. Timestamps em formato específico

# Exemplo de extração de IPs
grep -Eo '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' access.log | sort -u
```

## Dicas e Truques

### 💡 Boas Práticas
1. Teste suas regex em pequenas amostras
2. Use grupos de captura com moderação
3. Prefira classes predefinidas quando possível
4. Documente padrões complexos
5. Considere performance em grandes arquivos

### ⚠️ Armadilhas Comuns
1. Greedy vs Lazy matching
2. Escape de caracteres especiais
3. Complexidade excessiva
4. Falsos positivos/negativos

## Ferramentas Úteis

### 🛠️ Testadores Online
1. regex101.com
2. regexr.com
3. debuggex.com

### 📚 Referências
1. [Documentação POSIX ERE](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html)
2. [Perl Regular Expressions](https://perldoc.perl.org/perlre)
3. [GNU Regex Syntax](https://www.gnu.org/software/grep/manual/html_node/Regular-Expressions.html)

---

> "Uma expressão regular é como uma chave: quanto mais precisa, melhor abre a fechadura."

```ascii
    REGEX MASTERY
    [🎯🎯🎯🎯🎯] 100%
    STATUS: PADRÕES DOMINADOS
    PRÓXIMO: SED AVANÇADO
```