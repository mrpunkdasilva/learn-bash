# Permissões de Arquivos 

> Gerenciamento avançado de permissões e controle de acesso.
> {style="warning"}

```ascii
    CONTROLE DE ACESSO
    =================
    STATUS: CRÍTICO
    NÍVEL: AVANÇADO
    SEGURANÇA: MÁXIMA
```

## Permissões Básicas

### Estrutura de Permissões
```bash
# Formato: [tipo][user][group][others]
ls -l arquivo.txt
# -rw-r--r-- 1 user group 0 Jan 1 12:00 arquivo.txt
#  ^ ^^^ ^^^ ^^^
#  | |   |   |
#  | |   |   +-> outros (r--)
#  | |   +-> grupo (r--)
#  | +-> usuário (rw-)
#  +-> tipo (-)
```

### Modificando Permissões
```bash
# Modo Octal
chmod 644 arquivo.txt    # rw-r--r--
chmod 755 script.sh      # rwxr-xr-x
chmod 600 id_rsa        # rw-------

# Modo Simbólico
chmod u+x script.sh      # Adiciona execução para usuário
chmod g-w arquivo.txt    # Remove escrita do grupo
chmod o= arquivo.txt     # Remove todas permissões de outros
```

## Permissões Especiais

### SUID, SGID e Sticky Bit
```bash
# SUID - Executa como proprietário
chmod 4755 programa     # -rwsr-xr-x
chmod u+s programa      # Modo simbólico

# SGID - Executa como grupo
chmod 2755 diretorio    # -rwxr-sr-x
chmod g+s diretorio     # Modo simbólico

# Sticky Bit - Proteção de deleção
chmod 1777 /tmp         # -rwxrwxrwt
chmod +t diretorio      # Modo simbólico
```

## ACLs Avançadas

### Gerenciamento de ACLs
```bash
# Listando ACLs
getfacl arquivo.txt

# Configurando ACLs
setfacl -m u:usuario:rw arquivo.txt    # Permissão para usuário
setfacl -m g:grupo:rx arquivo.txt      # Permissão para grupo
setfacl -x u:usuario arquivo.txt       # Remove ACL específica
setfacl -b arquivo.txt                 # Remove todas ACLs
```

### ACLs Padrão
```bash
# ACLs para novos arquivos
setfacl -d -m u:usuario:rx diretorio/
setfacl -d -m g:grupo:rwx diretorio/
```

## Atributos Estendidos

### Gerenciamento de Atributos
```bash
# Listando atributos
lsattr arquivo.txt

# Configurando atributos
chattr +i arquivo.txt    # Imutável
chattr +a log.txt       # Append-only
chattr +s arquivo.txt   # Deleção segura
```

## Propriedade e Grupos

### Mudança de Proprietário
```bash
# Mudando proprietário
chown usuario:grupo arquivo.txt
chown -R usuario:grupo diretorio/

# Mudando apenas grupo
chgrp grupo arquivo.txt
chgrp -R grupo diretorio/
```

## Scripts de Segurança

### Auditoria de Permissões
```bash
#!/bin/bash
# audit_permissions.sh

check_permissions() {
    find "$1" -type f -perm /4000 -print | while read file; do
        echo "SUID encontrado: $file"
        ls -l "$file"
    done
}

check_world_writable() {
    find "$1" -type f -perm -002 -print | while read file; do
        echo "Arquivo gravável globalmente: $file"
        ls -l "$file"
    done
}

# Uso
check_permissions /usr/bin
check_world_writable /home
```

### Correção Automática
```bash
#!/bin/bash
# fix_permissions.sh

fix_permissions() {
    # Arquivos sensíveis
    chmod 600 ~/.ssh/id_rsa
    chmod 644 ~/.ssh/id_rsa.pub
    
    # Diretórios de configuração
    chmod 700 ~/.ssh
    chmod 750 ~/scripts
    
    # Scripts executáveis
    find ~/scripts -type f -name "*.sh" -exec chmod u+x {} \;
}
```

## Exercícios Avançados

### 🎯 Missão 1: Hardening de Permissões
```bash
# Implemente um sistema que:
# 1. Identifique permissões inseguras
# 2. Corrija automaticamente
# 3. Gere relatório de mudanças
# 4. Mantenha log de auditoria
```

### 🎯 Missão 2: ACLs Complexas
```bash
# Crie uma estrutura que:
# 1. Use ACLs para controle fino
# 2. Implemente herança de permissões
# 3. Gerencie múltiplos grupos
# 4. Mantenha backup das ACLs
```

## Troubleshooting

### Problemas Comuns
- **Permissão negada**: Verifique com `ls -la` e `getfacl`
- **SUID não funciona**: Verifique sistema de arquivos (noexec)
- **ACLs não aplicam**: Verifique suporte do sistema de arquivos

### Diagnóstico
```bash
# Verificação de problemas
namei -l /path/to/file    # Mostra permissões do caminho
strace -e trace=access comando  # Debug de acesso
ausearch -f /path/to/file # Busca em logs de auditoria
```

## Próximos Passos

1. [SELinux e AppArmor](mac-security.md)
2. [Criptografia de Arquivos](file-encryption.md)
3. [Auditoria de Sistema](system-audit.md)

---

> "Segurança não é um produto, é um processo. Mantenha suas permissões sempre atualizadas."