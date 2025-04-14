# Glossário 

## A

### Alias
Atalho para um comando ou série de comandos.
```bash
alias ll='ls -la'
```

### Argumento
Valor passado para um comando ou script.
```bash
cp arquivo1.txt arquivo2.txt  # arquivo1.txt e arquivo2.txt são argumentos
```

## B

### Bash
Bourne Again Shell - interpretador de comandos padrão em muitos sistemas Unix-like.

### Built-in
Comando interno do Bash, não um programa separado.
```bash
cd, pwd, echo  # exemplos de built-ins
```

## E

### Environment Variable
Variável que afeta o comportamento do shell e programas.
```bash
$PATH, $HOME, $USER  # exemplos de variáveis de ambiente
```

### Exit Code
Valor retornado por um comando indicando sucesso (0) ou erro (não-0).
```bash
echo $?  # mostra o último exit code
```

## P

### Pipeline
Conexão da saída de um comando com a entrada de outro.
```bash
comando1 | comando2
```

### Prompt
Indicador de que o shell está pronto para receber comandos.
```bash
$  # prompt padrão para usuários normais
#  # prompt padrão para root
```

## S

### Shell Script
Arquivo contendo comandos Bash para execução.
```bash
#!/bin/bash  # shebang indica que é um script Bash
```

### Shebang
Primeira linha de um script indicando o interpretador.
```bash
#!/bin/bash
#!/usr/bin/env python3
```

## W

### Wildcard
Caractere especial para matching de padrões.
```bash
*.txt  # match qualquer arquivo .txt
```