# Operações com Arquivos 📂

> Este módulo cobre todas as operações essenciais com arquivos no Linux, desde o básico até técnicas avançadas.
> {style="note"}

```ascii
    OPERAÇÕES COM ARQUIVOS
    =====================
    STATUS: ATIVO
    NÍVEL: ESSENCIAL
    OPERAÇÕES: COMPLETAS
```

## Visão Geral

Este módulo abrange um conjunto completo de operações com arquivos, incluindo:
- Operações básicas (criar, copiar, mover, remover)
- Operações avançadas (sincronização, clonagem, links)
- Gerenciamento de permissões
- Compactação e arquivamento
- Links simbólicos e hardlinks
- Monitoramento de arquivos
- Operações em lote

## Tópicos do Módulo

### 1. [Operações Básicas](basic-file-ops.md)
- Criação e manipulação de arquivos
- Cópia e movimentação
- Remoção segura
- Redirecionamento de conteúdo

### 2. [Operações Avançadas](advanced-file-ops.md)
- Sincronização com rsync
- Clonagem com dd
- Operações em lote
- Processamento paralelo

### 3. [Permissões de Arquivos](file-permissions.md)
- Permissões básicas
- ACLs avançadas
- SUID, SGID e Sticky Bit
- Atributos especiais

### 4. [Compactação e Arquivamento](archive-compression.md)
- tar, gzip, bzip2
- Compactação avançada
- Arquivamento incremental
- Backup e restauração

### 5. [Links Simbólicos e Hardlinks](symlinks-hardlinks.md)
- Criação de links
- Gerenciamento de links
- Boas práticas
- Troubleshooting

### 6. [Monitoramento de Arquivos](file-monitoring.md)
- inotify e watchdog
- Logs de acesso
- Auditoria de mudanças
- Alertas automáticos

### 7. [Operações em Lote](batch-operations.md)
- find e xargs
- Processamento paralelo
- Automação de tarefas
- Scripts de lote

### 8. [Troubleshooting](file-ops-troubleshooting.md)
- Problemas comuns
- Diagnóstico
- Recuperação
- Melhores práticas

## Ferramentas Essenciais

### 🛠️ Comandos Básicos
```bash
# Criação e Manipulação
touch arquivo.txt              # Cria arquivo
cp origem.txt destino.txt     # Copia arquivo
mv antigo.txt novo.txt        # Move/renomeia
rm arquivo.txt                # Remove arquivo

# Diretórios
mkdir -p dir1/dir2            # Cria diretórios
rmdir diretorio              # Remove diretório vazio
rm -rf diretorio            # Remove recursivamente
```

### 🚀 Comandos Avançados
```bash
# Sincronização
rsync -avz fonte/ destino/   # Sincroniza diretórios
rsync -avz --delete src/ dst/ # Sincroniza e limpa

# Clonagem
dd if=/dev/sda of=disk.img   # Clona dispositivo
dd if=/dev/zero of=file bs=1M count=100  # Cria arquivo

# Links
ln -s arquivo link           # Link simbólico
ln arquivo hardlink         # Hard link
```

## Dicas de Poder

### ⚡ Operações Eficientes
```bash
# Pipeline de processamento
find . -type f -name "*.log" | \
  xargs grep "ERROR" | \
  sort | uniq -c | \
  sort -nr

# Processamento paralelo
find . -name "*.jpg" | \
  parallel convert {} {.}.png
```

### 🔒 Segurança
```bash
# Remoção segura
shred -u arquivo.txt         # Sobrescreve e remove
rm -P arquivo.txt           # Sobrescreve 3 vezes

# Backup seguro
tar czf - /dados | gpg -c > backup.tar.gz.gpg
```

## Exercícios Práticos

### 🎯 Missão 1: Gerenciamento Básico
```bash
# Crie uma estrutura de trabalho
mkdir -p projeto/{src,docs,tests}
touch projeto/src/{main,util}.sh
cp projeto/src/main.sh projeto/docs/
mv projeto/src/util.sh projeto/tests/
```

### 🎯 Missão 2: Operações Avançadas
```bash
# Implemente um sistema de backup
rsync -avz --progress \
  --exclude '*.tmp' \
  --exclude '*.log' \
  fonte/ destino/
```

### 🎯 Missão 3: Automação
```bash
# Crie um script de processamento
find . -type f -name "*.jpg" | \
  while read file; do
    convert "$file" -resize 50% "${file%.*}_small.jpg"
  done
```

## Próximos Passos

Depois de dominar as operações com arquivos:
1. [Scripts e Automação](scripting.md)
2. [Administração do Sistema](system-admin.md)
3. [Redes e Conectividade](network-admin.md)

---

> "O verdadeiro poder vem da capacidade de manipular arquivos com precisão e eficiência."

```ascii
    MÓDULO CONCLUÍDO
    [████████████████] 100%
    STATUS: OPERACIONAL
    PODER: MAXIMIZADO
```