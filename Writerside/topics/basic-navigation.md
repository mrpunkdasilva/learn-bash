# Fundamentos da Navegação 🎯

## Conceitos Básicos

### PWD - Print Working Directory
```bash
pwd                     # Mostra diretório atual
pwd -P                 # Mostra caminho físico (resolve links simbólicos)
pwd -L                 # Mostra caminho lógico (padrão)
echo $PWD              # Variável de ambiente do diretório atual
```

### LS - List Directory Contents
```bash
# Listagens básicas
ls                      # Lista simples
ls -l                   # Formato longo
ls -a                   # Mostra arquivos ocultos
ls -h                   # Tamanhos legíveis (human-readable)
ls -R                   # Lista recursiva
ls -S                   # Ordena por tamanho
ls -t                   # Ordena por data de modificação
ls -X                   # Ordena por extensão

# Combinações úteis
ls -lah                 # Listagem completa e legível
ls -ltr                 # Ordem reversa por data
ls -ld */               # Lista apenas diretórios
ls -1                   # Uma entrada por linha
```

### CD - Change Directory
```bash
# Navegação básica
cd /                    # Vai para raiz
cd ~                    # Home do usuário
cd                      # Também vai para home
cd ..                   # Sobe um nível
cd -                    # Último diretório

# Navegação avançada
cd ~/Documents          # Caminho relativo ao home
cd "Pasta Com Espaços"  # Caminhos com espaços
cd ../pasta_irmã        # Navegação relativa
```

## Truques e Dicas

### Autocompletar
```bash
# Use TAB para:
cd /e<TAB>             # Completa para /etc
cd /u/l/b<TAB>         # Completa caminhos longos
ls *.p<TAB>            # Completa arquivos por padrão
```

### Histórico de Navegação
```bash
history | grep cd      # Mostra comandos cd anteriores
!!                     # Repete último comando
!cd                    # Repete último comando cd
```

### Atalhos do Shell
```bash
CTRL + L               # Limpa a tela
CTRL + W               # Apaga última palavra
CTRL + U               # Apaga linha inteira
CTRL + A               # Início da linha
CTRL + E               # Fim da linha
```

## Configurações Úteis

### Aliases de Navegação
```bash
# Adicione ao seu .bashrc
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
```

### Funções de Navegação
```bash
# Função para criar e entrar em diretório
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Função para voltar N diretórios
up() {
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
        do
            d=$d/..
        done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}
```

## Exercícios Práticos

### Nível Iniciante
1. Liste todos os arquivos no seu diretório home, incluindo ocultos
2. Navegue até /etc e liste seu conteúdo em formato longo
3. Volte para seu diretório home usando diferentes métodos
4. Use pwd para verificar sua localização após cada movimento

### Nível Intermediário
1. Crie uma estrutura de diretórios aninhada e navegue por ela
2. Use ls com diferentes combinações de flags
3. Pratique o uso de autocompletar em caminhos longos
4. Experimente os atalhos do shell

### Nível Avançado
1. Configure aliases personalizados para navegação
2. Crie funções de navegação customizadas
3. Implemente um sistema de bookmarks para diretórios
4. Pratique navegação usando apenas atalhos do teclado

## Troubleshooting Comum

### Problemas e Soluções
```bash
# Permissão negada
ls -ld /caminho        # Verificar permissões
sudo ls /caminho       # Acessar com privilégios

# Diretório não encontrado
pwd                    # Confirmar localização atual
ls -la ..             # Verificar diretório pai
find / -name "dir"    # Procurar diretório perdido
```

## Dicas de Produtividade

1. Use o histórico do shell sabiamente
2. Aprenda os atalhos do teclado
3. Configure aliases para comandos frequentes
4. Mantenha uma estrutura de diretórios organizada
5. Use autocompletar sempre que possível

---

> "A navegação eficiente no terminal é como um superpoder - quanto mais você pratica, mais poderoso se torna."