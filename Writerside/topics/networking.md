# Redes e Conectividade 🌐

> Este módulo aborda comandos e técnicas essenciais para gerenciamento de rede no Linux.
> {style="note"}

## Comandos Básicos

### 🔍 Diagnóstico de Rede
```bash
# Teste de conectividade
ping google.com          # Teste básico
ping -c 4 8.8.8.8       # Limita a 4 pacotes
ping6 ::1               # Ping IPv6

# Informações de rede
ip addr                 # Interfaces de rede
ip route               # Tabela de roteamento
ifconfig               # Informações (legado)
netstat -tuln          # Portas abertas
ss -tuln               # Alternativa moderna ao netstat
```

### 🌍 DNS e Resolução
```bash
# Consultas DNS
dig google.com          # Consulta detalhada
nslookup google.com     # Consulta simples
host google.com         # Nome para IP
whois google.com        # Informações de domínio

# Arquivo hosts
cat /etc/hosts         # Resolução local
cat /etc/resolv.conf   # Configuração DNS
```

## Monitoramento de Rede

### 📊 Análise de Tráfego
```bash
# Monitoramento em tempo real
iftop                  # Monitor de banda
nethogs               # Uso por processo
tcpdump -i eth0       # Captura de pacotes
nload                 # Banda por interface

# Estatísticas
vnstat -h             # Histórico de uso
vnstat -l             # Tráfego ao vivo
```

### 🔍 Análise de Conexões
```bash
# Conexões ativas
netstat -nat          # Todas conexões TCP
netstat -nau          # Todas conexões UDP
lsof -i               # Arquivos de rede abertos
ss -s                 # Estatísticas de socket
```

## Configuração de Rede

### ⚙️ Interface de Rede
```bash
# Configuração básica
ip link set eth0 up    # Ativa interface
ip addr add 192.168.1.10/24 dev eth0  # Define IP
ip route add default via 192.168.1.1   # Gateway

# Configuração Wi-Fi
nmcli dev wifi list    # Lista redes
nmcli dev wifi connect SSID password SENHA  # Conecta
```

### 🔒 Firewall Básico
```bash
# UFW (Uncomplicated Firewall)
ufw enable            # Ativa firewall
ufw allow 22         # Libera SSH
ufw status           # Status atual
ufw deny 80          # Bloqueia porta 80
```

## Ferramentas Avançadas

### 🛠️ Troubleshooting
```bash
# Traceroute e MTR
traceroute google.com  # Rota até destino
mtr google.com         # Monitor de rota
pathping google.com    # Alternativa Windows

# Teste de portas
nc -zv host 80        # Teste TCP
nc -zvu host 53       # Teste UDP
```

### 📡 Análise Avançada
```bash
# Wireshark CLI
tshark -i eth0        # Captura básica
tshark -i eth0 -f "port 80"  # Filtro HTTP
tshark -i eth0 -Y "http"     # Display filter
```

## Scripts de Rede

### 🤖 Monitoramento Automático
```bash
#!/bin/bash
# network_monitor.sh

# Monitora conectividade
check_connection() {
    while true; do
        if ! ping -c 1 8.8.8.8 &> /dev/null; then
            echo "$(date): Conexão perdida!"
            notify-send "Alerta" "Conexão de rede perdida"
        fi
        sleep 60
    done
}

# Monitora portas
check_ports() {
    for port in 80 443 22; do
        nc -z localhost $port || \
            echo "Porta $port fechada!"
    done
}
```

### 🔄 Backup de Configuração
```bash
#!/bin/bash
# backup_network.sh

BACKUP_DIR="/backup/network"
DATE=$(date +%Y%m%d)

# Backup de configs
mkdir -p "$BACKUP_DIR/$DATE"
cp /etc/network/interfaces "$BACKUP_DIR/$DATE/"
cp /etc/hosts "$BACKUP_DIR/$DATE/"
cp /etc/resolv.conf "$BACKUP_DIR/$DATE/"
```

## Exercícios Práticos

### 🎯 Missão 1: Scanner de Rede
```bash
#!/bin/bash
# network_scanner.sh

# Scanner básico
for ip in 192.168.1.{1..254}; do
    ping -c 1 -W 1 $ip &> /dev/null && \
        echo "Host ativo: $ip"
done

# Scanner de portas
for port in {20..80}; do
    nc -zv 192.168.1.1 $port 2>&1 | \
        grep "succeeded"
done
```

### 🎯 Missão 2: Monitor de Banda
```bash
#!/bin/bash
# bandwidth_monitor.sh

INTERFACE="eth0"
INTERVAL=5

while true; do
    RX_BYTES=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
    sleep $INTERVAL
    RX_BYTES_NEW=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
    
    SPEED=$(( (RX_BYTES_NEW - RX_BYTES) / INTERVAL ))
    echo "Download: $(( SPEED / 1024 )) KB/s"
done
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Sem conexão**: Verifique `ip link` e `ip addr`
- **DNS lento**: Use `dig +trace`
- **Perda de pacotes**: Analise com `mtr`
- **Portas bloqueadas**: Verifique firewall com `ufw status`

---

> "Uma rede bem configurada é a base de uma infraestrutura sólida."

```ascii
    MONITORAMENTO DE REDE
    [████████████] ATIVO
    CONEXÃO: ESTÁVEL
    LATÊNCIA: OTIMIZADA
```