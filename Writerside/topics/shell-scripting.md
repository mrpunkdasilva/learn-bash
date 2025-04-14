# Shell Scripting 🚀

> Domine a arte de criar scripts poderosos e flexíveis.
> {style="note"}

## Fundamentos Avançados

### 🎯 Estrutura de Scripts
```bash
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Configurações
readonly CONFIG_FILE="/etc/app/config.yml"
readonly LOG_FILE="/var/log/app.log"

# Importações
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/logger.sh"

# Funções principais
main() {
    log_info "Iniciando script"
    parse_args "$@"
    validate_environment
    execute_main_logic
    cleanup
}

# Execução controlada
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

### 🛠️ Gerenciamento de Argumentos
```bash
declare -A ARGS
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --config=*)
                ARGS[config]="${1#*=}"
                ;;
            --verbose)
                ARGS[verbose]=true
                ;;
            --help)
                show_help
                exit 0
                ;;
            *)
                log_error "Argumento inválido: $1"
                exit 1
                ;;
        esac
        shift
    done
}
```

## Técnicas Avançadas

### 🔄 Controle de Fluxo
```bash
# Execução condicional
execute_stage() {
    local stage="$1"
    local -a prereqs=("${@:2}")
    
    for prereq in "${prereqs[@]}"; do
        if ! check_stage "$prereq"; then
            log_error "Pré-requisito falhou: $prereq"
            return 1
        fi
    done
    
    run_stage "$stage"
}

# Pipeline com rollback
process_with_rollback() {
    local -a stages=("$@")
    local -a completed=()
    
    for stage in "${stages[@]}"; do
        if ! execute_stage "$stage"; then
            rollback "${completed[@]}"
            return 1
        fi
        completed+=("$stage")
    done
}
```

### 📊 Manipulação de Dados
```bash
# Arrays associativos
declare -A config
load_config() {
    while IFS='=' read -r key value; do
        [[ $key =~ ^[[:space:]]*# ]] && continue
        [[ -z $key ]] && continue
        config["${key// /}"]="${value// /}"
    done < "$CONFIG_FILE"
}

# Processamento JSON
parse_json() {
    local json="$1"
    local key="$2"
    echo "$json" | jq -r "$key"
}
```

## Padrões de Design

### 🎨 Modularização
```bash
# Estrutura de diretórios
project/
├── bin/
│   └── main.sh
├── lib/
│   ├── core.sh
│   ├── utils.sh
│   └── validators.sh
├── config/
│   └── default.conf
└── tests/
    └── unit/

# Importação segura
safe_source() {
    local file="$1"
    [[ -f "$file" ]] || {
        echo "Erro: Arquivo não encontrado: $file" >&2
        return 1
    }
    source "$file"
}
```

### 🔒 Segurança
```bash
# Sanitização de input
sanitize_input() {
    local input="$1"
    echo "${input//[^a-zA-Z0-9._-]/}"
}

# Execução segura
safe_execute() {
    local cmd="$1"
    if [[ "$cmd" =~ ^[a-zA-Z0-9._/-]+$ ]]; then
        "$cmd"
    else
        log_error "Comando inválido: $cmd"
        return 1
    fi
}
```

## Debugging e Testes

### 🔍 Ferramentas de Debug
```bash
# Modo debug
enable_debug() {
    set -x              # Ativa trace
    export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }' 
}

# Profiling
profile_function() {
    local func="$1"
    local start=$(date +%s%N)
    "$func"
    local end=$(date +%s%N)
    echo "Tempo de execução: $(((end-start)/1000000))ms"
}
```

### 🧪 Framework de Testes
```bash
# Suite de testes
run_tests() {
    local test_dir="$1"
    local failed=0
    
    for test in "$test_dir"/*_test.sh; do
        if ! run_test "$test"; then
            ((failed++))
        fi
    done
    
    return "$failed"
}

# Assertions
assert_equals() {
    local expected="$1"
    local actual="$2"
    local msg="${3:-}"
    
    if [[ "$expected" != "$actual" ]]; then
        log_error "Assertion falhou: $msg"
        log_error "Esperado: $expected"
        log_error "Atual: $actual"
        return 1
    fi
}
```

## Otimização

### ⚡ Performance
```bash
# Paralelização
parallel_process() {
    local -a items=("$@")
    local max_jobs=4
    
    for item in "${items[@]}"; do
        ((i=i%max_jobs)); ((i++==0)) && wait
        process_item "$item" &
    done
    wait
}

# Cache
declare -A cache
cached_operation() {
    local key="$1"
    if [[ -z "${cache[$key]}" ]]; then
        cache[$key]=$(expensive_operation "$key")
    fi
    echo "${cache[$key]}"
}
```

### 📝 Logging
```bash
# Níveis de log
declare -A LOG_LEVELS=([DEBUG]=0 [INFO]=1 [WARN]=2 [ERROR]=3)
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    printf '[%s] [%s] %s\n' "$timestamp" "$level" "$message" >&2
}
```

## Exercícios Práticos

### 🎯 Desafio 1: CLI Avançada
Crie uma CLI que:
1. Parse argumentos complexos
2. Implemente subcomandos
3. Forneça autocompletion
4. Gere documentação

### 🎯 Desafio 2: Deployment Tool
Desenvolva uma ferramenta que:
1. Gerencie dependências
2. Execute stages em ordem
3. Suporte rollback
4. Monitore progresso

## Próximos Passos

1. [Integração Contínua](ci-cd.md)
2. [Containers e Docker](containers.md)
3. [Orquestração](orchestration.md)

---

> "Shell scripting é a cola que mantém o universo Unix unido."

```ascii
    SHELL MASTER
    [🚀🚀🚀🚀🚀] 100%
    STATUS: SCRIPTS DOMINADOS
    PRÓXIMO: INTEGRAÇÃO CONTÍNUA
```