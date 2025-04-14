# Segurança no Linux 🔒

> Este módulo aborda conceitos e práticas essenciais de segurança no Linux.
> {style="note"}

## Permissões Básicas

### 👤 Gerenciamento de Usuários
```bash
# Usuários e grupos
useradd -m usuario     # Cria usuário com home
usermod -aG grupo usuario  # Adiciona ao grupo
passwd usuario         # Define senha
id usuario            # Info do usuário

# Sudoers
visudo               # Edita sudoers
sudo -l              # Lista permissões
```

### 📁 Permissões de Arquivos
```bash
# Chmod básico
chmod 755 arquivo     # rwxr-xr-x
chmod u+x arquivo     # Adiciona execução
chmod g-w arquivo     # Remove escrita do grupo
chmod o-rwx arquivo   # Remove tudo de outros

# Chmod avançado
chmod -R 644 ./      # Recursivo
chmod --reference=ref arquivo  # Copia permissões
```

## Hardening do Sistema

### 🛡️ Configuração Básica
```bash
# Atualizações
apt update && apt upgrade -y   # Debian/Ubuntu
dnf update -y                  # RHEL/Fedora

# Serviços
systemctl list-units --type=service  # Lista
systemctl disable serviço     # Desativa
systemctl mask serviço       # Previne ativação
```

### 🔐 SSH Seguro
```bash
# Configuração SSH
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Chaves SSH
ssh-keygen -t ed25519 -C "comentario"
ssh-copy-id usuario@host
```

## Monitoramento de Segurança

### 👁️ Logs e Auditoria
```bash
# Logs básicos
tail -f /var/log/auth.log     # Autenticação
tail -f /var/log/syslog       # Sistema
journalctl -f                 # Systemd logs

# Auditoria
ausearch -k auth              # Eventos de auth
aureport --summary           # Relatório
```

### 🔍 Detecção de Intrusão
```bash
# Verificação de arquivos
find / -type f -perm -4000    # SUID files
find / -nouser -o -nogroup    # Sem dono
lsof -i                       # Conexões abertas

# Processos
ps auxf                       # Árvore de processos
netstat -tupln               # Portas abertas
```

## Criptografia

### 🔑 Gerenciamento de Chaves
```bash
# GPG
gpg --gen-key                # Gera chave
gpg -e -r "user" arquivo     # Encripta
gpg -d arquivo.gpg           # Decripta

# SSL/TLS
openssl genrsa -out key.pem 2048   # Chave privada
openssl req -new -key key.pem -out cert.csr  # CSR
```

### 💾 Criptografia de Disco
```bash
# LUKS
cryptsetup luksFormat /dev/sdb1    # Formata
cryptsetup luksOpen /dev/sdb1 cripto  # Abre
cryptsetup luksClose cripto          # Fecha
```

## Scripts de Segurança

### 🤖 Monitor de Segurança
```bash
#!/bin/bash
# security_monitor.sh

# Monitora tentativas de login
watch_auth() {
    tail -f /var/log/auth.log | while read line; do
        if echo "$line" | grep -q "Failed password"; then
            ip=$(echo "$line" | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
            echo "Tentativa falha de: $ip"
            # Opcional: bloqueia IP
            # iptables -A INPUT -s $ip -j DROP
        fi
    done
}

# Verifica portas suspeitas
check_ports() {
    netstat -tupln | while read line; do
        if echo "$line" | grep -qE ":(6666|6667|6668)"; then
            echo "Porta suspeita detectada: $line"
        fi
    done
}
```

### 🔄 Backup Seguro
```bash
#!/bin/bash
# secure_backup.sh

# Backup com criptografia
backup_encrypt() {
    local src="$1"
    local dest="$2"
    local key="$3"
    
    tar czf - "$src" | \
    openssl enc -aes-256-cbc -salt -k "$key" > "$dest"
}

# Restauração
backup_decrypt() {
    local src="$1"
    local dest="$2"
    local key="$3"
    
    openssl enc -d -aes-256-cbc -k "$key" -in "$src" | \
    tar xzf - -C "$dest"
}
```

## Exercícios Práticos

### 🎯 Missão 1: Auditoria Básica
```bash
#!/bin/bash
# audit_system.sh

# Verifica permissões sensíveis
check_permissions() {
    echo "Verificando permissões..."
    find /etc -type f -perm /o+w
    find /home -type f -perm /o+w
}

# Verifica usuários
check_users() {
    echo "Usuários com shell:"
    grep -v '/nologin\|/false' /etc/passwd
}

# Verifica serviços
check_services() {
    echo "Serviços ativos:"
    systemctl list-units --type=service --state=active
}
```

### 🎯 Missão 2: Hardening
```bash
#!/bin/bash
# harden_system.sh

# Configurações básicas
basic_hardening() {
    # Desativa serviços não essenciais
    systemctl disable telnet
    systemctl disable rsh
    
    # Configura limites
    echo "* hard core 0" >> /etc/security/limits.conf
    
    # Fortalece sysctl
    cat >> /etc/sysctl.conf << EOF
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
EOF
}
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Permissões**: Use `ls -la` e `namei -l`
- **SSH**: Verifique logs com `journalctl -u ssh`
- **Firewall**: Teste com `iptables -L`
- **Serviços**: Analise com `systemctl status`

---

> "A segurança não é um produto, é um processo." - Bruce Schneier

```ascii
    MONITOR DE SEGURANÇA
    [████████████] ATIVO
    SISTEMA: PROTEGIDO
    ALERTAS: 0
```