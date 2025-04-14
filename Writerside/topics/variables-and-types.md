# Variáveis e Tipos: Dominando os Dados 📊

## Variáveis Básicas

### 📝 Declaração e Atribuição
```bash
# Declaração básica
nome="Terminal Master"
idade=25
ativo=true

# Declaração explícita
declare -i numero=42    # Inteiro
declare -r CONSTANTE="Valor"  # Readonly
declare -l minusculo="TEXTO"  # Lowercase
declare -u MAIUSCULO="texto"  # Uppercase
```

### 🔄 Escopo de Variáveis
```bash
# Variável local
local_var="Local"

# Variável global
GLOBAL_VAR="Global"

# Variável de ambiente
export ENV_VAR="Environment"
```

## Tipos de Dados

### 🔢 Números
```bash
# Inteiros
declare -i numero=42
((numero++))
((resultado = numero * 2))

# Operações aritméticas
soma=$((5 + 3))
produto=$((4 * 3))
divisao=$((10 / 2))
modulo=$((15 % 4))
```

### 📝 Strings
```bash
# Manipulação de strings
texto="Hello World"
tamanho=${#texto}
substring=${texto:0:5}
substituir=${texto/World/Bash}

# Concatenação
nome="Terminal"
sobrenome="Master"
completo="$nome $sobrenome"
```

### 📚 Arrays
```bash
# Array simples
frutas=("maçã" "banana" "laranja")
echo "${frutas[0]}"      # Primeiro elemento
echo "${frutas[@]}"      # Todos elementos
echo "${#frutas[@]}"     # Tamanho do array

# Array associativo
declare -A usuarios
usuarios[admin]="root"
usuarios[user]="guest"
```

## Manipulação de Variáveis

### 🔧 Operações com Variáveis
```bash
# Expansão de variáveis
echo ${var:-default}     # Valor default
echo ${var:=default}     # Atribuir default
echo ${var:?erro}        # Erro se não definida
echo ${var:+valor}       # Valor se definida

# Manipulação de strings
echo ${var#prefixo}      # Remove prefixo
echo ${var%sufixo}       # Remove sufixo
echo ${var/old/new}      # Substitui primeira ocorrência
echo ${var//old/new}     # Substitui todas ocorrências
```

### 📊 Validação e Teste
```bash
# Testes de variáveis
[[ -z "$var" ]]         # Vazia?
[[ -n "$var" ]]         # Não vazia?
[[ "$a" == "$b" ]]      # Iguais?
[[ "$num" -eq 42 ]]     # Igual (números)?
```

## Exercícios Práticos

### 🎯 Missão 1: Manipulação de Dados
```bash
#!/bin/bash
# Objetivos:
# 1. Criar e manipular arrays
# 2. Processar strings
# 3. Realizar operações matemáticas
# 4. Validar dados
```

### 🎯 Missão 2: Processamento de Dados
```bash
#!/bin/bash
# Objetivos:
# 1. Ler dados de arquivo
# 2. Processar informações
# 3. Armazenar em estruturas
# 4. Gerar relatório
```

## Melhores Práticas

### ✅ Recomendações
1. Use nomes descritivos
2. Declare tipos quando possível
3. Inicialize variáveis
4. Valide dados de entrada
5. Use constantes apropriadamente

### ⚠️ Armadilhas Comuns
1. Espaços na atribuição
2. Variáveis não declaradas
3. Escopo incorreto
4. Tipo de dados errado
5. Falta de aspas

## Próximos Passos

1. [Estruturas de Controle](control-structures.md)
2. [Funções](functions.md)
3. [Manipulação Avançada](advanced-data.md)

---

> "Variáveis são como caixas mágicas: o conteúdo importa mais que o rótulo."

```ascii
    TIPOS DE DADOS CARREGADOS
    [████████████░░] 80%
    STATUS: PROCESSANDO
    PRÓXIMO: CONTROLE DE FLUXO
```