# Operações Avançadas com Arquivos 🚀

> Este módulo requer conhecimento das operações básicas com arquivos.
> {style="warning"}

```ascii
    OPERAÇÕES AVANÇADAS
    ==================
    STATUS: POWER USER
    NÍVEL: AVANÇADO
    PODER: MÁXIMO
```

## Sincronização com Rsync

### Sincronização Básica
```bash
# Sincronização local
rsync -av fonte/ destino/           # Sincroniza diretórios
rsync -avz --delete fonte/ destino/ # Sincroniza e remove extras
rsync -avP arquivo.iso backup/      # Mostra progresso

# Sincronização remota
rsync -ave ssh fonte/ user@host:/destino/
rsync -avz --exclude '*.tmp' fonte/ destino/
```

## Operações com DD

### Clonagem e Backup
```bash
# Backup de dispositivo
dd if=/dev/sda of=disk.img bs=4M status=progress
dd if=/dev/zero of=/dev/sdb bs=4M    # Limpa dispositivo

# Conversão e cópia
dd if=input.iso of=/dev/usb bs=4M conv=fdatasync
dd if=/dev/urandom of=arquivo bs=1M count=100
```

## Find Avançado

### Busca e Execução
```bash
# Busca com execução
find . -type f -name "*.log" -exec grep "ERROR" {} \;
find . -mtime +30 -delete           # Remove arquivos antigos
find . -size +100M -exec ls -lh {} \;

# Busca com confirmação
find . -name "*.tmp" -ok rm {} \;
```

### Expressões Complexas
```bash
# Combinando condições
find . \( -name "*.jpg" -o -name "*.png" \) -size +1M
find . -type f -not -name "*.txt"
find . -perm 644 -user admin
```

## Xargs Power

### Processamento em Lote
```bash
# Processamento paralelo
find . -name "*.jpg" | xargs -P4 -I{} convert {} {}.png
find . -type f | xargs -P8 md5sum > checksums.txt

# Operações complexas
find . -name "*.bak" | xargs -I{} bash -c 'mv "{}" "$(dirname "{}")/$(date +%F)_$(basename "{}")"'
```

## Monitoramento em Tempo Real

### Inotify Watch
```bash
# Monitoramento de diretório
inotifywait -m -r -e modify,create,delete /path/to/watch
inotifywait -m /var/log/auth.log | while read line; do
    echo "[$(date)] $line" >> /var/log/changes.log
done
```

## Scripts Avançados

### Script de Backup Incremental
```bash
#!/bin/bash
# backup_incremental.sh

BACKUP_DIR="/backup"
SOURCE_DIR="/dados"
DATE=$(date +%Y%m%d)

# Cria backup incremental usando hard links
rsync -av --link-dest="../latest" \
    "$SOURCE_DIR/" "$BACKUP_DIR/$DATE/"

# Atualiza link do último backup
ln -nsf "$DATE" "$BACKUP_DIR/latest"
```

### Script de Processamento em Lote
```bash
#!/bin/bash
# batch_process.sh

process_file() {
    local file="$1"
    local ext="${file##*.}"
    local base="${file%.*}"
    
    case "$ext" in
        jpg|jpeg) convert "$file" -resize 50% "${base}_small.${ext}" ;;
        txt) gzip "$file" ;;
        log) bzip2 "$file" ;;
    esac
}

export -f process_file
find . -type f | parallel process_file
```

## Exercícios Avançados

### 🎯 Missão 1: Backup Inteligente
```bash
# Crie um sistema de backup que:
# 1. Use rsync para sincronização
# 2. Mantenha versões incrementais
# 3. Comprima arquivos antigos
# 4. Gere relatório de mudanças
```

### 🎯 Missão 2: Processamento Massivo
```bash
# Desenvolva um script que:
# 1. Encontre arquivos grandes (+100MB)
# 2. Processe em paralelo
# 3. Gere checksums
# 4. Monitore mudanças
```

## Troubleshooting Avançado

### Diagnóstico
- Use `strace` para debugar operações de arquivo
- Monitore I/O com `iotop`
- Verifique limites do sistema com `ulimit -a`

### Recuperação
```bash
# Recuperação de dados
dd if=/dev/sda of=backup.img conv=noerror,sync
testdisk backup.img           # Analisa estrutura
photorec backup.img          # Recupera arquivos
```

## Próximos Passos

1. [Permissões Avançadas](file-permissions.md)
2. [Sistemas de Arquivos](filesystems.md)
3. [Otimização de I/O](io-optimization.md)

---

> "Com grande poder vem grande responsabilidade. Use estas ferramentas com sabedoria."