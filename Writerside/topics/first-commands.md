# Primeiros Comandos: Hackeando a Matrix 

> Confira o script de exemplo em `code/module1/first-commands/basic_operations.sh` para ver uma demonstração prática das operações básicas com arquivos e diretórios.
> {style="note"}

```ascii
    INICIANDO SEQUÊNCIA DE COMANDOS...
    ==================================
    STATUS: PRONTO PARA HACKEAR
    NÍVEL DE ACESSO: INICIANTE
    PERIGO: BAIXO (por enquanto)
    ==================================
```

## Comandos Básicos de Sobrevivência

### 🔍 Reconhecimento do Terreno

#### PWD (Print Working Directory)
```bash
pwd     # Mostra o caminho completo do diretório atual
pwd -P  # Mostra o caminho físico (resolve links simbólicos)
pwd -L  # Mostra o caminho lógico (padrão)
```

#### LS (List)
```bash
ls              # Lista arquivos e diretórios
ls -l           # Formato longo com detalhes
ls -a           # Mostra arquivos ocultos
ls -h           # Tamanhos legíveis (1K, 234M, 2G)
ls -R           # Lista recursiva
ls -lart        # Combinação: long, hidden, reverse, time
```

#### CD (Change Directory)
```bash
cd              # Vai para o diretório home
cd -            # Volta para o último diretório
cd ..           # Sobe um nível
cd ../../       # Sobe dois níveis
cd ~/Documents  # Caminho absoluto
cd ./pasta      # Caminho relativo
```

#### CLEAR
```bash
clear           # Limpa a tela
Ctrl + L        # Atalho para limpar
reset           # Reinicia o terminal completamente
```

### 📂 Operações de Arquivo Avançadas

#### TOUCH
```bash
touch arquivo.txt          # Cria arquivo ou atualiza timestamp
touch -t 202312311200     # Define data/hora específica
touch -r ref.txt novo.txt # Copia timestamp de outro arquivo
```

#### CAT (Concatenate)
```bash
cat arquivo.txt           # Mostra conteúdo
cat -n arquivo.txt       # Mostra números das linhas
cat -b arquivo.txt       # Numera apenas linhas não vazias
cat arq1.txt arq2.txt    # Concatena arquivos
cat > arquivo.txt        # Cria arquivo e aguarda input
```

#### CP (Copy)
```bash
cp origem.txt destino.txt     # Copia arquivo
cp -r pasta1 pasta2          # Copia diretório recursivamente
cp -i arquivo.txt backup/    # Modo interativo
cp -u *.txt destino/         # Copia apenas arquivos mais novos
cp -v arquivo.txt ~/backup/  # Modo verbose
```

#### MV (Move)
```bash
mv arquivo.txt ~/Documents/   # Move arquivo
mv arquivo.txt novo_nome.txt # Renomeia arquivo
mv -i *.txt destino/         # Modo interativo
mv -u *.txt destino/         # Move apenas arquivos mais novos
mv -v arquivo.txt ~/backup/  # Modo verbose
```

## Modo Tutorial Interativo Expandido

### 🎮 Mini-Game: Dominando o Terminal

#### Nível 1: Reconhecimento Básico
```bash
# Missão: Explorar o Território
pwd                         # Identifique sua localização
ls -la                     # Analise o ambiente detalhadamente
cd ~                       # Retorne à base (home)
clear                      # Limpe seus rastros

# Checkpoint 1: Navegação Avançada
cd /                       # Vá para a raiz do sistema
ls -lh                     # Analise com tamanhos legíveis
cd /etc                    # Entre no diretório de configurações
cd -                       # Volte ao último diretório
```

#### Nível 2: Manipulação de Arquivos
```bash
# Missão: Criar sua Base de Operações
mkdir operacao_alpha       # Crie sua base secreta
cd operacao_alpha         # Entre na base
touch log.txt config.txt   # Crie arquivos de missão
ls -la                    # Verifique a criação

# Checkpoint 2: Modificação de Arquivos
echo "Início da missão" > log.txt     # Adicione conteúdo
echo "Status: Ativo" >> log.txt       # Append conteúdo
cat log.txt                           # Verifique o conteúdo
cp log.txt backup_log.txt            # Crie backup
```

#### Nível 3: Operações Combinadas
```bash
# Missão: Manipulação Avançada
mkdir -p projetos/{alfa,beta,gamma}   # Crie estrutura complexa
touch projetos/{alfa,beta,gamma}/readme.txt  # Múltiplos arquivos
ls -R projetos                        # Verifique estrutura
find projetos -name "*.txt"          # Localize arquivos
```

## Comandos de Informação Detalhados

### 📊 Status e Ajuda Avançada

#### Informações do Sistema
```bash
date                  # Data e hora atual
date +"%Y-%m-%d"     # Formato personalizado
whoami               # Usuário atual
id                   # Informações de ID do usuário
uname -a             # Todas as informações do sistema
hostname             # Nome do computador
```

#### Ajuda e Documentação
```bash
man comando          # Manual completo
comando --help       # Ajuda rápida
info comando         # Documentação detalhada
whatis comando       # Descrição curta
whereis comando      # Localiza binário, fonte e manual
```

### 💡 Dicas Rápidas Avançadas

| Comando | Descrição | Nível de Poder | Exemplo |
|---------|-----------|----------------|---------|
| `!!` | Repete último comando | ⚡⚡ | `sudo !!` |
| `!$` | Último argumento | ⚡⚡⚡ | `mkdir pasta && cd !$` |
| `!*` | Todos argumentos | ⚡⚡⚡ | `echo !*` |
| `!:n` | n-ésimo argumento | ⚡⚡⚡⚡ | `!:2` |
| `^old^new` | Substitui no último comando | ⚡⚡⚡⚡ | `^foo^bar` |
| `history` | Histórico de comandos | ⚡⚡⚡⚡ | `history \| grep git` |

## Primeiros Scripts Avançados

### 🛠️ Scripts de Poder

#### Script de Backup Básico
```bash
#!/bin/bash
# backup_script.sh
echo "Iniciando backup..."

# Variáveis
SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/Backups"
DATE=$(date +%Y%m%d)

# Criar diretório de backup
mkdir -p "$BACKUP_DIR"

# Realizar backup
tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE_DIR"

echo "Backup completo: backup_$DATE.tar.gz"
```

#### Script de Monitoramento
```bash
#!/bin/bash
# monitor.sh
echo "Monitorando sistema..."

# Informações do sistema
echo "CPU Usage:"
top -bn1 | head -n 3

echo "Memory Usage:"
free -h

echo "Disk Usage:"
df -h
```

## Combinando Comandos - Técnicas Avançadas

### 🔗 Operadores e Redirecionamento

#### Operadores Lógicos
```bash
# AND (&&) - Execução condicional
mkdir projeto && cd projeto && touch readme.md

# OR (||) - Fallback
ping -c 1 google.com || echo "Sem conexão"

# Semicolon (;) - Execução sequencial
echo "Início" ; sleep 2 ; echo "Fim"
```

#### Redirecionamento
```bash
# Output redirection
echo "log entry" > log.txt      # Sobrescreve
echo "new entry" >> log.txt     # Append
ls /naoexiste 2> erro.log      # Redireciona erro

# Pipe
ps aux | grep bash             # Filtra processos
ls -la | sort -k5 -n          # Ordena por tamanho
cat arquivo.txt | wc -l       # Conta linhas
```

## Exercícios Práticos Avançados

### 🎯 Missões de Elite

#### Missão #1: Reconhecimento Avançado
```bash
# Objetivo: Mapeamento completo do sistema
pwd
ls -laR | grep "^d"           # Lista todos diretórios
find . -type f -mtime -1      # Arquivos modificados hoje
du -sh * | sort -hr          # Uso de disco ordenado
```

#### Missão #2: Manipulação Avançada
```bash
# Objetivo: Gerenciamento de arquivos
mkdir -p projeto/{src,docs,tests}
touch projeto/src/{main,util,helper}.sh
chmod +x projeto/src/*.sh
find projeto -type f -name "*.sh" -exec ls -l {} \;
```

#### Missão #3: Automação Básica
```bash
# Objetivo: Criar script de automação
cat << 'EOF' > auto_task.sh
#!/bin/bash
echo "Iniciando automação..."
for file in *.txt; do
    echo "Processando $file..."
    cp "$file" "backup_$file"
done
echo "Automação concluída!"
EOF
chmod +x auto_task.sh
```

## Troubleshooting Avançado

### 🔧 Resolução de Problemas Comuns

#### Problemas de Permissão
```bash
# Verificar permissões
ls -la arquivo.txt
# Modificar permissões
chmod u+x script.sh
# Mudar proprietário
sudo chown user:group arquivo.txt
```

#### Problemas de Comando
```bash
# Verificar existência do comando
which comando
# Verificar PATH
echo $PATH
# Atualizar PATH
export PATH=$PATH:/novo/caminho
```

#### Problemas de Processo
```bash
# Listar processos
ps aux | grep processo
# Matar processo
kill -9 PID
# Verificar uso de recursos
top
```

## Power-Ups Avançados (Aliases e Funções)

### ⚡ Configurações de Poder

#### Aliases Avançados
```bash
# Adicione ao .bashrc
alias ll='ls -la'
alias mkdir='mkdir -p'
alias ports='netstat -tulanp'
alias update='sudo apt update && sudo apt upgrade'
alias gh='history | grep'
```

#### Funções Úteis
```bash
# Função para criar e entrar em diretório
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Função para backup rápido
bkp() {
    cp "$1" "$1.bak"
}

# Função para extrair arquivos
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' não pode ser extraído via extract()" ;;
        esac
    else
        echo "'$1' não é um arquivo válido"
    fi
}
```

## Próximos Passos

Agora que você domina os comandos básicos e avançados:

1. [Explore o Sistema de Arquivos](file-system.md)
   - Estrutura de diretórios
   - Links simbólicos
   - Gerenciamento de espaço

2. [Aprenda sobre Permissões](permissions.md)
   - Permissões básicas e avançadas
   - ACLs
   - Sticky bits

3. [Domine o Processamento de Texto](text-processing.md)
   - sed
   - awk
   - grep avançado

4. [Automação com Scripts](scripting.md)
   - Loops
   - Condicionais
   - Funções

---

> "O terminal é como um lightsaber: uma arma elegante, de tempos mais civilizados."
> - Obi-Wan KenTerminal

```ascii
    PROGRESSO DE TREINAMENTO...
    [██████████████████] 90%
    STATUS: HACKER EM FORMAÇÃO
    PRÓXIMO NÍVEL: MESTRE DO TERMINAL
    
    CARREGANDO MÓDULOS AVANÇADOS...
    ==============================
    PODER: AUMENTANDO
    CONHECIMENTO: EXPANDINDO
    TERMINAL: DOMINADO
```