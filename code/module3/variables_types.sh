#!/bin/bash
# Demonstração de variáveis e tipos

# Strings
nome="Terminal Master"
echo "Nome: $nome"

# Números
contador=0
((contador++))

# Arrays
declare -a frutas=("maçã" "banana" "laranja")
echo "Segunda fruta: ${frutas[1]}"

# Arrays associativos
declare -A usuarios
usuarios[admin]="root"
usuarios[guest]="visitor"

# Variáveis especiais
echo "Nome do script: $0"
echo "Número de argumentos: $#"
echo "Todos argumentos: $@"
echo "PID do script: $$"