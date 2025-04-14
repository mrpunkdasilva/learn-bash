# Sed Avançado

> Domine técnicas avançadas do Sed para manipulação de texto profissional.
> {style="note"}

## Técnicas Avançadas

### 🔄 Buffers e Hold Space
```bash
# Usando hold space
sed 'H;1h;$!d;x;s/\n/,/g' arquivo.txt  # Junta linhas com vírgula
sed '1!G;h;$!d' arquivo.txt            # Inverte arquivo
sed '/padrão/{h;d};H;$!d;x' arquivo.txt # Move linhas com padrão para o topo
```

### 🎯 Branches e Testes
```bash
# Branches condicionais
sed '/padrão/{s/foo/bar/;b}; s/baz/qux/' arquivo.txt

# Testes com t
sed '/regex/{s/old/new/;t repete};:repete s/mais/outro/' arquivo.txt

# Labels e loops
sed ':inicio s/[0-9]/&0/;t inicio' numeros.txt
```

## Padrões Avançados

### 📊 Processamento Multi-linha
```bash
# Junta linhas quebradas
sed ':a;N;$!ba;s/\\\n//g' codigo.txt

# Processa blocos
sed '/<start>/,/<end>/{
    /start/n
    /end/!{
        s/foo/bar/g
        p
    }
}' arquivo.txt
```

### 🔍 Expressões Complexas
```bash
# Substituições aninhadas
sed '
    s/\([^,]*\),\([^,]*\),\([^,]*\)/\3,\1,\2/;
    s/^\([^:]*\):\([^:]*\)$/\2:\1/
' dados.txt

# Processamento condicional
sed '
    /^#/b comentario
    s/padrão/novo/g
    b fim
    :comentario
    s/^#//
    :fim
' config.txt
```

## Otimização e Performance

### ⚡ Técnicas de Otimização
```bash
# Uso eficiente de grupos
sed 's/\([0-9]\+\)/[\1]/g'           # Básico
sed 's/[0-9]\+/[&]/g'                # Otimizado

# Minimizando operações
sed '
    /^$/d;                           # Remove vazias primeiro
    s/[[:space:]]\+/ /g;            # Depois normaliza espaços
    s/^ //;s/ $//                   # Por fim, trim
' arquivo.txt
```

### 🚀 Scripts Otimizados
```bash
#!/bin/bash
# transform.sed
:start
/\\$/ {
    N
    s/\\\n//
    b start
}
s/foo/bar/g
s/baz/qux/g

# Uso: sed -f transform.sed arquivo.txt
```

## Integração com Sistema

### 🔄 Automação Avançada
```bash
# Processamento em lote
find . -type f -name "*.txt" -exec sed -i '
    s/erro/warning/g
    s/falha/error/g
    s/sucesso/success/g
' {} +

# Pipeline complexo
sed -e '/^$/d' \
    -e 's/^[[:space:]]\+//' \
    -e 's/[[:space:]]\+$//' \
    -e 's/[[:space:]]\+/ /g' \
    arquivo.txt | \
    sed -f transform.sed | \
    sed -f format.sed > resultado.txt
```

### 🛠️ Ferramentas Customizadas
```bash
# Função de processamento
sed_process() {
    local arquivo="$1"
    local temp=$(mktemp)
    
    sed -e 's/^/>> /' \
        -e 's/$/ <</' \
        -e '/^>>/!d' \
        "$arquivo" > "$temp" && mv "$temp" "$arquivo"
}
```

## Depuração e Troubleshooting

### 🔍 Técnicas de Debug
```bash
# Debug verbose
sed --debug 's/padrão/novo/g' arquivo.txt

# Visualização de mudanças
sed -n '
    p
    s/padrão/novo/gp
' arquivo.txt

# Teste de padrões
sed --debug '/regex/{s/old/new/;T;h;d};p' arquivo.txt
```

### ⚠️ Problemas Comuns e Soluções
1. Escape incorreto de caracteres
   ```bash
   sed 's/[/]/\//g'        # Errado
   sed 's|[/]|/|g'         # Correto
   ```

2. Processamento de UTF-8
   ```bash
   LC_ALL=C sed ...        # Para performance
   sed -e $'s/\r//' ...    # Remove CRLF
   ```

## Exemplos Práticos

### 📝 Processador de Logs
```bash
#!/bin/bash
# process_logs.sh

sed -e 's/^\[[0-9:]\+\]/[TIME]/' \
    -e '/^$/d' \
    -e 's/ERROR/*** ERROR ***/' \
    -e 's/\(WARNING\)/*** \1 ***/' \
    -e '/^DEBUG/d' \
    -e 's/\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)/IP: \1/g' \
    logs/*.log > processed_logs.txt
```

### 📊 Formatador de Dados
```bash
#!/bin/bash
# format_data.sh

sed -e '1i\
Nome,Idade,Email,Status' \
    -e 's/|/,/g' \
    -e 's/^ *//' \
    -e 's/ *$//' \
    -e '/^[[:space:]]*$/d' \
    -e 's/\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\U\1\E,\2,\L\3\E,\4/' \
    dados.txt > formatado.csv
```

## Próximos Passos

1. [AWK Avançado](awk-advanced.md)
2. [Expressões Regulares Avançadas](regex-advanced.md)
3. [Automação de Scripts](script-automation.md)

---

> "Sed avançado é como xadrez - fácil de aprender as regras, mas leva uma vida para dominar."

```ascii
    SED MASTERY
    [⚙️⚙️⚙️⚙️⚙️] 100%
    STATUS: DOMÍNIO AVANÇADO
    PRÓXIMO: AUTOMAÇÃO TOTAL
```