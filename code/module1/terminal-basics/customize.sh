#!/bin/bash
# Personalização do terminal

# Configuração de cores
export TERM=xterm-256color

# PS1 Cyberpunk style
PS1='\[\e[1;32m\][\[\e[1;36m\]\u\[\e[1;32m\]@\[\e[1;36m\]\h\[\e[1;32m\]]\[\e[1;36m\]\w\[\e[1;32m\]\$\[\e[0m\] '

# Aliases básicos
alias ll='ls -la'
alias cls='clear'
alias matrix='echo -e "\e[32m" && tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'