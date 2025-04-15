#!/bin/bash
# Performance Tuning Avançado

# Configurações
readonly PERF_LOG="/var/log/performance.log"
readonly SYSCTL_BACKUP="/etc/sysctl.backup"
readonly LIMITS_CONF="/etc/security/limits.conf"

# Logging
log_perf() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$PERF_LOG"
}

# Otimização do kernel
optimize_kernel() {
    # Backup das configurações atuais
    sysctl -a > "$SYSCTL_BACKUP"
    
    # Otimizações de rede
    sysctl -w net.core.somaxconn=65535
    sysctl -w net.ipv4.tcp_max_syn_backlog=65535
    sysctl -w net.core.netdev_max_backlog=65535
    sysctl -w net.ipv4.tcp_fastopen=3
    
    # Otimizações de memória
    sysctl -w vm.swappiness=10
    sysctl -w vm.dirty_ratio=60
    sysctl -w vm.dirty_background_ratio=2
    
    # Otimizações de filesystem
    sysctl -w fs.file-max=2097152
    sysctl -w fs.inotify.max_user_watches=524288
    
    # Aplicar mudanças
    sysctl -p
    
    log_perf "Otimizações do kernel aplicadas"
}

# Otimização de limites do sistema
optimize_limits() {
    cat >> "$LIMITS_CONF" << EOF
* soft nofile 65535
* hard nofile 65535
* soft nproc 65535
* hard nproc 65535
* soft memlock unlimited
* hard memlock unlimited
EOF
    
    log_perf "Limites do sistema otimizados"
}

# Análise de performance do disco
analyze_disk_performance() {
    local device=$1
    
    echo "=== Análise de Performance do Disco: $device ==="
    
    # Teste de leitura sequencial
    dd if="$device" of=/dev/null bs=1M count=1000 2>&1
    
    # Teste de escrita sequencial
    dd if=/dev/zero of="$device" bs=1M count=1000 2>&1
    
    # IOPs com fio
    if command -v fio >/dev/null; then
        fio --name=randread --rw=randread --bs=4k --size=1G --runtime=60 \
            --filename="$device" --direct=1 --ioengine=libaio --iodepth=32
    fi
}

# Otimização de serviços
tune_services() {
    # Nginx
    if systemctl is-active nginx >/dev/null 2>&1; then
        sed -i 's/worker_processes.*/worker_processes auto;/' /etc/nginx/nginx.conf
        sed -i 's/worker_connections.*/worker_connections 2048;/' /etc/nginx/nginx.conf
        systemctl restart nginx
    fi
    
    # MySQL/MariaDB
    if systemctl is-active mysql >/dev/null 2>&1; then
        cat >> /etc/mysql/conf.d/performance.cnf << EOF
[mysqld]
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
innodb_flush_log_at_trx_commit = 2
innodb_flush_method = O_DIRECT
EOF
        systemctl restart mysql
    fi
    
    log_perf "Serviços otimizados"
}

# Monitoramento de performance
monitor_performance() {
    echo "=== Monitoramento de Performance ==="
    
    # CPU
    echo "Top 5 processos por CPU:"
    ps aux --sort=-%cpu | head -6
    
    # Memória
    echo -e "\nTop 5 processos por memória:"
    ps aux --sort=-%mem | head -6
    
    # I/O
    echo -e "\nAtividade de I/O:"
    iostat -x 1 5
    
    # Rede
    echo -e "\nConexões de rede:"
    netstat -ant | awk '{print $6}' | sort | uniq -c | sort -n
}

# Benchmark do sistema
run_benchmark() {
    echo "=== Benchmark do Sistema ==="
    
    # CPU
    if command -v sysbench >/dev/null; then
        echo "Benchmark CPU:"
        sysbench cpu --cpu-max-prime=20000 run
        
        echo -e "\nBenchmark Memória:"
        sysbench memory --memory-block-size=1K --memory-total-size=10G run
        
        echo -e "\nBenchmark I/O:"
        sysbench fileio --file-test-mode=rndrw prepare
        sysbench fileio --file-test-mode=rndrw run
        sysbench fileio --file-test-mode=rndrw cleanup
    else
        echo "sysbench não encontrado. Por favor, instale para executar benchmarks."
    fi
}

# Menu principal
main_menu() {
    while true; do
        echo -e "\n=== Performance Tuning ==="
        echo "1. Otimizar kernel"
        echo "2. Otimizar limites do sistema"
        echo "3. Analisar performance do disco"
        echo "4. Otimizar serviços"
        echo "5. Monitorar performance"
        echo "6. Executar benchmark"
        echo "7. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                optimize_kernel
                ;;
            2)
                optimize_limits
                ;;
            3)
                read -p "Device (ex: /dev/sda): " device
                analyze_disk_performance "$device"
                ;;
            4)
                tune_services
                ;;
            5)
                monitor_performance
                ;;
            6)
                run_benchmark
                ;;
            7)
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