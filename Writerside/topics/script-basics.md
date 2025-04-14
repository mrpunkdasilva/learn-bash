# Fundamentos de Scripts: Primeiros Passos 

## Estrutura Básica

### 🚀 Primeiro Script
```bash
#!/bin/bash
# Meu primeiro script

echo "Hello, World!"
```

### 📋 Anatomia de um Script
```bash
#!/bin/bash
# Autor: Seu Nome
# Data: YYYY-MM-DD
# Descrição: Descrição do script

# Variáveis
VERSAO="1.0"
CONFIG_FILE="/etc/config.conf"

# Funções
verificar_ambiente() {
    # código aqui
    return 0
}

# Código principal
main() {
    echo "Iniciando script..."
    verificar_ambiente
}

# Execução
main "$@"
```

## Permissões e Execução

### 🔒 Configurando Permissões
```bash
# Tornar script executável
chmod +x script.sh

# Permissões específicas
chmod 755 script.sh  # rwxr-xr-x
```

### 🎯 Modos de Execução
```bash
# Diferentes formas de executar
./script.sh         # Executável
bash script.sh      # Interpretador explícito
source script.sh    # Carregar no shell atual
. script.sh         # Forma curta do source
```

## Debug e Troubleshooting

### 🐛 Modo Debug
```bash
#!/bin/bash -x    # Debug completo
set -x            # Iniciar debug
set +x            # Parar debug

# Debug seletivo
set -x
comando_complexo
set +x
```

### ⚠️ Tratamento de Erros
```bash
# Strict mode
set -euo pipefail

# Tratamento de erros
if ! comando; then
    echo "Erro ao executar comando" >&2
    exit 1
fi
```

## Boas Práticas

### 📚 Documentação
```bash
#!/bin/bash
# 
# Nome: MeuScript
# Descrição: Faz algo incrível
# Uso: ./meu_script.sh [opções]
# Opções:
#   -h  Mostra ajuda
#   -v  Modo verbose
```

### 🎯 Validação de Input
```bash
# Verificar argumentos
if [[ $# -lt 1 ]]; then
    echo "Erro: Argumentos insuficientes" >&2
    echo "Uso: $0 arquivo" >&2
    exit 1
fi

# Verificar arquivo
if [[ ! -f "$1" ]]; then
    echo "Erro: Arquivo não encontrado: $1" >&2
    exit 1
fi
```

## Exercícios Práticos

### 🎯 Missão 1: Script Básico
```bash
#!/bin/bash
# Criar um script que:
# 1. Aceite um argumento
# 2. Valide o input
# 3. Execute uma ação
# 4. Trate erros
```

### 🎯 Missão 2: Debug
```bash
#!/bin/bash
# Objetivos:
# 1. Adicionar modo debug
# 2. Implementar logs
# 3. Tratar erros
# 4. Testar diferentes cenários
```

## Próximos Passos

1. [Variáveis e Tipos](variables-and-types.md)
2. [Estruturas de Controle](control-structures.md)
3. [Funções](functions.md)

---

> "Todo script poderoso começa com um bom shebang."

```ascii
    FUNDAMENTOS CARREGADOS
    [██████████░░░░] 60%
    STATUS: APRENDENDO
    PRÓXIMO: VARIÁVEIS
```