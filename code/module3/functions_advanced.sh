#!/bin/bash
# Funções avançadas

# Função com validação de argumentos
validate_args() {
    local func_name=$1
    local expected=$2
    local received=$3
    
    if [[ $received -ne $expected ]]; then
        echo "Erro: $func_name espera $expected argumentos, recebeu $received"
        return 1
    fi
    return 0
}

# Função com argumentos nomeados
process_user() {
    local name=""
    local age=""
    local city=""
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --name) name="$2"; shift 2 ;;
            --age) age="$2"; shift 2 ;;
            --city) city="$2"; shift 2 ;;
            *) echo "Opção inválida: $1"; return 1 ;;
        esac
    done
    
    echo "Nome: $name, Idade: $age, Cidade: $city"
}

# Função com callback
execute_with_callback() {
    local cmd=$1
    local callback=$2
    
    if $cmd; then
        $callback "success"
    else
        $callback "failure"
    fi
}

# Função com cache
declare -A func_cache
cached_fibonacci() {
    local n=$1
    
    if [[ -n "${func_cache[$n]}" ]]; then
        echo "${func_cache[$n]}"
        return
    fi
    
    if [[ $n -le 1 ]]; then
        func_cache[$n]=$n
    else
        local n1=$(cached_fibonacci $((n-1)))
        local n2=$(cached_fibonacci $((n-2)))
        func_cache[$n]=$((n1 + n2))
    fi
    
    echo "${func_cache[$n]}"
}

# Função com timeout
function_with_timeout() {
    local timeout=$1
    local cmd="${@:2}"
    
    (
        eval "$cmd" &
        child=$!
        trap -- "" SIGTERM
        (
            sleep "$timeout"
            kill $child 2> /dev/null
        ) &
        wait $child
    )
}

# Exemplo de uso
callback_handler() {
    echo "Status: $1"
}

# Testes
process_user --name "João" --age "30" --city "São Paulo"
execute_with_callback "ls /tmp" callback_handler
echo "Fibonacci(10): $(cached_fibonacci 10)"
function_with_timeout 5 "sleep 10; echo 'Concluído'"