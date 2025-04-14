# Automação de Navegação: Poder Máximo 🤖

## Scripts de Navegação

### Navegador Inteligente
```bash
#!/bin/bash
# smart_nav.sh
# Navegador inteligente com histórico e frequência

# Configuração
HISTORY_FILE="$HOME/.nav_history"
BOOKMARKS_FILE="$HOME/.nav_bookmarks"
touch "$HISTORY_FILE" "$BOOKMARKS_FILE"

# Função principal de navegação
smart_nav() {
    local target="$1"
    
    # Verifica bookmarks primeiro
    if grep -q "^$target:" "$BOOKMARKS_FILE"; then
        cd "$(grep "^$target:" "$BOOKMARKS_FILE" | cut -d: -f2)"
        return
    fi
    
    # Busca no histórico
    local dir=$(grep -i "$target" "$HISTORY_FILE" | sort -r | head -1)
    if [ -n "$dir" ] && [ -d "$dir" ]; then
        cd "$dir"
        return
    fi
    
    # Busca fuzzy em diretórios comuns
    local found=$(find ~/projetos ~/documentos -type d -iname "*$target*" 2>/dev/null | head -1)
    if [ -n "$found" ]; then
        cd "$found"
        return
    fi
    
    echo "Destino não encontrado: $target"
}
```

### Sistema de Bookmarks
```bash
# Gerenciador de bookmarks
bookmark() {
    case "$1" in
        add)
            echo "$2:$(pwd)" >> "$BOOKMARKS_FILE"
            echo "Bookmark '$2' adicionado"
            ;;
        remove)
            sed -i "/^$2:/d" "$BOOKMARKS_FILE"
            echo "Bookmark '$2' removido"
            ;;
        list)
            cat "$BOOKMARKS_FILE"
            ;;
        *)
            echo "Uso: bookmark [add|remove|list] [nome]"
            ;;
    esac
}
```

## Automação de Workspace

### Projeto Automático
```bash
# Configuração de workspace automática
setup_workspace() {
    local project="$1"
    local template="$2"
    
    # Cria estrutura base
    mkdir -p "$project"/{src,docs,tests,resources}
    
    # Aplica template se especificado
    if [ -n "$template" ] && [ -d "$HOME/.templates/$template" ]; then
        cp -r "$HOME/.templates/$template"/* "$project/"
    fi
    
    # Inicializa git
    cd "$project"
    git init
    
    # Cria arquivo de configuração
    cat > .workspace-config <<EOF
PROJECT_NAME=$project
CREATED_AT=$(date +%Y-%m-%d)
TEMPLATE=$template
EOF
    
    echo "Workspace $project configurado com sucesso!"
}
```

### Monitor de Diretório
```bash
# Monitora mudanças e executa ações
watch_dir() {
    local dir="${1:-.}"
    local action="$2"
    
    inotifywait -m -e create,modify,delete "$dir" |
    while read -r directory events filename; do
        echo "Evento: $events em $filename"
        if [ -n "$action" ]; then
            eval "$action \"$filename\""
        fi
    done
}
```

## Automação de Tarefas

### Sincronização Automática
```bash
# Sincroniza diretórios automaticamente
auto_sync() {
    local source="$1"
    local target="$2"
    local interval="${3:-300}" # 5 minutos padrão
    
    while true; do
        rsync -av --delete "$source/" "$target/"
        echo "Sincronizado em $(date)"
        sleep "$interval"
    done
}
```

### Limpeza Automática
```bash
# Mantém diretórios organizados
auto_clean() {
    local dir="${1:-.}"
    local days="${2:-7}"
    
    # Remove arquivos antigos
    find "$dir" -type f -mtime +"$days" -delete
    
    # Organiza por extensão
    for file in "$dir"/*.*; do
        if [ -f "$file" ]; then
            ext="${file##*.}"
            mkdir -p "$dir/$ext"
            mv "$file" "$dir/$ext/"
        fi
    done
}
```

## Integração com Sistema

### Auto-mounting
```bash
# Monta dispositivos automaticamente
auto_mount() {
    local device="$1"
    local mountpoint="$2"
    
    if [ ! -d "$mountpoint" ]; then
        sudo mkdir -p "$mountpoint"
    fi
    
    sudo mount "$device" "$mountpoint"
    echo "Montado $device em $mountpoint"
}
```

### Backup Automático
```bash
# Sistema de backup incremental
auto_backup() {
    local source="$1"
    local dest="$2"
    local date=$(date +%Y%m%d)
    
    # Cria backup incremental
    rsync -av --link-dest="../latest" "$source/" "$dest/$date/"
    
    # Atualiza link do último backup
    ln -nsf "$date" "$dest/latest"
}
```

## Exemplos Práticos

### Workflow Desenvolvimento
```bash
# Configura ambiente de desenvolvimento
dev_env() {
    local project="$1"
    
    # Terminal 1: Editor
    tmux new-session -d -s "$project"
    tmux send-keys "cd $project && vim" C-m
    
    # Terminal 2: Servidor
    tmux split-window -h
    tmux send-keys "cd $project && npm start" C-m
    
    # Terminal 3: Git
    tmux split-window -v
    tmux send-keys "cd $project && git status" C-m
    
    # Anexa à sessão
    tmux attach-session -t "$project"
}
```

### Monitor de Recursos
```bash
# Monitora recursos do sistema
monitor_resources() {
    while true; do
        clear
        echo "=== Sistema ==="
        date
        echo "=== CPU ==="
        top -bn1 | head -n 3
        echo "=== Memória ==="
        free -h
        echo "=== Disco ==="
        df -h /
        sleep 5
    done
}
```

## Dicas e Boas Práticas

1. Mantenha logs de todas automações
2. Implemente tratamento de erros
3. Use variáveis de configuração
4. Documente todas as funções
5. Faça backup antes de automações críticas

---

> "Automatize tudo que fizer mais de duas vezes."