#!/bin/bash
# Administração avançada de rede

# Configurações
readonly NETWORK_LOG="/var/log/network_admin.log"
readonly BACKUP_DIR="/etc/network/backup"
readonly MONITOR_INTERVAL=300

# Logging
log_network() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$NETWORK_LOG"
}

# Backup de configurações
backup_network_config() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    mkdir -p "$BACKUP_DIR"
    
    # Backup de arquivos importantes
    cp /etc/network/interfaces "$BACKUP_DIR/interfaces_$timestamp"
    cp /etc/resolv.conf "$BACKUP_DIR/resolv.conf_$timestamp"
    cp /etc/hosts "$BACKUP_DIR/hosts_$timestamp"
    
    # Backup de regras de firewall
    iptables-save > "$BACKUP_DIR/iptables_$timestamp"
    
    log_network "Backup de configurações realizado"
}

# Diagnóstico de rede
network_diagnostics() {
    local interface=$1
    
    echo "=== Diagnóstico de Rede: $interface ==="
    
    # Status da interface
    ip addr show "$interface"
    
    # Estatísticas
    ip -s link show "$interface"
    
    # Rota padrão
    ip route | grep default
    
    # DNS
    cat /etc/resolv.conf
    
    # Conexões ativas
    ss -tuln
}

# Configuração de firewall
configure_firewall() {
    # Limpar regras existentes
    iptables -F
    iptables -X
    
    # Políticas padrão
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT
    
    # Permitir loopback
    iptables -A INPUT -i lo -j ACCEPT
    
    # Permitir conexões estabelecidas
    iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    
    # Permitir SSH
    iptables -A INPUT -p tcp --dport 22 -j ACCEPT
    
    # Permitir HTTP/HTTPS
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT
    
    log_network "Firewall configurado"
}

# Monitoramento de rede
monitor_network() {
    while true; do
        # Verificar interfaces
        for interface in $(ip -o link show | awk -F': ' '{print $2}'); do
            if ! ip link show "$interface" | grep -q "UP"; then
                log_network "Interface $interface down - tentando recuperar"
                ip link set "$interface" up
            fi
        done
        
        # Verificar conectividade
        if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
            log_network "Perda de conectividade detectada"
            systemctl restart networking
        fi
        
        sleep "$MONITOR_INTERVAL"
    done
}

# Menu principal
main_menu() {
    while true; do
        echo -e "\n=== Administração de Rede ==="
        echo "1. Diagnóstico de interface"
        echo "2. Configurar firewall"
        echo "3. Backup de configurações"
        echo "4. Iniciar monitoramento"
        echo "5. Verificar conexões"
        echo "6. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                read -p "Interface: " interface
                network_diagnostics "$interface"
                ;;
            2)
                configure_firewall
                ;;
            3)
                backup_network_config
                ;;
            4)
                monitor_network &
                echo "Monitoramento iniciado em background"
                ;;
            5)
                ss -tuln
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