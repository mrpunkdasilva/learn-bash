#!/bin/bash
# Integração com APIs

# Requisição GET
api_get() {
    local endpoint="$1"
    local token="$2"
    
    curl -s -H "Authorization: Bearer $token" \
         -H "Content-Type: application/json" \
         "$endpoint"
}

# Requisição POST
api_post() {
    local endpoint="$1"
    local token="$2"
    local data="$3"
    
    curl -s -X POST \
         -H "Authorization: Bearer $token" \
         -H "Content-Type: application/json" \
         -d "$data" \
         "$endpoint"
}

# Processamento de resposta
process_response() {
    local response="$1"
    jq -r '.data[] | select(.status=="active") | .name' <<< "$response"
}