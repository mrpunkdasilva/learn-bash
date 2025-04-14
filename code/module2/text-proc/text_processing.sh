#!/bin/bash
# Demonstração de processamento de texto

# Grep básico
grep "erro" log.txt                # Busca palavra
grep -i "erro" log.txt            # Case insensitive
grep -r "TODO" .                  # Busca recursiva

# Sed básico
sed 's/antigo/novo/g' arquivo.txt  # Substitui texto
sed -i '1d' arquivo.txt           # Remove primeira linha
sed -n '1,5p' arquivo.txt         # Mostra linhas 1-5

# Awk básico
awk '{print $1}' dados.txt         # Primeira coluna
awk '{sum += $1} END {print sum}' # Soma valores
awk -F, '{print $2}' arquivo.csv  # CSV parsing

# Filtros de texto
sort arquivo.txt                   # Ordena linhas
uniq -c                           # Conta ocorrências
cut -d',' -f1,3 dados.csv        # Extrai colunas
tr '[:upper:]' '[:lower:]'       # Converte case

# Expressões regulares
grep -E '^[0-9]+$' arquivo.txt    # Números
grep -E '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' # Emails

# Automação
find . -name "*.log" -type f -exec grep "ERROR" {} \;