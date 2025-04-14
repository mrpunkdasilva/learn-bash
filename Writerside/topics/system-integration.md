# Integração com Sistema 

> Aprenda a integrar scripts com diferentes componentes do sistema operacional.
> {style="note"}

## Integração com Processos

### 🔄 Gerenciamento de Processos

```bash
#!/bin/bash
# process_manager.sh

# Listar processos
list_processes() {
    ps aux | awk '{printf "%-10s %-10s %-5s %-5s\n", $1, $2, $3, $11}'
}

# Monitorar processo
monitor_process() {
    local pid=$1
    while kill -0 "$pid" 2>/dev/null; do
        ps -p "$pid" -o %cpu,%mem,cmd
        sleep 5
    done
}
```

### 📊 Estatísticas do Sistema
```bash
#!/bin/bash
# system_stats.sh

get_system_stats() {
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)"
    
    echo -e "\nMemory Usage:"
    free -h
    
    echo -e "\nDisk Usage:"
    df -h /
}
```

## Integração com Rede

### 🌐 Monitoramento de Rede
```bash
#!/bin/bash
# network_monitor.sh

check_ports() {
    local ports=("80" "443" "3306" "5432")
    
    for port in "${ports[@]}"; do
        if netstat -tuln | grep -q ":$port "; then
            echo "Port $port: OPEN"
        else
            echo "Port $port: CLOSED"
        fi
    done
}

monitor_connections() {
    netstat -ant | awk '{print $6}' | sort | uniq -c | sort -rn
}
```

### 🔒 Segurança de Rede
```bash
#!/bin/bash
# security_check.sh

scan_suspicious() {
    grep "Failed password" /var/log/auth.log | \
        awk '{print $11}' | sort | uniq -c | \
        sort -nr | head -n 10
}

block_ip() {
    local ip=$1
    iptables -A INPUT -s "$ip" -j DROP
}
```

## Integração com Arquivos

### 📁 Monitoramento de Arquivos
```bash
#!/bin/bash
# file_monitor.sh

watch_directory() {
    local dir=$1
    inotifywait -m "$dir" -e create,modify,delete |
    while read -r directory action file; do
        echo "$(date): $action $file"
        handle_file_event "$action" "$file"
    done
}

handle_file_event() {
    local action=$1
    local file=$2
    case "$action" in
        CREATE)
            process_new_file "$file"
            ;;
        MODIFY)
            backup_file "$file"
            ;;
        DELETE)
            restore_from_backup "$file"
            ;;
    esac
}
```

### 🔄 Sincronização de Dados
```bash
#!/bin/bash
# data_sync.sh

sync_directories() {
    local source=$1
    local target=$2
    
    rsync -avz --delete \
          --exclude '*.tmp' \
          --exclude '*.log' \
          "$source/" "$target/"
}
```

## Integração com Banco de Dados

### 💾 Operações de Banco
```bash
#!/bin/bash
# db_operations.sh

db_backup() {
    local db=$1
    local timestamp=$(date +%Y%m%d_%H%M%S)
    
    pg_dump "$db" > "backup_${db}_${timestamp}.sql"
}

db_restore() {
    local db=$1
    local backup=$2
    
    psql "$db" < "$backup"
}
```

## Monitoramento e Logs

### 📊 Coleta de Métricas
```bash
#!/bin/bash
# metrics.sh

collect_metrics() {
    local metrics_file="/var/log/metrics.log"
    
    while true; do
        {
            echo "timestamp: $(date +%s)"
            echo "cpu: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')"
            echo "memory: $(free | grep Mem | awk '{print $3/$2 * 100.0}')"
            echo "disk: $(df -h / | awk 'NR==2 {print $5}' | cut -d% -f1)"
        } >> "$metrics_file"
        
        sleep 60
    done
}
```

### 📝 Gestão de Logs
```bash
#!/bin/bash
# log_manager.sh

rotate_logs() {
    local log_dir="/var/log"
    local max_size=$((100 * 1024 * 1024)) # 100MB
    
    find "$log_dir" -type f -name "*.log" -size +"$max_size"c | 
    while read -r log; do
        gzip -9 "$log"
        mv "${log}.gz" "${log}.$(date +%Y%m%d).gz"
    done
}
```

## Boas Práticas

### ✅ Recomendações
1. Use variáveis de ambiente
2. Implemente tratamento de erros
3. Mantenha logs detalhados
4. Documente integrações
5. Monitore performance

### ⚠️ Pontos de Atenção
1. Gerencie permissões
2. Proteja dados sensíveis
3. Implemente timeouts
4. Valide entradas
5. Faça backup regular

## Próximos Passos

1. [Monitoramento Avançado](advanced-monitoring.md)
2. [Segurança do Sistema](system-security.md)
3. [Automação Avançada](advanced-automation.md)

---

> "A integração eficiente é a chave para um sistema robusto."

```ascii
    SYSTEM INTEGRATION
    [🔄🔄🔄🔄🔄] 100%
    STATUS: INTEGRAÇÃO DOMINADA
    PRÓXIMO: MONITORAMENTO AVANÇADO
```