# SELinux e AppArmor

> Controle de Acesso Mandatório (MAC) para Linux
> {style="note"}

## SELinux

### Conceitos Básicos
```bash
# Verificar status
getenforce
sestatus

# Modos de operação
setenforce 0  # Permissivo
setenforce 1  # Forçado
```

### Contextos de Segurança
```bash
# Listar contextos
ls -Z
ps -Z

# Modificar contextos
chcon -t httpd_sys_content_t /var/www/html/
restorecon -R /var/www/html/
```

### Políticas
```bash
# Gerenciar políticas
semodule -l          # Listar módulos
semodule -i policy.pp # Instalar política
audit2allow -a -M mypolicy # Criar política
```

## AppArmor

### Operações Básicas
```bash
# Status
aa-status
apparmor_status

# Perfis
aa-enforce /etc/apparmor.d/usr.sbin.nginx
aa-complain /etc/apparmor.d/usr.bin.firefox
```

### Gerenciamento de Perfis
```bash
# Criar/Editar perfis
aa-genprof programa
aa-logprof

# Recarregar perfis
systemctl reload apparmor
```

## Troubleshooting

### SELinux
```bash
# Diagnóstico
ausearch -m AVC
sealert -a /var/log/audit/audit.log

# Resolução comum
setsebool -P httpd_can_network_connect on
```

### AppArmor
```bash
# Logs
tail -f /var/log/audit/audit.log
dmesg | grep -i apparmor
```

## Exercícios Práticos

### 🎯 Missão: Hardening com MAC
1. Configure SELinux/AppArmor
2. Crie políticas personalizadas
3. Teste e valide as restrições
4. Monitore violações