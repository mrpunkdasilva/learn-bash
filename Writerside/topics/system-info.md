# Informações do Sistema

> Consulte `code/module2/system/system_info.sh` para uma coleção completa de comandos para monitoramento e análise do sistema.
> {style="note"}

```text
    SCANNER DE SISTEMA ATIVADO...
    ===========================
    STATUS: MONITORANDO
    ALCANCE: SISTEMA COMPLETO
    ===========================
```

## Informações Básicas do Sistema

### 🔍 Identificação do Sistema
```bash
# Informações do sistema operacional
uname -a                # Todas as informações do sistema
hostnamectl            # Informações detalhadas do host
lsb_release -a         # Informações da distribuição
cat /etc/os-release    # Detalhes da versão do SO

# Hardware
lscpu                  # Informações da CPU
lsmem                  # Informações da memória
lspci                  # Dispositivos PCI
lsusb                  # Dispositivos USB
```

### 📊 Recursos do Sistema
```bash
# CPU e Memória
top                    # Visão geral interativa
htop                   # Interface melhorada
free -h                # Uso de memória
vmstat 1               # Estatísticas virtuais
uptime                 # Tempo de atividade e carga

# Disco
df -h                  # Uso do sistema de arquivos
du -sh /*              # Uso de disco por diretório
iostat                 # Estatísticas de I/O
lsblk                  # Informações de blocos
```

## Monitoramento de Recursos

### 💻 CPU e Processamento
```bash
# Monitoramento de CPU
mpstat -P ALL 1        # Estatísticas por CPU
sar -u 1 5            # Uso de CPU (5 amostras)
pidstat                # Estatísticas por processo

# Carga do sistema
w                      # Quem está logado e o que está fazendo
ps aux                 # Lista de processos
pstree                # Árvore de processos
```

### 🧠 Memória e Swap
```bash
# Análise de memória
free -h                # Visão geral da memória
vmstat -s              # Estatísticas detalhadas
swapon --show         # Informações de swap
smem                  # Uso de memória por processo
```

## Rede e Conectividade

### 🌐 Informações de Rede
```bash
# Configuração de rede
ip addr                # Endereços IP
ip route              # Tabela de roteamento
netstat -tuln         # Portas abertas
ss -tuln              # Sockets ativos (alternativa moderna)

# Diagnóstico
ping -c 4 8.8.8.8     # Teste de conectividade
traceroute google.com # Rota até o destino
dig google.com        # Consulta DNS
mtr google.com        # Combinação ping + traceroute
```

## Scripts de Análise

### 📈 Monitor de Sistema
```bash
#!/bin/bash
# system_monitor.sh

system_overview() {
    echo "=== Sistema ==="
    uname -a
    
    echo -e "\n=== CPU ==="
    top -bn1 | head -n 3
    
    echo -e "\n=== Memória ==="
    free -h
    
    echo -e "\n=== Disco ==="
    df -h
    
    echo -e "\n=== Rede ==="
    netstat -tuln
}

# Uso: system_overview
```

### 📊 Relatório de Recursos
```bash
#!/bin/bash
# resource_report.sh

generate_report() {
    local output="system_report_$(date +%Y%m%d).txt"
    
    {
        echo "Relatório do Sistema - $(date)"
        echo "=========================="
        
        echo -e "\n1. Informações do Sistema"
        hostnamectl
        
        echo -e "\n2. CPU"
        lscpu | grep -E "^CPU\(s\)|^Model name"
        
        echo -e "\n3. Memória"
        free -h
        
        echo -e "\n4. Disco"
        df -h
        
        echo -e "\n5. Processos Top 5 (CPU)"
        ps aux --sort=-%cpu | head -n 6
        
        echo -e "\n6. Processos Top 5 (Memória)"
        ps aux --sort=-%mem | head -n 6
        
    } > "$output"
    
    echo "Relatório gerado: $output"
}
```

## Ferramentas Avançadas

### 🔧 Diagnóstico Avançado
```bash
# Análise de Performance
perf stat program     # Estatísticas de performance
strace command       # Trace de chamadas do sistema
ltrace program       # Trace de chamadas de biblioteca
```

### 🔍 Análise de Logs
```bash
# Visualização de Logs
journalctl           # Logs do sistema (systemd)
tail -f /var/log/syslog  # Logs em tempo real
grep -r "error" /var/log/* # Busca por erros
```

## Exercícios Práticos

### 🎯 Missão 1: Monitor Completo
```bash
#!/bin/bash
# Objetivos:
# 1. Monitorar CPU, memória e disco
# 2. Gerar alertas para limites
# 3. Manter histórico
# 4. Gerar relatórios

# Implementação básica
monitor_all() {
    while true; do
        check_cpu
        check_memory
        check_disk
        sleep 60
    done
}
```

### 🎯 Missão 2: Análise de Performance
```bash
#!/bin/bash
# Objetivos:
# 1. Coletar métricas de performance
# 2. Identificar gargalos
# 3. Gerar recomendações
# 4. Documentar resultados
```

## Dicas e Boas Práticas

### 💡 Recomendações
1. Monitore regularmente
2. Mantenha histórico
3. Configure alertas
4. Documente mudanças
5. Automatize verificações

### ⚠️ Pontos de Atenção
1. Impacto do monitoramento
2. Segurança dos dados
3. Retenção de logs
4. Uso de recursos
5. Privacidade

## Próximos Passos

1. [Performance Tuning](performance-tuning.md)
2. [System Monitoring](system-monitoring.md)
3. [Troubleshooting](troubleshooting.md)

---

> "Conhecer seu sistema é o primeiro passo para otimizá-lo."

```ascii
    SYSTEM MASTER
    [🖥️🖥️🖥️🖥️🖥️] 100%
    STATUS: SISTEMA DOMINADO
    PRÓXIMO: PERFORMANCE TUNING
```