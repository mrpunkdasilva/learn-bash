#!/bin/bash
# Demonstração de comandos básicos de navegação

# Comandos básicos
pwd                         # Mostra diretório atual
cd /tmp                     # Muda para diretório específico
cd ~                       # Volta para home
cd -                      # Volta para último diretório

# Directory Stack
pushd /var/log            # Adiciona diretório à pilha
pushd /etc               # Adiciona outro diretório
dirs                     # Mostra pilha de diretórios
popd                     # Remove último diretório da pilha

# Find e Locate
find /home -name "*.txt"  # Busca arquivos .txt
find . -type d           # Lista apenas diretórios
locate "*.conf"          # Busca rápida por arquivo

# Wildcards e Globbing
ls *.sh                  # Lista todos arquivos .sh
ls [a-z]*.txt           # Lista arquivos que começam com minúsculas
ls {*.pdf,*.doc}        # Lista PDFs e DOCs