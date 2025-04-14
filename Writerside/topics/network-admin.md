# Administração de Rede 

## Configuração Básica

### 📡 Interface de Rede
```bash
# Informações
ip addr show               # Lista interfaces
ip link set eth0 up       # Ativa interface
ip link set eth0 down     # Desativa interface

# Configuração
ip addr add 192.168.1.10/24 dev eth0  # Define IP
ip route add default via 192.168.1.1   # Gateway
```

### 🔌 Conectividade
```bash
# Testes básicos
ping -c 4 8.8.8.8        # Teste ICMP
traceroute google.com    # Rota até destino
mtr google.com           # Análise de rota
dig google.com           # Consulta DNS
```

## Monitoramento

### 📊 Análise de Tráfego
```bash
# Ferramentas de monitoramento
tcpdump -i eth0          # Captura pacotes
netstat -tuln            # Portas abertas
ss -tuln                 # Alternativa moderna
iftop                    # Monitor de banda
```

### 🔍 Diagnóstico
```bash
# Ferramentas de diagnóstico
nmap -sP 192.168.1.0/24  # Scan de rede
nc -zv host 80           # Teste de porta
curl -I website.com      # Cabeçalhos HTTP
wget -qO- website.com    # Download teste
```

## Segurança

### 🛡️ Firewall
```bash
# Configuração básica de iptables
iptables -L              # Lista regras
iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # Libera porta
iptables -P INPUT DROP   # Política padrão
iptables-save           # Salva regras
```

### 🔐 SSL/TLS
```bash
# Certificados
openssl req -new -x509 -nodes -out cert.pem -keyout key.pem
openssl x509 -in cert.pem -text  # Verifica certificado
```

## Exercícios Práticos

### 🎯 Missão 1: Monitor de Rede
```bash
#!/bin/bash
# network_monitor.sh

monitor_network() {
    while true; do
        echo "=== $(date) ==="
        
        # Verifica conectividade
        ping -c 1 8.8.8.8 >/dev/null && 
            echo "Internet: OK" ||
            echo "Internet: FALHA"
        
        # Estatísticas de interface
        ip -s link show eth0
        
        # Conexões ativas
        ss -tuln
        
        sleep 300
    done
}
```

### 🎯 Missão 2: Segurança
```bash
#!/bin/bash
# secure_network.sh

secure_ports() {
    # Limpa regras existentes
    iptables -F
    
    # Política padrão
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT
    
    # Permite conexões estabelecidas
    iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    
    # Permite serviços específicos
    iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # HTTP
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT # HTTPS
}
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Sem conexão**: Verifique cabo e interface
- **DNS lento**: Use `dig` e verifique `/etc/resolv.conf`
- **Perda de pacotes**: Analise com `mtr`
- **Portas bloqueadas**: Verifique firewall

---

> "A rede é confiável até provar o contrário."