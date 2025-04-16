# ACLs Avançadas

> Técnicas avançadas para gerenciamento de Access Control Lists no Linux.
> {style="note"}

## ACLs Padrão (Default)

### Configuração de ACLs Padrão
```bash
# Definir ACL padrão para diretório
setfacl -d -m u:usuario:rx diretorio/

# Definir múltiplas ACLs padrão
setfacl -d -m u:user1:rwx,g:grupo1:rx diretorio/

# Verificar ACLs padrão
getfacl diretorio/
```

## ACLs Recursivas

### Aplicação em Árvore de Diretórios
```bash
# Aplicar ACLs recursivamente
setfacl -R -m u:usuario:rx diretorio/

# Aplicar ACLs padrão recursivamente
setfacl -R -d -m g:grupo:rwx diretorio/
```

## Backup e Restauração

### Gerenciamento de ACLs
```bash
# Backup de ACLs
getfacl -R /path/to/dir > acls.backup

# Restaurar ACLs
setfacl --restore=acls.backup
```

## Casos de Uso Avançados

### Cenário 1: Ambiente de Desenvolvimento
```bash
# Setup para time de desenvolvimento
setfacl -R -m g:devs:rwx projeto/
setfacl -R -m g:qa:rx projeto/
setfacl -R -d -m g:devs:rwx,g:qa:rx projeto/
```

### Cenário 2: Servidor Web
```bash
# Configuração para web server
setfacl -m u:www-data:rx,g:webadmin:rwx /var/www/
setfacl -d -m u:www-data:rx,g:webadmin:rwx /var/www/
```

## Mascaramento e Permissões Efetivas

### Entendendo Máscaras
```bash
# Verificar máscara efetiva
getfacl -e arquivo

# Modificar máscara
setfacl -m m::rx arquivo
```

## Troubleshooting Avançado

### Diagnóstico de Problemas
```bash
# Verificar suporte do sistema de arquivos
tune2fs -l /dev/sdXY | grep "Default mount options"

# Debug de permissões
namei -l /path/to/file

# Auditoria de acesso
auditctl -w /path/to/file -p rwxa
```

## Exercícios Avançados

### 🎯 Missão 1: Ambiente Multi-equipe
1. Configure ACLs para diferentes níveis de acesso
2. Implemente herança automática
3. Configure backup automático de ACLs
4. Implemente rotação de logs de acesso

### 🎯 Missão 2: Segurança Avançada
1. Implemente ACLs com máscaras restritivas
2. Configure auditoria de acessos
3. Crie script de monitoramento
4. Desenvolva sistema de alertas

## Boas Práticas

1. Mantenha documentação atualizada
2. Use grupos em vez de usuários individuais
3. Implemente backup regular de ACLs
4. Monitore mudanças nas ACLs
5. Realize auditorias periódicas

## Próximos Passos

- [Herança de ACLs](acl-inheritance.md)
- [Troubleshooting de ACLs](acl-troubleshooting.md)