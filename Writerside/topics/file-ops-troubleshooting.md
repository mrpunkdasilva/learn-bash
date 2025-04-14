# Troubleshooting de Operações com Arquivos 

## Diagnóstico Sistemático

### 🔍 Verificação Inicial
```bash
# Checagem básica
ls -la                    # Permissões e propriedade
df -h                    # Espaço em disco
pwd                     # Confirma diretório atual
whoami                 # Confirma usuário atual
```

### 📊 Análise Detalhada
```bash
# Investigação profunda
strace cp arquivo1 arquivo2    # Debug de sistema
lsof arquivo                  # Arquivos abertos
fuser -v arquivo            # Processos usando arquivo
iostat -x 1               # Monitoramento de I/O
```

## Problemas Comuns e Soluções

### 🚫 Permissão Negada
```bash
# Diagnóstico
namei -l /caminho/completo    # Verifica cadeia de permissões
getfacl arquivo              # Lista ACLs
sudo -l                     # Lista permissões sudo

# Correção
chmod u+rw arquivo          # Adiciona permissões
chown usuario:grupo arquivo # Muda proprietário
setfacl -m u:usuario:rw arquivo  # Configura ACL
```

### 💾 Espaço em Disco
```bash
# Análise
du -sh * | sort -hr         # Uso por diretório
find . -size +100M         # Arquivos grandes
ncdu                      # Navegador de uso

# Limpeza
find . -name "*.tmp" -delete  # Remove temporários
journalctl --vacuum-time=2d  # Limpa logs antigos
docker system prune        # Limpa Docker
```

### 🔒 Arquivos Travados
```bash
# Identificação
lsof | grep arquivo         # Processos usando
fuser -k arquivo          # Mata processos (cuidado!)

# Liberação
sync                     # Sincroniza buffers
umount -l /montagem     # Desmonta forçado
```

### 🔗 Links Quebrados
```bash
# Detecção
find . -type l -! -exec test -e {} \; -print  # Links quebrados
readlink -f link                             # Resolve link

# Correção
ln -sf alvo link        # Recria link simbólico
find . -xtype l -delete # Remove links quebrados
```

## Scripts de Diagnóstico

### 📝 Verificador de Sistema de Arquivos
```bash
#!/bin/bash
# fs_check.sh

check_filesystem() {
    local path="${1:-.}"
    
    echo "=== Verificação do Sistema de Arquivos ==="
    echo "Diretório: $path"
    echo
    
    echo "1. Espaço em Disco:"
    df -h "$path"
    echo
    
    echo "2. Permissões Suspeitas:"
    find "$path" -type f -perm /o+w
    echo
    
    echo "3. Links Quebrados:"
    find "$path" -type l -! -exec test -e {} \; -print
    echo
    
    echo "4. Arquivos Grandes (>100MB):"
    find "$path" -type f -size +100M -exec ls -lh {} \;
}
```

### 🔄 Monitor de Operações
```bash
#!/bin/bash
# ops_monitor.sh

monitor_operations() {
    local file="$1"
    
    echo "Monitorando operações em $file..."
    
    inotifywait -m "$file" |
    while read -r directory events filename; do
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $events"
        
        case "$events" in
            OPEN) check_open "$file" ;;
            MODIFY) check_modify "$file" ;;
            ACCESS) check_access "$file" ;;
        esac
    done
}
```

## Prevenção e Manutenção

### 🛡️ Backup Automático
```bash
#!/bin/bash
# auto_backup.sh

backup_before_operation() {
    local file="$1"
    local backup_dir="${2:-./backup}"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    
    mkdir -p "$backup_dir"
    cp -a "$file" "$backup_dir/${file##*/}_$timestamp"
}
```

### 📋 Checklist de Manutenção
```bash
# Verificações Diárias
find /var/log -type f -mtime +30 -delete  # Limpa logs
find /tmp -type f -mtime +7 -delete      # Limpa temporários
du -sh /* | sort -hr > disk_usage.log   # Relatório de disco
```

## Exercícios Práticos

### 🎯 Missão 1: Sistema de Diagnóstico
```bash
# Desenvolva um sistema que:
# 1. Monitore operações críticas
# 2. Detecte problemas comuns
# 3. Aplique correções automáticas
# 4. Mantenha logs de troubleshooting
```

### 🎯 Missão 2: Recuperação de Desastres
```bash
# Crie um plano que:
# 1. Identifique falhas críticas
# 2. Implemente backups automáticos
# 3. Defina procedimentos de recuperação
# 4. Teste cenários de falha
```

## Próximos Passos

1. [System Monitoring](system-monitoring.md)
2. [Backup Strategies](backup-strategies.md)
3. [Disaster Recovery](disaster-recovery.md)

---

> "O melhor troubleshooting é aquele que previne problemas antes que aconteçam."

```ascii
    DIAGNÓSTICO
    [🔍🔍🔍🔍🔍] 100%
    STATUS: RESOLVIDO
    SISTEMA: ESTÁVEL
```