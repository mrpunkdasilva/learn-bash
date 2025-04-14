#!/bin/bash
# Demonstração de operações básicas

# Criar estrutura de diretórios
echo "Criando estrutura de diretórios..."
mkdir -p projeto/{src,docs,tests}

# Criar alguns arquivos
echo "Criando arquivos..."
touch projeto/src/{main,util,helper}.sh
touch projeto/docs/readme.md
touch projeto/tests/test_main.sh

# Copiar arquivos
echo "Demonstrando cópia..."
cp projeto/src/main.sh projeto/src/main.sh.backup

# Mover arquivos
echo "Demonstrando movimentação..."
mv projeto/src/main.sh.backup projeto/docs/

# Listar estrutura
echo -e "\nEstrutura criada:"
tree projeto/