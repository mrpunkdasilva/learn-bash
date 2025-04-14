# Arquivamento e Compressão

> Domine as técnicas de compactação e gerenciamento de arquivos para otimizar o armazenamento.
> {style="note"}

## Ferramentas de Compactação

### 🔧 Gzip
```bash
# Compactação básica
gzip arquivo.txt            # Compacta para arquivo.txt.gz
gunzip arquivo.txt.gz       # Descompacta
gzip -9 arquivo.txt        # Máxima compressão
gzip -l arquivo.txt.gz     # Lista informações
```

### 🔧 Bzip2
```bash
# Compactação com bzip2
bzip2 arquivo.txt          # Compacta para arquivo.txt.bz2
bunzip2 arquivo.txt.bz2    # Descompacta
bzip2 -9 arquivo.txt      # Máxima compressão
bzcat arquivo.txt.bz2     # Visualiza sem descompactar
```

### 🔧 XZ
```bash
# Compactação com xz
xz arquivo.txt            # Compacta para arquivo.txt.xz
unxz arquivo.txt.xz       # Descompacta
xz -9 arquivo.txt        # Máxima compressão
xzcat arquivo.txt.xz     # Visualiza sem descompactar
```

## Arquivamento com Tar

### 📚 Operações Básicas
```bash
# Criar arquivo tar
tar -cf arquivo.tar dir/     # Cria arquivo tar
tar -czf arquivo.tar.gz dir/ # Cria tar.gz
tar -cjf arquivo.tar.bz2 dir/ # Cria tar.bz2
tar -cJf arquivo.tar.xz dir/  # Cria tar.xz

# Extrair arquivos
tar -xf arquivo.tar         # Extrai tar
tar -xzf arquivo.tar.gz     # Extrai tar.gz
tar -xjf arquivo.tar.bz2    # Extrai tar.bz2
tar -xJf arquivo.tar.xz     # Extrai tar.xz
```

### 📚 Operações Avançadas
```bash
# Visualizar conteúdo
tar -tvf arquivo.tar        # Lista conteúdo
tar -ztvf arquivo.tar.gz    # Lista conteúdo gz

# Adicionar/Atualizar
tar -rf arquivo.tar novo/   # Adiciona ao tar
tar -uf arquivo.tar alterado/ # Atualiza arquivos
```

## Backup e Arquivamento

### 💾 Backup Incremental
```bash
# Backup com data
DATE=$(date +%Y%m%d)
tar -czf backup_$DATE.tar.gz \
    --listed-incremental=backup.snar \
    /dados/

# Restauração incremental
tar -xzf backup_$DATE.tar.gz \
    --listed-incremental=/dev/null
```

### 💾 Backup com Exclusões
```bash
# Excluir padrões
tar -czf backup.tar.gz \
    --exclude='*.tmp' \
    --exclude='*.log' \
    --exclude-vcs \
    /dados/
```

## Compactação Avançada

### 🚀 Compactação Paralela
```bash
# Usando pigz (gzip paralelo)
tar -cf - dir/ | pigz -9 > arquivo.tar.gz

# Usando pbzip2
tar -cf - dir/ | pbzip2 -9 > arquivo.tar.bz2
```

### 🚀 Compactação Seletiva
```bash
# Compactar por tipo
find . -name "*.log" -exec gzip {} \;

# Compactar arquivos antigos
find . -type f -mtime +30 -exec gzip {} \;
```

## Técnicas de Otimização

### ⚡ Compactação Eficiente
```bash
# Melhor razão de compressão
for file in *.txt; do
    gzip -9 "$file" &  # Paralelo
done
wait

# Comparação de métodos
for file in dados.*; do
    size=$(stat -f %z "$file")
    echo "$file: $size bytes"
done
```

### ⚡ Arquivamento Inteligente
```bash
# Backup com verificação
tar -czf backup.tar.gz dir/ && \
md5sum backup.tar.gz > backup.md5

# Verificar integridade
md5sum -c backup.md5
```

## Exercícios Práticos

### 🎯 Missão 1: Backup Automatizado
```bash
#!/bin/bash
# backup_system.sh

BACKUP_DIR="/backup"
SOURCE_DIR="/dados"
DATE=$(date +%Y%m%d_%H%M%S)

# Criar backup compactado
tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" \
    --exclude='*.tmp' \
    --exclude='*.log' \
    "$SOURCE_DIR"

# Manter apenas últimos 5 backups
ls -t "$BACKUP_DIR"/backup_*.tar.gz | \
    tail -n +6 | xargs rm -f
```

### 🎯 Missão 2: Compactação em Lote
```bash
#!/bin/bash
# compress_logs.sh

# Compacta logs antigos
find /var/log -type f -name "*.log" \
    -mtime +7 \
    -exec gzip {} \;

# Remove logs muito antigos
find /var/log -type f -name "*.gz" \
    -mtime +30 \
    -delete
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Espaço insuficiente**: Use `df -h` para verificar
- **Arquivos corrompidos**: Use `gzip -t` para testar
- **Permissões**: Verifique com `ls -l`
- **Performance**: Use versões paralelas dos compactadores

---

> "A arte da compactação está no equilíbrio entre tamanho e velocidade."

```ascii
    COMPACTAÇÃO CONCLUÍDA
    [████████████████] 100%
    RAZÃO: OTIMIZADA
    ESPAÇO: ECONOMIZADO
```