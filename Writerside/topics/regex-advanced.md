# Expressões Regulares Avançadas 🎯

> Domine padrões complexos e técnicas avançadas de matching com expressões regulares.
> {style="note"}

## Metacaracteres Avançados

### 🔍 Lookaround
```bash
# Positive lookahead
(?=padrão)    # Match se seguido por padrão
grep -P 'foo(?=bar)' arquivo.txt

# Negative lookahead
(?!padrão)    # Match se NÃO seguido por padrão
grep -P 'foo(?!bar)' arquivo.txt

# Positive lookbehind
(?<=padrão)   # Match se precedido por padrão
grep -P '(?<=foo)bar' arquivo.txt

# Negative lookbehind
(?<!padrão)   # Match se NÃO precedido por padrão
grep -P '(?<!foo)bar' arquivo.txt
```

### 🎯 Grupos e Referências
```bash
# Grupos nomeados
(?P<nome>padrão)    # Captura com nome
(?P=nome)           # Referência ao grupo

# Grupos atômicos
(?>padrão)          # Sem backtracking

# Referências recursivas
(?R)                # Recursão completa
(?1)                # Referência ao grupo 1
```

## Técnicas Avançadas

### 🔄 Padrões Condicionais
```bash
# Condicionais
(?(1)sim|não)       # Se grupo 1 existe
(?(R)sim|não)       # Se em recursão

# Exemplo prático
grep -P '(\d+)?(?(1)\w+|\s+)' arquivo.txt
```

### 🎨 Modificadores Inline
```bash
# Modificadores em grupos
(?i)        # Case insensitive
(?m)        # Multiline
(?s)        # Dotall (. inclui \n)
(?x)        # Extended (ignora espaços)

# Combinações
(?im)       # Case insensitive + multiline
```

## Otimização

### ⚡ Performance
```bash
# Padrões eficientes
[^a]        # Melhor que .(?<!a)
a|b|c       # Melhor que [abc]
^abc        # Âncoras melhoram performance

# Evitar
.*          # Greedy matching
(a|b)+      # Backtracking excessivo
```

### 🎯 Casos de Uso

#### Validação de Dados
```bash
# Email
^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$

# URL
^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$

# Data ISO
^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$
```

#### Extração Complexa
```bash
# JSON keys
(?<=")[^"]+(?="\s*:)

# Tags HTML
<([a-z]+)([^>]+)*(?:>(.*?)</\1>|\s+/>)

# Logs estruturados
^(?<timestamp>\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})
```

## Exercícios Práticos

### 🎯 Missão 1: Parser Avançado
```bash
#!/bin/bash
# Objetivo: Parser de log complexo

LOG_PATTERN='(?P<ip>\d+\.\d+\.\d+\.\d+)\s+-\s+-\s+\[(?P<date>[^\]]+)\]\s+"(?P<request>[^"]+)"\s+(?P<status>\d+)\s+(?P<bytes>\d+)'

grep -P "$LOG_PATTERN" access.log
```

### 🎯 Missão 2: Validador
```bash
#!/bin/bash
# Objetivo: Validação de dados estruturados

validate_data() {
    local pattern="$1"
    local input="$2"
    
    if [[ $input =~ $pattern ]]; then
        echo "Válido"
    else
        echo "Inválido"
    fi
}
```

## Ferramentas e Testes

### 🛠️ Debugger de Regex
```bash
# Teste interativo
regex_test() {
    local pattern="$1"
    local test_string="$2"
    
    echo "$test_string" | grep -P --color=always "$pattern"
    if [ $? -eq 0 ]; then
        echo "✅ Match encontrado"
    else
        echo "❌ Sem match"
    fi
}
```

### 📊 Benchmark
```bash
# Teste de performance
regex_benchmark() {
    local pattern="$1"
    local file="$2"
    local iterations=1000
    
    time for ((i=0; i<iterations; i++)); do
        grep -P "$pattern" "$file" >/dev/null
    done
}
```

## Troubleshooting

### ⚠️ Problemas Comuns
1. Catastrophic Backtracking
2. Greedy vs Lazy Matching
3. Unicode Issues
4. Performance em Grandes Arquivos

### 💡 Soluções
1. Use grupos atômicos
2. Prefira quantificadores específicos
3. Habilite suporte Unicode
4. Otimize para early failure

## Próximos Passos

1. [AWK Scripts Complexos](awk-advanced.md)
2. [Sed Avançado](sed-advanced.md)
3. [Automação de Texto](text-automation.md)

---

> "Expressões regulares são como superpoderes - com grandes poderes vêm grandes responsabilidades."

```ascii
    REGEX MASTERY
    [📝📝📝📝📝] 100%
    STATUS: PADRÕES DOMINADOS
    PRÓXIMO: AUTOMAÇÃO AVANÇADA
```