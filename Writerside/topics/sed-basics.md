# Fundamentos do Sed

> Aprenda os conceitos básicos e uso do comando sed para manipulação eficiente de texto.
> {style="note"}

## Sintaxe Básica

### 🎯 Comandos Fundamentais
```bash
sed 's/antigo/novo/'        # Substitui primeira ocorrência
sed 's/antigo/novo/g'       # Substitui todas ocorrências
sed '3s/antigo/novo/'       # Substitui na linha 3
sed '1,5s/antigo/novo/'     # Substitui nas linhas 1-5
```

### 🔄 Flags de Substituição
```bash
s/padrão/texto/g           # Global (todas ocorrências)
s/padrão/texto/i           # Ignora case
s/padrão/texto/p           # Imprime linhas modificadas
s/padrão/texto/w arquivo   # Salva linhas modificadas
```

## Operações Básicas

### ✂️ Deletar Linhas
```bash
sed '3d'                   # Deleta linha 3
sed '2,5d'                # Deleta linhas 2-5
sed '/padrão/d'           # Deleta linhas com padrão
sed '/^$/d'              # Deleta linhas vazias
```

### ➕ Adicionar Linhas
```bash
sed '2i\TEXTO'            # Insere antes da linha 2
sed '2a\TEXTO'            # Insere após linha 2
sed '2c\TEXTO'            # Substitui linha 2
```

## Padrões e Endereços

### 🎯 Seleção de Linhas
```bash
sed -n '1p'               # Imprime linha 1
sed -n '1,5p'            # Imprime linhas 1-5
sed -n '/erro/p'         # Imprime linhas com 'erro'
sed '/início/,/fim/p'    # Imprime entre padrões
```

### 🔍 Expressões Regulares
```bash
sed '/^#/d'              # Remove comentários
sed '/^$/d'              # Remove linhas vazias
sed '/[0-9]\{3\}/p'     # Mostra linhas com 3 dígitos
```

## Manipulação Avançada

### 💾 Grupos e Referências
```bash
# Inverte palavras
sed 's/\([a-z]*\) \([a-z]*\)/\2 \1/'

# Formata telefone
sed 's/\([0-9]\{2\}\)\([0-9]\{4\}\)\([0-9]\{4\}\)/(\1) \2-\3/'

# Adiciona aspas
sed 's/\(.*\)/"\1"/'
```

### 🔄 Múltiplos Comandos
```bash
# Vários comandos em sequência
sed -e 's/foo/bar/' -e 's/bar/baz/'

# Usando ponto e vírgula
sed 's/foo/bar/;s/bar/baz/'

# De um arquivo
sed -f comandos.sed arquivo.txt
```

## Exemplos Práticos

### 📝 Manipulação de Arquivos
```bash
# Comenta linhas específicas
sed '2,5s/^/#/'

# Remove espaços extras
sed 's/  */ /g'

# Adiciona numeração
sed = arquivo.txt | sed 'N;s/\n/. /'
```

### 🔧 Transformação de Dados
```bash
# Converte CSV para TSV
sed 's/,/\t/g'

# Formata JSON
sed 's/},{/},\n{/g'

# Limpa HTML
sed 's/<[^>]*>//g'
```

## Exercícios Práticos

### 🎯 Missão 1: Limpeza de Logs
```bash
#!/bin/bash
# Objetivos:
# 1. Remover linhas vazias
# 2. Remover timestamps
# 3. Formatar saída

sed -e '/^$/d' \
    -e 's/^\[[0-9: -]*\] //' \
    -e 's/ERROR/*** ERROR ***/' \
    log.txt
```

### 🎯 Missão 2: Formatação de Dados
```bash
#!/bin/bash
# Objetivos:
# 1. Converter dados para CSV
# 2. Adicionar cabeçalho
# 3. Formatar campos

sed -e '1i\Nome,Idade,Email' \
    -e 's/|/,/g' \
    -e 's/^ *//' \
    -e 's/ *$//' \
    dados.txt
```

## Dicas e Truques

### 💡 Boas Práticas
1. Use `-E` para regex estendido
2. Faça backup antes de editar in-place
3. Teste comandos antes com `-n`
4. Quebre comandos complexos em partes

### ⚠️ Armadilhas Comuns
1. Esquecimento de flags globais
2. Escape incorreto de caracteres
3. Ordem errada de operações
4. Uso excessivo de grupos

## Ferramentas Úteis

### 🛠️ Depuração
```bash
# Mostra mudanças
sed -n 'p;s/foo/bar/p' 

# Debug com comentários
sed -n 'l' # mostra caracteres especiais

# Teste de padrões
sed --debug 's/padrão/texto/'
```

### 📚 Referências
1. [GNU Sed Manual](https://www.gnu.org/software/sed/manual/sed.html)
2. [Sed One-Liners](http://sed.sourceforge.net/sed1line.txt)
3. [POSIX Sed Standard](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html)

---

> "Sed é como um canivete suíço para texto - pequeno, mas incrivelmente versátil."

```ascii
    SED MASTERY
    [✂️✂️✂️✂️✂️] 100%
    STATUS: TRANSFORMAÇÕES DOMINADAS
    PRÓXIMO: AWK BÁSICO
```