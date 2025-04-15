#!/bin/bash
# Automação de performance

# Monitoramento de performance
monitor_performance() {
    local pid="$1"
    local duration="$2"
    
    top -p "$pid" -b -n "$duration" | \
    awk '/'"$pid"'/ {
        cpu[$1]+=$9
        mem[$1]+=$10
        count++
    }
    END {
        print "Média CPU:", cpu['"$pid"']/count
        print "Média Memory:", mem['"$pid"']/count
    }'
}

# Otimização automática
optimize_system() {
    # Limpa cache
    sync && echo 3 > /proc/sys/vm/drop_caches
    
    # Ajusta swappiness
    sysctl vm.swappiness=10
    
    # Otimiza I/O
    echo deadline > /sys/block/sda/queue/scheduler
}