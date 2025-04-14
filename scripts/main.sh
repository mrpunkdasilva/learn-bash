#!/bin/bash

# Definir diretório base
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCS_DIR="${BASE_DIR}/../docs"

# Função para log
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Função para tratamento de erros
handle_error() {
    log_message "ERRO: $1"
    exit 1
}

# Limpar diretório docs
log_message "Limpando diretório docs..."
rm -rf "${DOCS_DIR}" || handle_error "Falha ao limpar diretório docs"

# Executar scripts
log_message "Descompactando Writerside..."
"${BASE_DIR}/unzip_writerside.sh" || handle_error "Falha ao descompactar Writerside"

log_message "Enviando para repositório remoto..."
"${BASE_DIR}/push_remote_repo.sh" || handle_error "Falha ao enviar para repositório remoto"

log_message "Processo concluído com sucesso!"


