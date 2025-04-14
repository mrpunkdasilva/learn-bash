# Estratégias de Backup

> Aprenda a implementar estratégias eficientes de backup para garantir a segurança dos seus dados.
> {style="note"}

## Tipos de Backup

### 💾 Backup Completo
```bash
#!/bin/bash
# full_backup.sh

full_backup() {
    local source="$1"
    local dest="$2"
    local date=$(date +%Y%m%d)
    
    tar -czf "$dest/full_$date.tar.gz" "$source"
    
    # Gerar checksum
    md5sum "$dest/full_$date.tar.gz" > "$dest/full_$date.md5"
}
```

### 🔄 Backup Incremental
```bash
#!/bin/bash
# incremental_backup.sh

incremental_backup() {
    local source="$1"
    local dest="$2"
    local date=$(date +%Y%m%d)
    
    rsync -av --link-dest="../latest" \
        "$source/" "$dest/$date/"
    
    ln -nsf "$date" "$dest/latest"
}
```

### 📊 Backup Diferencial
```bash
#!/bin/bash
# differential_backup.sh

differential_backup() {
    local source="$1"
    local dest="$2"
    local base="$3"
    local date=$(date +%Y%m%d)
    
    find "$source" -newer "$base" -type f \
        -exec tar -rf "$dest/diff_$date.tar" {} \;
    
    gzip "$dest/diff_$date.tar"
}
```

## Rotação de Backups

### 🔄 Estratégia GFS
```bash
#!/bin/bash
# gfs_rotation.sh

maintain_gfs() {
    local backup_dir="$1"
    
    # Manter últimos 7 diários
    find "$backup_dir/daily" -mtime +7 -delete
    
    # Manter últimas 4 semanas
    find "$backup_dir/weekly" -mtime +28 -delete
    
    # Manter últimos 12 meses
    find "$backup_dir/monthly" -mtime +365 -delete
}
```

### ⏰ Retenção Automática
```bash
#!/bin/bash
# retention.sh

cleanup_old_backups() {
    local backup_dir="$1"
    local retention_days="$2"
    
    find "$backup_dir" -name "backup_*.tar.gz" \
        -mtime +"$retention_days" -delete
    
    # Limpar checksums órfãos
    find "$backup_dir" -name "*.md5" \
        -type f ! -exec test -e "${1%.md5}" \; -delete
}
```

## Compressão e Criptografia

### 🗜️ Compressão Otimizada
```bash
#!/bin/bash
# compression.sh

compress_backup() {
    local source="$1"
    local algorithm="${2:-gzip}"
    
    case "$algorithm" in
        gzip)
            tar -czf "backup.tar.gz" "$source"
            ;;
        bzip2)
            tar -cjf "backup.tar.bz2" "$source"
            ;;
        xz)
            tar -cJf "backup.tar.xz" "$source"
            ;;
    esac
}
```

### 🔒 Criptografia
```bash
#!/bin/bash
# encryption.sh

encrypt_backup() {
    local file="$1"
    local recipient="$2"
    
    # Criptografar com GPG
    gpg --encrypt --recipient "$recipient" "$file"
    
    # Remover original após criptografia
    shred -u "$file"
}
```

## Verificação e Validação

### ✅ Verificação de Integridade
```bash
#!/bin/bash
# verify_backup.sh

verify_backup() {
    local backup_file="$1"
    local checksum_file="$2"
    
    if ! md5sum -c "$checksum_file"; then
        echo "Erro: Backup corrompido!" >&2
        return 1
    fi
    
    # Testar extração
    tar -tzf "$backup_file" >/dev/null
}
```

### 📋 Relatórios
```bash
#!/bin/bash
# backup_report.sh

generate_report() {
    local backup_dir="$1"
    local report_file="$2"
    
    {
        echo "=== Relatório de Backup ==="
        echo "Data: $(date)"
        echo
        echo "Backups Realizados:"
        find "$backup_dir" -type f -name "*.tar.gz" \
            -exec ls -lh {} \;
        echo
        echo "Espaço Total:"
        du -sh "$backup_dir"
    } > "$report_file"
}
```

## Automação

### 🤖 Agendamento
```bash
#!/bin/bash
# schedule_backup.sh

# Adicionar ao crontab:
# 0 1 * * * /path/to/backup.sh
# 0 3 * * 0 /path/to/weekly_backup.sh
# 0 5 1 * * /path/to/monthly_backup.sh
```

### 📬 Notificações
```bash
#!/bin/bash
# notify.sh

notify_backup_status() {
    local status="$1"
    local email="$2"
    
    mail -s "Backup Status: $status" "$email" <<EOF
Backup completado em: $(date)
Status: $status
Detalhes: Ver anexo
EOF
}
```

## Boas Práticas

### 💡 Recomendações
1. Teste seus backups regularmente
2. Mantenha cópias offsite
3. Documente procedimentos
4. Automatize verificações
5. Monitore espaço em disco

### ⚠️ Pontos de Atenção
1. Segurança dos dados
2. Performance do sistema
3. Janelas de backup
4. Custos de armazenamento
5. Compliance e regulações

## Próximos Passos

1. [Disaster Recovery](disaster-recovery.md)
2. [Storage Management](storage-management.md)
3. [Security Best Practices](security-practices.md)

---

> "Backup não é sobre salvar dados, é sobre restaurar negócios."

```ascii
    BACKUP STATUS
    [💾💾💾💾💾] 100%
    PROTEÇÃO: ATIVA
    PRÓXIMO: RECOVERY
```