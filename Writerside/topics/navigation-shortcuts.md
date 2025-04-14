# Atalhos de Navegação

> Domine os atalhos e técnicas para navegar rapidamente pelo sistema de arquivos.
> {style="note"}

## Atalhos do Terminal

### Movimentação no Comando
```bash
# Movimentação básica
CTRL + A              # Início da linha
CTRL + E              # Fim da linha
ALT + B               # Palavra anterior
ALT + F               # Próxima palavra
CTRL + XX             # Alterna entre início e posição atual

# Edição
CTRL + W              # Apaga palavra anterior
CTRL + U              # Apaga do cursor até início
CTRL + K              # Apaga do cursor até fim
CTRL + Y              # Cola último texto apagado
ALT + D               # Apaga próxima palavra
```

### Histórico e Busca
```bash
# Navegação no histórico
CTRL + R              # Busca reversa no histórico
CTRL + S              # Busca para frente no histórico
CTRL + G              # Cancela busca
!!                    # Repete último comando
!$                    # Último argumento do comando anterior
!*                    # Todos argumentos do comando anterior

# Modificadores de histórico
!!:p                  # Exibe último comando sem executar
!-n                   # Executa comando n posições atrás
!string               # Executa último comando começando com string
^string1^string2^     # Substitui string1 por string2 no último comando
```

## Atalhos de Diretório

### Jumping Directories
```bash
# Atalhos básicos
cd -                  # Último diretório
cd                    # Home
cd ~user              # Home do usuário
pushd +n              # Rotaciona n posições na pilha
popd                  # Remove topo da pilha

# Bookmarks personalizados
export CDPATH=.:~/projetos:/var/www
alias cdp='cd ~/projetos'
alias cdd='cd ~/Downloads'
alias cdw='cd ~/workspace'
```

### Smart Directory Navigation
```bash
# Função de jump inteligente
j() {
    local dir
    dir=$(find ~/projetos -type d -name "*$1*" | head -1)
    if [ -d "$dir" ]; then
        cd "$dir"
    else
        echo "Diretório não encontrado"
    fi
}

# Auto-jumping baseado em frequência
frecent() {
    local dir
    dir=$(sort -rn ~/.frecent | grep -i "$1" | head -1 | cut -f2)
    [ -d "$dir" ] && cd "$dir"
}
```

## Atalhos de Comando

### Command Line Editing
```bash
# Edição rápida
fc                    # Edita último comando
CTRL + X + E          # Edita comando atual no editor
set -o vi             # Modo vi
set -o emacs          # Modo emacs (padrão)

# Substituições rápidas
^foo^bar              # Substitui primeira ocorrência
!!:gs/foo/bar/        # Substitui todas ocorrências
```

### Command Completion
```bash
# Tab completion avançado
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
complete -F _command sudo
```

## Customização Avançada

### Aliases Inteligentes
```bash
# Aliases condicionais
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --color=auto'

# Aliases com funções
mcd() { mkdir -p "$1" && cd "$1"; }
cls() { cd "$1" && ls; }
```

### Keyboard Shortcuts
```bash
# Bind customizado
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-p": previous-history'
bind '"\C-n": next-history'
```

## Produtividade Máxima

### Workflow Optimization
```bash
# Funções de produtividade
function mkcd() { mkdir -p "$@" && cd "$_"; }
function up() { cd $(printf "%0.s../" $(seq 1 $1)); }
function back() { cd "$OLDPWD"; }
```

### Task Automation
```bash
# Scripts de automação
alias update='sudo apt update && sudo apt upgrade'
alias serve='python -m http.server'
alias ports='netstat -tulanp'
```

## Exercícios e Práticas

### Básicos
1. Configure aliases básicos
2. Pratique atalhos de movimentação
3. Use histórico eficientemente
4. Implemente bookmarks simples

### Avançados
1. Crie funções de navegação customizadas
2. Configure completion avançado
3. Implemente sistema de aliases dinâmicos
4. Desenvolva workflows automatizados

## Dicas de Performance

1. Memorize atalhos mais usados
2. Mantenha aliases organizados
3. Use completion sempre que possível
4. Automatize tarefas repetitivas
5. Mantenha histórico limpo e útil

---

> "A velocidade vem da prática, mas os atalhos são o caminho mais rápido para lá."