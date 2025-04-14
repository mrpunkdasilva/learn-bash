# Configuração do Bash ⚙️

## Arquivos de Configuração

### `.bashrc`
Principal arquivo de configuração para shells interativos:

```bash
# Exemplo de .bashrc
# Cores no prompt
export PS1="\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\$ "

# Aliases úteis
alias ll='ls -la'
alias update='sudo apt update && sudo apt upgrade'
alias gh='history | grep'

# Variáveis de ambiente
export PATH="$HOME/bin:$PATH"
export EDITOR="vim"
```

### `.bash_profile`
Para configuração de login:

```bash
# Carrega .bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Configurações específicas de login
export LANG=pt_BR.UTF-8
```

## Personalização

### Prompt (PS1)
```bash
# Prompt simples com cores
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '

# Prompt informativo
PS1='\D{%F %T} \u@\h:\w\$ '
```

### Aliases Essenciais
```bash
# Navegação
alias ..='cd ..'
alias ...='cd ../..'

# Segurança
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Utilitários
alias mkdir='mkdir -p'
alias ports='netstat -tulanp'
```

## Variáveis de Ambiente

```bash
# História
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups

# Localização
export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8

# Editores
export EDITOR=vim
export VISUAL=code
```