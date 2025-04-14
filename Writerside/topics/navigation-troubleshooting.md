# Troubleshooting de Navegação: Resolvendo Problemas 🔧

## Problemas Comuns

### Permissões
```bash
# Verificar permissões
ls -la                # Lista detalhada com permissões
namei -l /path/to/dir # Mostra permissões do caminho completo

# Corrigir permissões
chmod -R u+rwx dir    # Recursivamente adiciona permissões
chown -R user:group dir # Muda proprietário recursivamente
```

### Caminhos Quebrados
```bash
# Verificar links simbólicos
find . -type l -ls    # Lista todos links
find . -xtype l       # Encontra links quebrados

# Corrigir links
ln -sf target link   # Força criação/atualização do link
realpath arquivo     # Mostra caminho real
```

## Ferramentas de Diagnóstico

### Análise de Sistema
```bash
# Verificação de disco
df -h                 # Espaço em disco
du -sh *             # Uso por diretório
ncdu                 # Navegador de uso de disco

# Monitoramento
iotop                # Monitoramento de I/O
lsof                 # Arquivos abertos
fuser -m /path       # Processos usando diretório
```

### Debug de Navegação
```bash
# Trace de comandos
set -x               # Ativa debug
pwd -P               # Mostra caminho físico
type cd              # Verifica definição do comando
echo $PATH           # Mostra variável PATH
```

## Recuperação

### Backup Rápido
```bash
# Backup de segurança
cp -a dir dir.bak    # Copia preservando atributos
tar czf backup.tgz dir # Compacta diretório
rsync -av --delete source/ dest/ # Sincroniza com backup
```

### Restauração
```bash
# Recuperar arquivos
cp -a dir.bak/* dir/ # Restaura do backup
tar xzf backup.tgz   # Extrai backup
git checkout -- file # Restaura do git
```

## Prevenção

### Verificações de Segurança
```bash
# Checklist de segurança
function check_dir() {
    local dir="$1"
    echo "Verificando $dir..."
    
    # Permissões
    ls -ld "$dir"
    
    # Links simbólicos
    find "$dir" -type l -ls
    
    # Espaço
    du -sh "$dir"
    
    # Processos
    lsof +D "$dir"
}
```

### Monitoramento Proativo
```bash
# Monitor de mudanças
inotifywait -m -r -e modify,create,delete /path/to/watch

# Logger de ações
function log_cd() {
    echo "$(date): cd $PWD" >> ~/.cd_history
}
trap 'log_cd' DEBUG
```

## Soluções Avançadas

### Recuperação de Diretório
```bash
# Script de recuperação
recover_dir() {
    local dir="$1"
    
    # Verifica backup
    if [ -d "${dir}.bak" ]; then
        echo "Restaurando de backup..."
        rsync -av "${dir}.bak/" "$dir/"
        return
    fi
    
    # Tenta reconstruir
    mkdir -p "$dir"
    find . -name "$(basename "$dir")*" -type f -exec cp {} "$dir/" \;
}
```

### Limpeza de Sistema
```bash
# Limpeza segura
safe_clean() {
    # Remove temporários
    find /tmp -type f -atime +7 -delete
    
    # Remove logs antigos
    find /var/log -type f -name "*.log.*" -mtime +30 -delete
    
    # Limpa caches
    rm -rf ~/.cache/*
}
```

## Casos Especiais

### Sistemas de Arquivos Especiais
```bash
# Montagem NFS
mount -t nfs server:/share /mnt/nfs

# SSHFS
sshfs user@remote:/path /mnt/remote

# Verificação
mount | grep "type"
```

### Problemas de Rede
```bash
# Debug de rede
ping -c 4 server     # Teste básico
traceroute server    # Rota até servidor
mtr server          # Monitoramento contínuo
```

## Checklist de Troubleshooting

1. Verificar Permissões
```bash
ls -la
whoami
groups
```

2. Verificar Espaço
```bash
df -h
du -sh *
```

3. Verificar Processos
```bash
ps aux | grep dir
lsof +D /path
```

4. Verificar Logs
```bash
tail -f /var/log/syslog
journalctl -f
```

## Dicas de Manutenção

### Manutenção Regular
```bash
# Script de manutenção
maintenance() {
    echo "Iniciando manutenção..."
    
    # Verifica sistema de arquivos
    sudo fsck -f /dev/sda1
    
    # Limpa caches
    sudo sync && sudo sysctl -w vm.drop_caches=3
    
    # Otimiza banco de dados
    sudo updatedb
    
    echo "Manutenção concluída!"
}
```

### Monitoramento Contínuo
```bash
# Monitor de saúde
health_check() {
    while true; do
        date
        df -h
        free -h
        uptime
        sleep 300
    done
}
```

---

> "Problemas são oportunidades de aprendizado disfarçadas."