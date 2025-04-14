# Melhores Práticas 

## Princípios Fundamentais

### 1. Segurança
```bash
# ✅ Correto: Validar entradas
input="${1:-}"
if [[ ! "$input" =~ ^[0-9]+$ ]]; then
    echo "Erro: Digite apenas números"
    exit 1
fi

# ❌ Incorreto: Entrada sem validação
rm -rf "$1"
```

### 2. Legibilidade
```bash
# ✅ Correto: Código legível e documentado
get_user_age() {
    local name="$1"
    local birth_year="$2"
    local current_year=$(date +%Y)
    
    echo $((current_year - birth_year))
}

# ❌ Incorreto: Código confuso
a() { echo $(($(date +%Y)-$2)); }
```

### 3. Manutenibilidade
```bash
# ✅ Correto: Configurações centralizadas
readonly CONFIG_FILE="/etc/app/config.conf"
readonly LOG_DIR="/var/log/app"
readonly MAX_RETRIES=3

# ❌ Incorreto: Valores hardcoded
if [ $count -gt 3 ]; then
    echo "error" > /var/log/app/temp.log
fi
```

## Estrutura de Scripts

### 1. Cabeçalho Padrão
```bash
#!/bin/bash
#
# Nome: script.sh
# Descrição: Breve descrição do script
# Autor: Seu Nome
# Data: YYYY-MM-DD
# Versão: 1.0
#
# Uso: ./script.sh [opções]
```

### 2. Organização do Código
```bash
# Configurações
set -euo pipefail
IFS=$'\n\t'

# Variáveis globais
readonly VERSION="1.0.0"
readonly CONFIG_FILE="/etc/app/config.conf"

# Funções
function log_error() {
    local message="$1"
    echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $message" >&2
}

# Código principal
function main() {
    # Lógica principal aqui
}

# Execução
main "$@"
```

## Padrões de Codificação

### 1. Nomenclatura
```bash
# ✅ Correto: Nomes descritivos
function validate_user_input() {
    local user_name="$1"
    local user_age="$2"
}

# ❌ Incorreto: Nomes obscuros
function val() {
    local n="$1"
    local a="$2"
}
```

### 2. Indentação e Formatação
```bash
# ✅ Correto: Indentação consistente
if [ "$condition" = true ]; then
    for item in "${items[@]}"; do
        process_item "$item"
    done
fi

# ❌ Incorreto: Indentação inconsistente
if [ "$condition" = true ]; then
for item in "${items[@]}"
do
process_item "$item"
done
fi
```

## Tratamento de Erros

### 1. Validação de Entrada
```bash
# ✅ Correto: Validação completa
function process_file() {
    local file="$1"
    
    if [ -z "$file" ]; then
        log_error "Nome do arquivo não fornecido"
        return 1
    fi
    
    if [ ! -f "$file" ]; then
        log_error "Arquivo não existe: $file"
        return 1
    fi
    
    if [ ! -r "$file" ]; then
        log_error "Arquivo sem permissão de leitura: $file"
        return 1
    fi
}
```

### 2. Tratamento de Exceções
```bash
# ✅ Correto: Tratamento de erros
set -e
trap 'echo "Erro na linha $LINENO"' ERR

function cleanup() {
    # Limpeza de recursos
    rm -f "$TEMP_FILE"
}

trap cleanup EXIT
```

## Otimização e Performance

### 1. Uso de Recursos
```bash
# ✅ Correto: Uso eficiente
while IFS= read -r line; do
    process_line "$line"
done < "$file"

# ❌ Incorreto: Desperdício de recursos
cat "$file" | while read line; do
    process_line "$line"
done
```

### 2. Operações em Lote
```bash
# ✅ Correto: Operações em lote
find . -type f -name "*.log" -exec rm {} +

# ❌ Incorreto: Operações individuais
for file in *.log; do
    rm "$file"
done
```

## Segurança Avançada

### 1. Permissões
```bash
# ✅ Correto: Gestão de permissões
umask 077
touch "$SENSITIVE_FILE"
chmod 600 "$SENSITIVE_FILE"

# ❌ Incorreto: Permissões inseguras
touch "$SENSITIVE_FILE"
chmod 777 "$SENSITIVE_FILE"
```

### 2. Dados Sensíveis
```bash
# ✅ Correto: Proteção de dados sensíveis
read -s -p "Password: " password
echo

# ❌ Incorreto: Exposição de dados
echo "Password: $password"
```

## Documentação

### 1. Comentários
```bash
# ✅ Correto: Comentários úteis
# Valida o formato do CPF (XXX.XXX.XXX-XX)
function validate_cpf() {
   