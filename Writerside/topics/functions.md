# Funções: Modularizando seu Código 🧩

## Fundamentos

### 📝 Declaração Básica
```bash
# Função simples
hello() {
    echo "Hello, World!"
}

# Função com parâmetros
saudacao() {
    echo "Olá, $1!"
}

# Função com retorno
soma() {
    local resultado=$(($1 + $2))
    echo "$resultado"
}
```

### 🎯 Parâmetros e Argumentos
```bash
# Parâmetros posicionais
funcao() {
    echo "Primeiro: $1"
    echo "Segundo: $2"
    echo "Todos: $@"
    echo "Número de args: $#"
}

# Parâmetros nomeados
config() {
    local nome=${1:-"default"}
    local tipo=${2:-"normal"}
    echo "Nome: $nome, Tipo: $tipo"
}
```

## Escopo e Retorno

### 🔒 Variáveis Locais
```bash
# Escopo local
processa_dados() {
    local temp_var="local"
    echo "$temp_var"
}

# Escopo global
GLOBAL_VAR="global"
modifica_global() {
    GLOBAL_VAR="modificado"
}
```

### ↩️ Valores de Retorno
```bash
# Retorno numérico
verifica_status() {
    [[ -f "$1" ]] && return 0
    return 1
}

# Retorno de string
get_info() {
    local info