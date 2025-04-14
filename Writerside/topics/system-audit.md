# Auditoria de Sistema

> Monitore e audite seu sistema Linux
> {style="note"}

## Auditd

### Configuração Básica
```bash
# Instalar auditd
apt install auditd audispd-plugins

# Iniciar serviço
systemctl enable auditd
systemctl start auditd
```

### Regras de Auditoria
```bash
# Adicionar regras
auditctl -w /etc/passwd -p wa -k user-modify
auditctl -w /etc/sudoers -p wa -k sudo-modify
auditctl -a exit,always -F arch=b64 -S execve -k cmd-exec
```

## Logs e Monitoramento

### Análise de Logs
```bash
# Buscar eventos
ausearch -k user-modify
ausearch -ts today
aureport --summary
```

### Monitoramento em Tempo Real
```bash
# Monitor contínuo
auditctl -w /path/to/watch -p warx -k label
tail -f /var/log/audit/audit.log
```

## Relatórios

### Geração de Relatórios
```bash
# Relatório completo
aureport --start today --end now --summary

# Relatório específico
aureport --login --summary
aureport --file --summary
```

## Scripts de Auditoria

### Monitor de Segurança
```bash
#!/bin/bash
# security_audit.sh

check_system() {
    # Verificar alterações críticas
    ausearch -k user-modify --start today
    ausearch -k sudo-modify --start today
    
    # Gerar relatório
    aureport --summary
}
```

## Exercícios Práticos

### 🎯 Missão: Sistema de Auditoria
1. Configure regras personalizadas
2. Implemente monitoramento
3. Crie relatórios automáticos
4. Estabeleça alertas