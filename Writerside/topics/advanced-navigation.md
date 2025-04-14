# Navegação Avançada 🚀

## Técnicas Avançadas de CD

### Navegação Contextual
```bash
cd -                   # Alterna entre último diretório
cd ~-                  # Expande para último diretório
cd ~+                  # Expande para diretório atual
cd ~usuario            # Home de outro usuário
cd "$(dirname "$0")"   # Diretório do script atual
```

### Navegação com Variáveis
```bash
# Variáveis de ambiente
echo $OLDPWD           # Último diretório
echo $PWD              # Diretório atual
echo $HOME             # Diretório home

# Variáveis customizadas
export PROJETOS=~/projetos
export LOGS=/var/log
cd $PROJETOS
```

### Navegação com Substituição
```bash
# Substituição de comando
cd $(git rev-parse --show-toplevel)  # Raiz do git
cd "$(dirname "$(readlink -f "$0")")" # Dir real do script
cd "$(find . -name 'target' -type d)" # Resultado de busca
```

## Técnicas de Busca e Navegação

### Find Avançado
```bash
# Navegação baseada em resultados
cd "$(find . -name 'pom.xml' -type f -exec dirname {} \;)"
cd "$(find . -type d -name 'src' | head -1)"
```

### CDPATH
```bash
# Configurando CDPATH
export CDPATH=.:~/projetos:/var/www:/opt
cd projeto-x   # Procura em todos os caminhos do CDPATH
```

## Automação de Navegação

### Bookmarks de Diretório
```bash
# Sistema de bookmarks
export DIR_BOOKMARKS=~/.dir_bookmarks

# Função para adicionar bookmark
bookmark() {
    echo "$(pwd)" >> "$DIR_BOOKMARKS"
}

# Função para ir para bookmark
goto() {
    local dir=$(grep -i "$1" "$DIR_BOOKMARKS" | head -1)
    if [ -d "$dir" ]; then
        cd "$dir"
    else
        echo "Bookmark não encontrado"
    fi
}
```

### Navegação por Projeto
```bash
# Função para navegar entre projetos
project() {
    case $1 in
        web) cd ~/projetos/web ;;
        api) cd ~/projetos/api ;;
        docs) cd ~/projetos/documentacao ;;
        *) echo "Projeto não encontrado" ;;
    esac
}
```

## Integração com Ferramentas

### Git Navigation
```bash
# Funções para navegação em repositórios git
cdroot() {
    cd "$(git rev-parse --show-toplevel)"
}

cdbranch() {
    git checkout $1
    cdroot
}
```

### Docker Navigation
```bash
# Funções para navegação em containers
cdcontainer() {
    docker exec -it $1 /bin/bash
}
```

## Stack Navigation Avançada

### Pilha Customizada
```bash
# Implementação avançada de pilha
declare -a DIR_STACK

pushd_custom() {
    DIR_STACK+=("$(pwd)")
    cd "$1"
}

popd_custom() {
    if [ ${#DIR_STACK[@]} -gt 0 ]; then
        local last_index=$((${#DIR_STACK[@]}-1))
        cd "${DIR_STACK[$last_index]}"
        unset 'DIR_STACK[$last_index]'
    fi
}
```

## Exercícios Avançados

### Nível Expert
1. Implemente um sistema de navegação baseado em tags
2. Crie uma função para navegar pelo histórico de diretórios
3. Desenvolva um menu interativo para navegação rápida
4. Integre navegação com ferramentas de desenvolvimento

### Desafios de Automação
1. Crie um script que mantém um log de diretórios visitados
2. Implemente navegação baseada em frequência de uso
3. Desenvolva um sistema de aliases dinâmicos
4. Crie uma função de busca e navegação combinada

## Dicas de Performance

1. Use cache de diretórios frequentes
2. Implemente completion customizado
3. Mantenha histórico de navegação
4. Use atalhos de teclado personalizados
5. Automatize padrões de navegação comuns

---

> "A verdadeira maestria na navegação do terminal vem da combinação de velocidade e precisão."