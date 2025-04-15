#!/bin/bash
# Conceitos avançados de scripts básicos

# Configuração de debug
set -e  # Sai em caso de erro
set -u  # Trata variáveis não definidas como erro
set -o pipefail  # Propaga erros em pipes

# Tratamento de sinais
trap 'echo "Script interrompido"; cleanup; exit 1' SIGINT SIGTERM

# Configurações globais
readonly CONFIG_FILE="/etc/myapp/config.conf"
readonly LOG_DIR="/var/log/myapp"
readonly LOCK_FILE="/var/run/myapp.pid"

# Verificação de usuário root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Este script precisa ser executado como root"
        exit 1
    fi
}

# Verificação de dependências
check_dependencies() {
    local deps=("curl" "jq" "bc")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "Dependência não encontrada: $dep"
            exit 1
        fi
    done
}

# Função de limpeza
cleanup() {
    rm -f "$LOCK_FILE"
    echo "Limpeza realizada"
}

# Inicialização
main() {
    check_root
    check_dependencies
    
    # Cria lock file
    echo $$ > "$LOCK_FILE"
    
    # Garante que cleanup será executado ao sair
    trap cleanup EXIT
}

main "$@"