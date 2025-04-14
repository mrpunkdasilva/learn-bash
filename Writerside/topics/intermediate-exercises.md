# Exercícios Intermediários 

## Scripts e Automação

### Exercício 1: Backup Automatizado
Crie um script que:
1. Aceite um diretório como argumento
2. Crie um backup com data/hora
3. Comprima o backup
4. Liste os backups existentes

```bash
#!/bin/bash
# backup.sh
dir=$1
date=$(date +%Y%m%d_%H%M%S)
tar -czf "backup_${date}.tar.gz" "$dir"
ls -l backup_*.tar.gz
```

### Exercício 2: Monitor de Sistema
Crie um script que mostre:
1. Uso de CPU
2. Memória disponível
3. Espaço em disco
4. Processos ativos

```bash
#!/bin/bash
# monitor.sh
echo "=== Sistema ==="
top -bn1 | head -n 3
echo "=== Memória ==="
free -h
echo "=== Disco ==="
df -h
echo "=== Processos ==="
ps aux | head -n 5
```

## Processamento de Texto

### Exercício 3: Análise de Logs
1. Processe um arquivo de log
2. Conte ocorrências de erros
3. Extraia timestamps
4. Gere relatório

### Exercício 4: Manipulação de CSV
1. Leia um arquivo CSV
2. Filtre colunas específicas
3. Calcule totais
4. Gere novo CSV

## Soluções Disponíveis no Repositório

> Tente resolver os exercícios antes de consultar as soluções!
> Para soluções completas, visite: `github.com/learn-bash/solutions`