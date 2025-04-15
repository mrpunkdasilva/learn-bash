#!/bin/bash
# Demonstração de funções

# Função básica
hello() {
    echo "Olá, mundo!"
}

# Função com parâmetros
greet() {
    local name="$1"
    echo "Olá, $name!"
}

# Função com retorno
is_number() {
    local num="$1"
    [[ "$num" =~ ^[0-9]+$ ]]
    return $?
}

# Função com variáveis locais
process_file() {
    local filename="$1"
    local count=0
    while read -r line; do
        ((count++))
    done < "$filename"
    echo "Linhas processadas: $count"
}

# Biblioteca de funções
source lib/utils.sh

# Uso das funções
hello
greet "Terminal Master"
is_number "123" && echo "É um número"