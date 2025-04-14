# Gerenciador de Logs 

## Visão Geral
Sistema de análise de logs com coleta centralizada, parsing inteligente e alertas.

## Estrutura
```bash
log-manager/
├── collector/
│   ├── agent.sh
│   └── parser.sh
├── analyzer/
│   ├── analyze.sh
│   └── rules.yaml
├── storage/
│   └── database.sh
└── web/
    └── dashboard.php
```

## Implementação

### 1. Agente Coletor
```bash
#!/bin/bash
# collector/agent.sh

# Configuração
LOG_DIRS=("/var/log/nginx" "/var/log/apache2" "/var/log/mysql")
CENTRAL_SERVER="logs.example.com"

collect_logs() {
    for dir in "${LOG_DIRS[@]}"; do
        find "$dir" -type f -name "*.log" -exec \
            ./parser.sh {} \; | \
            nc "$CENTRAL_SERVER" 514
    done
}

watch_logs() {
    inotifywait -m "${LOG_DIRS[@]}" -e modify |
    while read -r directory events filename; do
        if [[ "$filename" =~ \.log$ ]]; then
            ./parser.sh "$directory/$filename"
        fi
    done
}

main() {
    collect_logs
    watch_logs
}

main "$@"
```

### 2. Parser Inteligente
```bash
#!/bin/bash
# collector/parser.sh

parse_log_line() {
    local line="$1"
    
    # Detectar formato
    if [[ "$line" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2} ]]; then
        parse_standard_format "$line"
    elif [[ "$line" =~ ^\[[0-9]+\] ]]; then
        parse_bracketed_format "$line"
    else
        parse_custom_format "$line"
    fi
}

parse_standard_format() {
    awk '{
        timestamp=$1" "$2
        level=$3
        message=substr($0, index($0,$4))
        printf "{\"timestamp\":\"%s\",\"level\":\"%s\",\"message\":\"%s\"}\n",
            timestamp, level, message
    }'
}

while IFS= read -r line; do
    parse_log_line "$line"
done < "$1"
```

### 3. Análise em Tempo Real
```bash
#!/bin/bash
# analyzer/analyze.sh

# Carregar regras
source "$(dirname "$0")/rules.yaml"

analyze_log() {
    while read -r log_entry; do
        # Parse JSON
        level=$(echo "$log_entry" | jq -r .level)
        message=$(echo "$log_entry" | jq -r .message)
        
        # Aplicar regras
        for rule in "${RULES[@]}"; do
            if [[ "$message" =~ ${rule[pattern]} ]]; then
                trigger_alert "${rule[name]}" "$message"
            fi
        done
    done
}

trigger_alert() {
    local rule_name="$1"
    local message="$2"
    
    # Enviar alerta
    curl -X POST "$ALERT_ENDPOINT" \
         -H "Content-Type: application/json" \
         -d "{
             \"rule\": \"$rule_name\",
             \"message\": \"$message\",
             \"timestamp\": \"$(date -u +%FT%TZ)\"
         }"
}

main() {
    analyze_log
}

main "$@"
```

## Como Usar

1. Instale os agentes:
```bash
./install_agent.sh
```

2. Configure regras:
```yaml
# analyzer/rules.yaml
rules:
  - name: "Error Detection"
    pattern: "ERROR|FATAL|CRITICAL"
    action: "email"
  - name: "Security Alert"
    pattern: "unauthorized|forbidden|invalid"
    action: "slack"
```

3. Inicie o sistema:
```bash
./start_collector.sh
./start_analyzer.sh
```

## Recursos Avançados

- Coleta distribuída
- Parsing inteligente
- Análise em tempo real
- Alertas customizáveis
- Dashboard web
- Armazenamento eficiente