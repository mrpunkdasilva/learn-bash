# Estruturas de Controle: Dominando o Fluxo 

## Condicionais

### 🔍 If/Else
```bash
# Estrutura básica
if [[ condição ]]; then
    comando
elif [[ outra_condição ]]; then
    outro_comando
else
    comando_final
fi

# Exemplo prático
if [[ -f "$arquivo" ]]; then
    echo "Arquivo existe"
elif [[ -d "$arquivo" ]]; then
    echo "É um diretório"
else
    echo "Não encontrado"
fi
```

### 🔀 Case
```bash
# Estrutura case
case "$variavel" in
    padrão1)
        comandos
        ;;
    padrão2|padrão3)
        outros_comandos
        ;;
    *)
        comando_default
        ;;
esac

# Exemplo prático
case "$opcao" in
    start|--start)
        iniciar_servico
        ;;
    stop|--stop)
        parar_servico
        ;;
    *)
        mostrar_ajuda
        ;;
esac
```

## Loops

### 🔁 For
```bash
# Loop básico
for i in {1..5}; do
    echo "$i"
done

# Loop em array
for elemento in "${array[@]}"; do
    processar "$elemento"
done

# Loop C-style
for ((i=0; i<10; i++)); do
    echo "$i"
done
```

### 🔄 While
```bash
# Loop while básico
while [[ condição ]]; do
    comandos
done

# Exemplo: ler arquivo
while IFS= read -r linha; do
    processar "$linha"
done < "arquivo.txt"

# Loop infinito
while true; do
    monitorar_sistema
    sleep 1
done
```

### 🔁 Until
```bash
# Loop until
until [[ condição ]]; do
    comandos
done

# Exemplo prático
count=0
until [[ $count -ge 5 ]]; do
    echo "$count"
    ((count++))
done
```

## Controle de Fluxo

### ⏹️ Break e Continue
```bash
# Break
for i in {1..10}; do
    if [[ $i -eq 5 ]]; then
        break
    fi
    echo "$i"
done

# Continue
for i in {1..5}; do
    if [[ $i -eq 3 ]]; then
        continue
    fi
    echo "$i"
done
```

### 🚪 Exit
```bash
# Saída com status
if [[ erro ]]; then
    echo "Erro encontrado" >&2
    exit 1
fi

# Saída condicional
[[ $# -eq 0 ]] && { echo "Argumentos necessários"; exit 1; }
```

## Exercícios Práticos

### 🎯 Missão 1: Controle de Fluxo
```bash
#!/bin/bash
# Objetivos:
# 1. Implementar menu interativo
# 2. Processar múltiplos arquivos
# 3. Validar entradas
# 4. Tratar erros
```

### 🎯 Missão 2: Automação
```bash
#!/bin/bash
# Objetivos:
# 1. Monitorar recursos
# 2. Processar logs
# 3. Backup automático
# 4. Relatórios periódicos
```

## Melhores Práticas

### ✅ Recomendações
1. Use condições claras
2. Evite loops infinitos
3. Trate casos especiais
4. Valide entradas
5. Use exit codes apropriados

### ⚠️ Armadilhas Comuns
1. Loops infinitos acidentais
2. Condições mal formadas
3. Break/continue mal utilizados
4. Exit codes incorretos
5. Falta de tratamento de erro

## Próximos Passos

1. [Funções](functions.md)
2. [Tratamento de Erros](error-handling.md)
3. [Otimização](optimization.md)

---

> "O fluxo de controle é como água: sempre encontra seu caminho."

```ascii
    CONTROLE DE FLUXO DOMINADO
    [███████████████] 90%
    STATUS: FLUINDO
    PRÓXIMO: FUNÇÕES
```