# Segurança do Sistema

> Proteja seu sistema com práticas avançadas de segurança.
> {style="warning"}

## Hardening Básico

### 🔒 Configuração Inicial
```bash
# Atualizar sistema
apt update && apt upgrade -y

# Configurar firewall básico
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Configurar SSH seguro
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd
```

### 🛡️ Políticas de Senha
```bash
# Configurar políticas de senha
cat > /etc/security/pwquality.conf << EOF
minlen = 12
minclass = 4
maxrepeat = 3
gecoscheck = 1
EOF

# Configurar expiração de senha
chage -M 90 -m 7 -W 14 usuario
```

## Monitoramento de Segurança

### 👁️ Detecção de Intrusão
```bash
# Instalar e configurar AIDE
apt install aide
aide --init
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Script de verificação
#!/bin/bash
check_system_integrity() {
    aide --check | grep -v 'found valid'
}
```

### 🔍 Análise de Logs
```bash
# Monitor de autenticação
#!/bin/bash
watch_auth() {
    tail -f /var/log/auth.log | while read line; do
        case "$line" in
            *"Failed password"*)
                handle_failed_login "$line"
                ;;
            *"Invalid user"*)
                handle_invalid_user "$line"
                ;;
        esac
    done
}
```

## Controle de Acesso

### 👥 Gestão de Usuários
```bash
# Script de auditoria de usuários
#!/bin/bash
audit_users() {
    # Listar usuários com UID 0
    awk -F: '$3 == 0 {print $1}' /etc/passwd
    
    # Contas sem senha
    awk -F: '($2 == "" || $2 == " ") {print $1}' /etc/shadow
    
    # Usuários com shell de login
    grep -v '/nologin\|/false' /etc/passwd
}
```

### 🔐 Controle de Sudo
```bash
# Configuração segura do sudo
visudo -f /etc/sudoers.d/secure_config

# Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# Defaults logfile="/var/log/sudo.log"
# Defaults requiretty
# Defaults !visiblepw
```

## Proteção de Rede

### 🌐 Firewall Avançado
```bash
#!/bin/bash
# setup_firewall.sh

# Limpar regras existentes
iptables -F
iptables -X

# Políticas padrão
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Regras básicas
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
```

### 📡 Monitoramento de Rede
```bash
#!/bin/bash
# network_monitor.sh

monitor_connections() {
    # Conexões ativas
    netstat -tuln
    
    # Conexões por IP
    netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
    
    # Portas abertas
    lsof -i -P -n
}
```

## Criptografia

### 🔑 Gestão de Chaves
```bash
# Gerar par de chaves
ssh-keygen -t ed25519 -a 100

# Rotacionar chaves
#!/bin/bash
rotate_keys() {
    local key_file="$1"
    local backup_dir="/etc/ssh/keys_backup"
    
    mkdir -p "$backup_dir"
    cp "$key_file" "$backup_dir/$(date +%Y%m%d)_$(basename "$key_file")"
    ssh-keygen -t ed25519 -f "$key_file" -N ""
}
```

### 🔐 Criptografia de Dados
```bash
# Criptografar arquivo
openssl enc -aes-256-cbc -salt -in arquivo.txt -out arquivo.enc

# Criptografar diretório
tar cz diretorio | openssl enc -aes-256-cbc -out diretorio.tar.gz.enc
```

## Auditoria de Segurança

### 📋 Verificações Regulares
```bash
#!/bin/bash
# security_audit.sh

perform_audit() {
    # Verificar permissões
    find / -type f -perm /4000 -ls
    
    # Verificar portas abertas
    ss -tuln
    
    # Verificar processos suspeitos
    ps aux --sort=-%cpu | head -n 20
    
    # Verificar últimos logins
    last | head -n 20
}
```

### 📊 Relatórios de Segurança
```bash
#!/bin/bash
# security_report.sh

generate_report() {
    {
        echo "=== Relatório de Segurança ==="
        date
        
        echo -e "\n=== Usuários Ativos ==="
        who
        
        echo -e "\n=== Tentativas de Login Falhas ==="
        grep "Failed password" /var/log/auth.log | tail -n 10
        
        echo -e "\n=== Portas Abertas ==="
        netstat -tuln
        
        echo -e "\n=== Processos Suspeitos ==="
        ps aux --sort=-%cpu | head -n 10
    } > "security_report_$(date +%Y%m%d).txt"
}
```

## Exercícios Práticos

### 🎯 Missão 1: Hardening
```bash
# Implemente:
# 1. Configuração segura de SSH
# 2. Firewall robusto
# 3. Políticas de senha
# 4. Monitoramento de logs
```

### 🎯 Missão 2: Auditoria
```bash
# Desenvolva:
# 1. Sistema de auditoria
# 2. Relatórios automáticos
# 3. Alertas de segurança
# 4. Respostas automáticas
```

## Próximos Passos

1. [Segurança Avançada](advanced-security.md)
2. [Resposta a Incidentes](incident-response.md)
3. [Compliance e Regulações](compliance.md)

---

> "A segurança não é um produto, é um processo."

```ascii
    SECURITY STATUS
    [🔒🔒🔒🔒🔒] 100%
    SISTEMA: PROTEGIDO
    MONITORAMENTO: ATIVO
    ALERTAS: CONFIGURADOS
```