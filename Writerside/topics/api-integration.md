# Integração com APIs

> Aprenda a integrar seus scripts com APIs RESTful e criar automações poderosas.
> {style="note"}

## Requisições Básicas

### 🌐 HTTP Requests
```bash
#!/bin/bash
# Funções básicas de API
api_get() {
    local url=$1
    local token=$2
    
    curl -s -H "Authorization: Bearer $token" \
         -H "Content-Type: application/json" \
         "$url"
}

api_post() {
    local url=$1
    local data=$2
    local token=$3
    
    curl -s -X POST \
         -H "Authorization: Bearer $token" \
         -H "Content-Type: application/json" \
         -d "$data" \
         "$url"
}
```

### 🔐 Autenticação
```bash
#!/bin/bash
# Gerenciamento de tokens
get_token() {
    local api_key=$1
    local api_secret=$2
    local auth_url=$3
    
    local response=$(curl -s -X POST \
        -H "Content-Type: application/json" \
        -d "{\"key\":\"$api_key\",\"secret\":\"$api_secret\"}" \
        "$auth_url")
    
    echo "$response" | jq -r '.token'
}
```

## Integração Avançada

### 📡 Webhooks
```bash
#!/bin/bash
# Servidor webhook básico
start_webhook() {
    local port=${1:-8080}
    
    while true; do
        echo -e "HTTP/1.1 200 OK\n\n$(date)" | \
        nc -l -p $port -q 1 | \
        while read line; do
            echo "$line" >> webhook.log
            # Processa webhook
            process_webhook "$line"
        done
    done
}
```

### 🔄 Polling
```bash
#!/bin/bash
# Monitora API por mudanças
poll_api() {
    local url=$1
    local interval=${2:-60}
    local token=$3
    
    while true; do
        response=$(api_get "$url" "$token")
        process_updates "$response"
        sleep "$interval"
    done
}
```

## Processamento de Dados

### 📊 Manipulação JSON
```bash
#!/bin/bash
# Processamento de respostas JSON
process_json() {
    local json=$1
    
    # Extrai campos específicos
    local items=$(echo "$json" | jq -r '.items[]')
    
    # Processa cada item
    echo "$items" | while read -r item; do
        local id=$(echo "$item" | jq -r '.id')
        local status=$(echo "$item" | jq -r '.status')
        
        # Atualiza status
        if [ "$status" = "pending" ]; then
            process_item "$id"
        fi
    done
}
```

### 📈 Rate Limiting
```bash
#!/bin/bash
# Controle de taxa de requisições
rate_limit() {
    local requests=${1:-60}  # requisições
    local period=${2:-60}    # segundos
    local delay=$(bc <<< "scale=2; $period/$requests")
    
    sleep "$delay"
}
```

## Exercícios Práticos

### 🎯 Missão 1: Cliente API
```bash
#!/bin/bash
# Objetivos:
# 1. Implementar cliente REST
# 2. Gerenciar autenticação
# 3. Processar respostas
# 4. Implementar retry

# Exemplo de implementação
api_client() {
    local base_url=$1
    local token=$(get_token "$API_KEY" "$API_SECRET" "$AUTH_URL")
    
    # Implementar lógica do cliente
}
```


---

> "APIs são as pontes que conectam sistemas isolados em uma rede de possibilidades."

```ascii
    API INTEGRATION
    [🌐🌐🌐🌐🌐] 100%
    STATUS: INTEGRADOR MESTRE
    PRÓXIMO: ORQUESTRAÇÃO
```