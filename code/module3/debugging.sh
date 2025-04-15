#!/bin/bash
# Técnicas de debugging

# Ativa modo debug
enable_debug() {
    set -x  # Imprime comandos e seus argumentos
    export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
}

# Desativa modo debug
disable_debug() {
    set +x
}

# Logger para debugging
debug_log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    case "$level" in
        "INFO")    echo "[$timestamp] [INFO] $message" ;;
        "DEBUG")   echo "[$timestamp] [DEBUG] $message" ;;
        "WARNING") echo "[$timestamp] [WARNING] $message" ;;
        "ERROR")   echo "[$timestamp] [ERROR] $message" ;;
    esac
}

# Função para inspecionar variáveis
inspect_var() {
    local var_name="$1"
    echo "=== Inspeção de Variável ==="
    echo "Nome: $var_name"
    echo "Valor: ${!var_name}"
    echo "Tipo: $(declare -p "$var_name" 2>/dev/null || echo 'undefined')"
}

# Stack trace personalizado
print_stack_trace() {
    local frame=0
    echo "=== Stack Trace ==="
    while caller $frame; do
        ((frame++))
    done
}

# Profiling simples
start_profiling() {
    export PROFILING_START=$(date +%s.%N)
}

end_profiling() {
    local end_time=$(date +%s.%N)
    local elapsed=$(echo "$end_time - $PROFILING_START" | bc)
    echo "Tempo de execução: $elapsed segundos"
}

# Exemplo de uso
example_function() {
    debug_log "INFO" "Iniciando exemplo_function"
    local test_var="exemplo"
    inspect_var "test_var"
    sleep 1
    debug_log "DEBUG" "Finalizando exemplo_function"
}

main() {
    enable_debug
    start_profiling
    
    example_function
    
    if [ $? -ne 0 ]; then
        print_stack_trace
    fi
    
    end_profiling
    disable_debug
}

main "$@"