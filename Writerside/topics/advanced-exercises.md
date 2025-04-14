# Exercícios Avançados 🔥

## Automação Avançada

### Exercício 1: Deploy Automatizado
Crie um script que:
1. Clone um repositório Git
2. Execute testes
3. Faça build
4. Deploy para servidor

```bash
#!/bin/bash
# deploy.sh
repo=$1
branch=$2

git clone "$repo"
cd "$(basename "$repo" .git)"
git checkout "$branch"

# Executar testes
if ! make test; then
    echo "Testes falharam!"
    exit 1
fi

# Build e deploy
make build
rsync -avz dist/ user@server:/var/www/
```

### Exercício 2: Monitor de Rede
Desenvolva um script que:
1. Monitore conexões de rede
2. Alerte sobre problemas
3. Registre estatísticas
4. Gere relatórios

## Integração de Sistemas

### Exercício 3: API Integration
Crie um script que:
1. Faça requisições REST
2. Processe JSON
3. Armazene resultados
4. Gere relatórios

```bash
#!/bin/bash
# api_monitor.sh
api_url="https://api.exemplo.com"
token="seu_token"

response=$(curl -s -H "Authorization: Bearer $token" "$api_url/status")
echo "$response" | jq '.status'
```

### Exercício 4: Cluster Management
Desenvolva scripts para:
1. Gerenciar múltiplos servidores
2. Sincronizar configurações
3. Monitorar recursos
4. Balancear carga

## Desafios Extra

### Challenge 1: Security Audit
Crie uma ferramenta que:
- Analise logs de segurança
- Detecte padrões suspeitos
- Gere alertas
- Tome ações automáticas

### Challenge 2: Database Backup
Implemente um sistema que:
- Faça backup de diferentes DBs
- Valide integridade
- Rotacione backups antigos
- Notifique status

> Estes exercícios requerem conhecimento avançado de Bash e sistemas Unix.
> Consulte a documentação e pratique em ambiente de teste!