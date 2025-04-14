#!/bin/bash
# Demonstração de comandos de informação do sistema

# Informações do sistema
uname -a                    # Info do sistema
lscpu                      # Info da CPU
free -h                    # Uso de memória
df -h                      # Uso de disco
top -b -n 1               # Processos (snapshot)

# Monitoramento de rede
netstat -tuln              # Portas abertas
ss -s                     # Estatísticas de socket
iftop                     # Monitoramento de rede
tcpdump -i any            # Captura de pacotes

# Processos
ps aux                     # Lista processos
pgrep -l bash             # Encontra processos
kill -9 PID               # Mata processo
pkill -f nome_processo    # Mata por nome

# Logs do sistema
tail -f /var/log/syslog   # Monitora log
journalctl -f            # Logs do systemd
dmesg                    # Mensagens do kernel