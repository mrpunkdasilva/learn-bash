# Monitoramento de Arquivos: Vigilância em Tempo Real 👀

## Ferramentas de Monitoramento

### 🔍 Inotify
```bash
# Monitoramento básico
inotifywait -m /path/to/watch    # Monitor simples
inotifywait -m -r /path         # Recursivo
inotifywait -m -e modify,create,delete /path  # Eventos específicos

# Monitor com logging
inotifywait -m /path | while read dir event file; do
    echo "$(date): $event em $file" >> /var/log/file_changes.log
done
```

### 🕵️ Watch
```bash
# Monitoramento periódico
watch -n 1 ls -l /path          # Atualiza a cada segundo
watch -d ls -l /path           # Destaca mudanças
watch -g 'ls -l | wc -l'      # Para quando houver mudança
```

## Scripts de Monitoramento

### 📝 Monitor de Mudanças
```bash
#!/bin/bash
# change_monitor.sh

monitor_directory() {
    local dir="${1:-.}"
    local log="${2:-changes.log}"
    
    inotifywait -m -r -e modify,create,delete "$dir" |
    while read -r directory events filename; do
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $events: $directory$filename" >> "$log"
        
        case "$events" in
            MODIFY) handle_modify "$directory$filename" ;;
            CREATE) handle_create "$directory$filename" ;;
            DELETE) handle_delete "$directory$filename" ;;
        esac
    done
}

handle_modify() {
    local file="$1"
    echo "Arquivo modificado: $file"
    # Adicione ações específicas aqui
}

handle_create() {
    local file="$1"
    echo "Novo arquivo: $file"
    # Adicione ações específicas aqui
}

handle_delete() {
    local file="$1"
    echo "Arquivo removido: $file"
    # Adicione ações específicas aqui
}
```

### 🔄 Backup Automático
```bash
#!/bin/bash
# auto_backup.sh

watch_and_backup() {
    local src="$1"
    local backup_dir="$2"
    
    inotifywait -m -r -e modify,create "$src" |
    while read -r directory events filename; do
        timestamp=$(date +%Y%m%d_%H%M%S)
        cp -a "$directory$filename" "$backup_dir/${filename}_${timestamp}"
        echo "Backup criado: ${filename}_${timestamp}"
    done
}
```

## Alertas e Notificações

### 📧 Notificações por Email
```bash
#!/bin/bash
# notify_changes.sh

notify_admin() {
    local message="$1"
    local subject="Alerta de Arquivo"
    local admin_email="admin@example.com"
    
    echo "$message" | mail -s "$subject" "$admin_email"
}

monitor_critical() {
    local critical_dir="$1"
    
    inotifywait -m -r -e modify,delete "$critical_dir" |
    while read -r directory events filename; do
        notify_admin "Alerta: $events em $directory$filename"
    done
}
```

### 📱 Integração com Sistemas
```bash
#!/bin/bash
# integration.sh

send_webhook() {
    local event="$1"
    local webhook_url="https://webhook.example.com"
    
    curl -X POST "$webhook_url" \
        -H "Content-Type: application/json" \
        -d "{\"event\":\"$event\"}"
}
```

## Análise de Logs

### 📊 Processamento de Logs
```bash
#!/bin/bash
# log_analyzer.sh

analyze_changes() {
    local log_file="$1"
    
    echo "=== Resumo de Mudanças ==="
    echo "Modificações:"
    grep MODIFY "$log_file" | wc -l
    
    echo "Criações:"
    grep CREATE "$log_file" | wc -l
    
    echo "Deleções:"
    grep DELETE "$log_file" | wc -l
}
```

## Exercícios Práticos

### 🎯 Missão 1: Sistema de Vigilância
```bash
# Crie um sistema que:
# 1. Monitore múltiplos diretórios
# 2. Registre todas as mudanças
# 3. Envie alertas críticos
# 4. Mantenha histórico de mudanças
```

### 🎯 Missão 2: Backup Inteligente
```bash
# Desenvolva um sistema que:
# 1. Monitore arquivos importantes
# 2. Faça backup automático
# 3. Mantenha versões
# 4. Limpe backups antigos
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Alto uso de CPU**: Limite eventos monitorados
- **Memória insuficiente**: Reduza diretórios monitorados
- **Perda de eventos**: Use buffer maior
- **Permissões**: Verifique acesso aos diretórios

### 📋 Checklist de Verificação
```bash
# Verificações básicas
systemctl status inotify   # Status do serviço
sysctl -a | grep inotify  # Limites do sistema
lsof | grep inotify      # Processos usando inotify
```

## Próximos Passos

1. [Operações em Lote](batch-operations.md)
2. [File-Ops Troubleshooting](file-ops-troubleshooting.md)
3. [System Monitoring](system-monitoring.md)

---

> "Vigilância constante é o preço da segurança dos dados."

```ascii
    MONITOR ATIVO
    [▓▓▓▓▓▓▓▓▓▓] 100%
    STATUS: VIGILANTE
    EVENTOS: REGISTRANDO
```