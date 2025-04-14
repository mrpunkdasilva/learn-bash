#!/bin/bash
# Explorador do sistema de arquivos

# Função para mostrar informações do diretório
show_dir_info() {
    local dir="${1:-.}"
    echo "=== Informações do Diretório: $dir ==="
    echo "Espaço usado:"
    du -sh "$dir"
    echo -e "\nArquivos:"
    ls -lah "$dir"
    echo -e "\nTipos de arquivo:"
    file "$dir"/*
}

# Função para buscar arquivos
find_files() {
    echo "=== Buscando arquivos ==="
    echo "Arquivos modificados nas últimas 24h:"
    find . -type f -mtime -1
    
    echo -e "\nArquivos por extensão:"
    find . -type f -name "*.sh"
}

# Função para criar links
create_links() {
    echo "=== Criando Links ==="
    touch original.txt
    ln original.txt hard_link.txt
    ln -s original.txt soft_link.txt
    ls -la *link.txt original.txt
}

# Menu principal
echo "1. Mostrar informações do diretório"
echo "2. Buscar arquivos"
echo "3. Demonstração de links"
read -p "Escolha uma opção: " option

case $option in
    1) show_dir_info ;;
    2) find_files ;;
    3) create_links ;;
    *) echo "Opção inválida" ;;
esac