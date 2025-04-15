#!/bin/bash
# Demonstração de conceitos básicos de scripts

# Shebang e comentários
echo "=== Script Basics Demo ==="

# Variáveis básicas
SCRIPT_NAME="Basic Script Demo"
VERSION="1.0"

# Input e output
read -p "Digite seu nome: " username
echo "Olá, $username!"

# Exit codes
if [ $? -eq 0 ]; then
    echo "Comando anterior executado com sucesso"
fi

# Permissões e execução
chmod +x "$0"