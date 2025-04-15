#!/bin/bash
# Integração com sistema

# Monitoramento de recursos
check_resources() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    local mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}')
    
    echo "CPU: $cpu_usage%"
    echo "Memory: $mem_usage%"
    echo "Disk: $disk_usage"
}

# Integração com systemd
create_service() {
    cat > /etc/systemd/system/myapp.service << EOF
[Unit]
Description=My Application Service
After=network.target

[Service]
ExecStart=/usr/local/bin/myapp
Restart=always

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable myapp
}