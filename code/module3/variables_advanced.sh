#!/bin/bash
# Uso avançado de variáveis

# Arrays multidimensionais usando arrays associativos
declare -A matriz
matriz[0,0]="A"
matriz[0,1]="B"
matriz[1,0]="C"
matriz[1,1]="D"

# Função para acessar matriz
get_matriz() {
    local i=$1
    local j=$2
    echo "${matriz[$i,$j]}"
}

# Variáveis indiretas (nameref)
declare -n ref
process_var() {
    local -n ref=$1  # referência à variável passada
    ref="novo valor"
}

# Expansões de variáveis avançadas
var="exemplo_de_texto"
echo "${var^}"      # Primeira letra maiúscula
echo "${var^^}"     # Tudo maiúsculo
echo "${var,}"      # Primeira letra minúscula
echo "${var,,}"     # Tudo minúsculo
echo "${var:2:4}"   # Substring
echo "${var/texto/conteúdo}"  # Substituição

# Arrays com operações avançadas
declare -a numeros=(1 2 3 4 5)
echo "Tamanho: ${#numeros[@]}"
echo "Índices: ${!numeros[@]}"
echo "Slice: ${numeros[@]:1:2}"

# Variáveis readonly com valores calculados
readonly MAX_PROCESSES=$(nproc)
readonly TIMESTAMP=$(date +%s)
readonly HOSTNAME=$(hostname)

# Exportação de variáveis com valores default
export APP_ENV=${APP_ENV:-"development"}
export DEBUG_LEVEL=${DEBUG_LEVEL:-0}
export MAX_RETRIES=${MAX_RETRIES:-3}