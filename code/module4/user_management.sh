#!/bin/bash
# Gerenciamento avançado de usuários

# Configurações
readonly USER_CONFIG="/etc/user_policies.conf"
readonly PASSWORD_POLICY="/etc/security/pwquality.conf"
readonly AUDIT_LOG="/var/log/user_management.log"

# Função de logging
log_action() {
    local action=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $action" >> "$AUDIT_LOG"
}

# Criar usuário com configurações avançadas
create_advanced_user() {
    local username=$1
    local groups=$2
    local shell=${3:-"/bin/bash"}
    
    # Criar usuário
    useradd -m -s "$shell" "$username"
    
    # Adicionar aos grupos
    for group in ${groups//,/ }; do
        usermod -a -G "$group" "$username"
    done
    
    # Gerar senha segura
    local password=$(openssl rand -base64 12)
    echo "$username:$password" | chpasswd
    
    # Forçar troca de senha no próximo login
    chage -d 0 "$username"
    
    log_action "Usuário criado: $username"
    echo "Senha inicial: $password"
}

# Auditoria de usuários
audit_users() {
    echo "=== Auditoria de Usuários ==="
    echo "Usuários com UID 0:"
    awk -F: '($3 == 0) {print}' /etc/passwd
    
    echo -e "\nContas sem senha:"
    awk -F: '($2 == "") {print}' /etc/shadow
    
    echo -e "\nÚltimos logins:"
    last | head -n 10
}

# Rotação de senhas
enforce_password_rotation() {
    local max_days=${1:-90}
    local warn_days=${2:-7}
    
    for user in $(awk -F: '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd); do
        chage -M "$max_days" -W "$warn_days" "$user"
        log_action "Rotação de senha configurada para $user"
    done
}

# Limpeza de usuários inativos
cleanup_inactive_users() {
    local days=${1:-90}
    
    for user in $(lastlog -b "$days" | tail -n+2 | awk '{print $1}'); do
        read -p "Remover usuário inativo $user? (s/N) " confirm
        if [[ $confirm =~ ^[Ss]$ ]]; then
            userdel -r "$user"
            log_action "Usuário removido por inatividade: $user"
        fi
    done
}

# Sincronização de grupos
sync_groups() {
    local group_file=$1
    
    while IFS=: read -r group users; do
        # Criar grupo se não existir
        groupadd -f "$group"
        
        # Adicionar usuários ao grupo
        for user in ${users//,/ }; do
            if id "$user" &>/dev/null; then
                usermod -a -G "$group" "$user"
            else
                echo "Usuário não existe: $user"
            fi
        done
    done < "$group_file"
}

# Menu principal
main_menu() {
    while true; do
        echo -e "\n=== Gerenciamento de Usuários ==="
        echo "1. Criar novo usuário"
        echo "2. Realizar auditoria"
        echo "3. Forçar rotação de senhas"
        echo "4. Limpar usuários inativos"
        echo "5. Sincronizar grupos"
        echo "6. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                read -p "Username: " username
                read -p "Grupos (separados por vírgula): " groups
                read -p "Shell [/bin/bash]: " shell
                create_advanced_user "$username" "$groups" "${shell:-/bin/bash}"
                ;;
            2)
                audit_users
                ;;
            3)
                read -p "Máximo de dias [90]: " max_days
                read -p "Dias de aviso [7]: " warn_days
                enforce_password_rotation "${max_days:-90}" "${warn_days:-7}"
                ;;
            4)
                read -p "Dias de inatividade [90]: " days
                cleanup_inactive_users "${days:-90}"
                ;;
            5)
                read -p "Arquivo de grupos: " group_file
                sync_groups "$group_file"
                ;;
            6)
                exit 0
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
    done
}

# Verificar se é root
if [[ $EUID -ne 0 ]]; then
    echo "Este script precisa ser executado como root"
    exit 1
fi

main_menu