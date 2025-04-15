#!/bin/bash
# Práticas de segurança em scripts

# Configurações de segurança
umask 077  # Restringe permissões de arquivos criados
IFS=$' \t\n'  # Define separadores seguros
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Validação segura de input
validate_input() {
    local input="$1"
    local pattern="$2"
    
    if [[ ! "$input" =~ $pattern ]]; then
        echo "Input inválido: $input"
        return 1
    fi
    return 0
}

# Sanitização de variáveis
sanitize_string() {
    local input="$1"
    echo "${input//[^a-zA-Z0-9_-]/}"
}

# Execução segura de comandos
safe_execute() {
    local cmd="$1"
    if command -v "$cmd" &>/dev/null; then
        "$cmd"
    else
        echo "Comando não encontrado: $cmd"
        return 1
    fi
}

# Gerenciamento seguro de arquivos temporários
create_temp_file() {
    local prefix="${1:-temp}"
    mktemp "/tmp/${prefix}.XXXXXX"
}

# Limpeza segura de arquivos
secure_delete() {
    local file="$1"
    if [ -f "$file" ]; then
        shred -u "$file"
    fi
}

# Verificação de privilégios
check_privileges() {
    if [ "$(id -u)" -eq 0 ]; then
        echo "Este script não deve ser executado como root"
        exit 1
    fi
}

# Exemplo de uso
main() {
    check_privileges
    
    local temp_file=$(create_temp_file "secure")
    trap 'secure_delete "$temp_file"' EXIT
    
    local user_input="exemplo123!@#"
    local sanitized_input=$(sanitize_string "$user_input")
    
    if validate_input "$sanitized_input" "^[a-zA-Z0-9_-]+$"; then
        echo "$sanitized_input" > "$temp_file"
        safe_execute "cat" < "$temp_file"
    fi
}

main "$@"