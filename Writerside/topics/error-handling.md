# Tratamento de Erros

> Aprenda a implementar tratamento de erros robusto e confiável em seus scripts.
> {style="note"}

## Fundamentos

### 🛡️ Códigos de Erro
```bash
# Definição de códigos
readonly E_ARGS=65
readonly E_FILE_NOT_FOUND=66
readonly E_PERMISSION=67
readonly E_INVALID_INPUT=68

# Uso
if [[ $# -eq 0 ]]; then
    echo "Erro: Argumentos necessários" >&2
    exit "$E_ARGS"
fi
```

### 🔍 Detecção de Erros
```bash
# Habilitar detecção
set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure

# Exemplo prático
command || {
    echo "Comando falhou" >&2
    exit 1
}
```

## Técnicas Avançadas

### 🎯 Try-Catch Simulado
```bash
#!/bin/bash
# try-catch.sh

try() {
    "$@"
}

catch() {
    local exit_code=$?
    echo "Erro capturado: $exit_code" >&2
    return "$exit_code"
}

try comando_arriscado || catch
```

### 📝 Logging de Erros
```bash
#!/bin/bash
# error_logger.sh

log_error() {
    local message="$1"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] ERROR: $message" >&2
    logger -p user.error "$message"
}
```

## Validação de Entrada

### ✅ Verificações Básicas
```bash
#!/bin/bash
# input_validator.sh

validate_number() {
    local input="$1"
    if [[ ! "$input" =~ ^[0-9]+$ ]]; then
        log_error "Entrada inválida: $input não é um número"
        return 1
    fi
}

validate_file() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        log_error "Arquivo não encontrado: $file"
        return 1
    fi
    if [[ ! -r "$file" ]]; then
        log_error "Arquivo sem permissão de leitura: $file"
        return 1
    fi
}
```

### 🔒 Sanitização
```bash
#!/bin/bash
# sanitizer.sh

sanitize_input() {
    local input="$1"
    # Remove caracteres perigosos
    input="${input//[^a-zA-Z0-9._-]/}"
    echo "$input"
}
```

## Recuperação de Erros

### 🔄 Retry Logic
```bash
#!/bin/bash
# retry.sh

retry() {
    local tries=$1
    local cmd="${@:2}"
    local n=1
    
    until [[ $n -gt $tries ]]; do
        $cmd && break || {
            echo "Tentativa $n falhou... tentando novamente em 5s" >&2
            ((n++))
            sleep 5
        }
    done
}
```

### 🧹 Cleanup
```bash
#!/bin/bash
# cleanup.sh

cleanup() {
    # Remove arquivos temporários
    rm -f /tmp/temp.*
    
    # Mata processos filhos
    pkill -P $$
    
    # Restaura configurações
    restore_settings
}

trap cleanup EXIT
```

## Boas Práticas

### 💡 Recomendações
1. Sempre valide entradas
2. Use códigos de erro significativos
3. Implemente logging adequado
4. Faça limpeza apropriada
5. Documente tratamentos

### ⚠️ Pontos de Atenção
1. Não ignore erros
2. Evite silenciar exceções
3. Valide retornos de comandos
4. Trate timeouts
5. Gerencie recursos

## Exemplos Práticos

### 📋 Script Robusto
```bash
#!/bin/bash
# robust_script.sh

set -euo pipefail
trap cleanup EXIT

readonly LOG_FILE="/var/log/script.log"
readonly TEMP_DIR="/tmp/script"

main() {
    validate_environment || exit "$E_ENV"
    process_input "$@" || exit "$E_INPUT"
    execute_operation || exit "$E_EXEC"
}

main "$@"
```

## Próximos Passos

1. [Logging Avançado](logging-advanced.md)
2. [Monitoramento](monitoring.md)
3. [Debugging](debugging.md)

---

> "Melhor prevenir do que remediar - trate seus erros antes que eles tratem você."

```ascii
    ERROR HANDLING
    [🛡️🛡️🛡️🛡️🛡️] 100%
    STATUS: PROTEGIDO
    PRÓXIMO: LOGGING
```