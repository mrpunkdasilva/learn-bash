# Gerenciamento de Usuários 

## Comandos Básicos

### 👤 Usuários
```bash
# Criar e modificar usuários
useradd -m -s /bin/bash usuario  # Cria usuário
usermod -aG grupo usuario        # Adiciona a grupo
passwd usuario                   # Define senha
userdel -r usuario              # Remove usuário

# Informações
id usuario                      # Info do usuário
who                            # Usuários logados
w                              # Quem está fazendo o quê
last                           # Histórico de login
```

### 👥 Grupos
```bash
# Gerenciamento de grupos
groupadd grupo                 # Cria grupo
groupmod -n novo_nome grupo    # Renomeia
groupdel grupo                 # Remove grupo
gpasswd -a usuario grupo      # Adiciona ao grupo
```

## Permissões e Segurança

### 🔐 Controle de Acesso
```bash
# Permissões básicas
chmod 755 arquivo              # Define permissões
chown usuario:grupo arquivo    # Muda proprietário
chgrp grupo arquivo           # Muda grupo

# ACLs
setfacl -m u:usuario:rw arquivo  # Define ACL
getfacl arquivo                  # Lista ACLs
```

### 🛡️ Sudo e Privilégios
```bash
# Configuração sudo
visudo                        # Edita sudoers
sudo -l                       # Lista permissões
sudo -u usuario comando       # Executa como usuário
```

## Exercícios Práticos

### 🎯 Missão 1: Gestão Básica
```bash
#!/bin/bash
# setup_user.sh

# Cria usuário com ambiente básico
setup_user() {
    local usuario=$1
    local grupo=$2

    # Cria usuário
    useradd -m -s /bin/bash "$usuario"
    
    # Define grupo primário
    usermod -g "$grupo" "$usuario"
    
    # Configura ambiente
    cp /etc/skel/.* "/home/$usuario/"
    chown -R "$usuario:$grupo" "/home/$usuario"
}
```

### 🎯 Missão 2: Auditoria
```bash
#!/bin/bash
# audit_users.sh

# Auditoria de usuários
audit_users() {
    echo "=== Usuários do Sistema ==="
    awk -F: '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd
    
    echo -e "\n=== Grupos ==="
    for user in $(awk -F: '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd); do
        echo -n "$user: "
        groups "$user"
    done
}
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Senha esquecida**: Use `passwd` como root
- **Grupos incorretos**: Verifique com `groups` e `id`
- **Permissões**: Use `ls -l` e `namei -l`
- **Sudo**: Verifique `/var/log/auth.log`

---

> "Com grandes privilégios vêm grandes responsabilidades."