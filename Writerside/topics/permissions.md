# Permissões no Linux

> Domine o sistema de permissões do Linux para garantir segurança e controle de acesso.
> {style="note"}

```ascii
    CONTROLE DE ACESSO
    =================
    STATUS: ESSENCIAL
    NÍVEL: FUNDAMENTAL → AVANÇADO
    SEGURANÇA: CRÍTICA
```

## Permissões Básicas (rwx)

### Estrutura de Permissões
```bash
# Formato: [tipo][usuário][grupo][outros]
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

### SUID (Set User ID)
```bash
# Permite execução com privilégios do proprietário
chmod u+s programa      # -rwsr-xr-x
chmod 4755 programa     # Modo octal

# Exemplo prático
ls -l /usr/bin/passwd   # -rwsr-xr-x
```

### SGID (Set Group ID)
```bash
# Herda permissões do grupo do diretório
chmod g+s diretorio     # drwxr-sr-x
chmod 2755 diretorio    # Modo octal

# Exemplo prático
mkdir projeto
chmod g+s projeto       # Arquivos herdam grupo
```

### Sticky Bit
```bash
# Protege arquivos de deleção por outros
chmod +t /tmp           # drwxrwxrwt
chmod 1777 /tmp         # Modo octal

# Verificar sticky bit
ls -ld /tmp            # Mostra t no final
```

## ACLs (Access Control Lists)

### Gerenciamento Básico
```bash
# Verificar suporte
getfacl arquivo.txt

# Definir ACLs
setfacl -m u:usuario:rw arquivo.txt    # Usuário específico
setfacl -m g:grupo:rx arquivo.txt      # Grupo específico
```

### ACLs Avançadas
```bash
# ACLs padrão para novos arquivos
setfacl -d -m u:usuario:rx diretorio/

# Backup e restauração
getfacl -R /path > acls.txt
setfacl --restore=acls.txt
```

## Atributos Estendidos

### Atributos Básicos
```bash
# Listar atributos
lsattr arquivo

# Modificar atributos
chattr +i arquivo      # Torna imutável
chattr +a log.txt      # Append-only
```

### Atributos Avançados
```bash
# Combinar atributos
chattr +ia arquivo     # Imutável e append-only

# Remover atributos
chattr -i arquivo      # Remove imutabilidade
```

## Auditoria e Monitoramento

### Monitoramento de Permissões
```bash
# Script de auditoria básico
#!/bin/bash
find /path -type f -perm /4000 -ls     # SUID
find /path -type f -perm /2000 -ls     # SGID
find /path -type f -perm /1000 -ls     # Sticky
```

### Verificação de Segurança
```bash
# Verificar permissões inseguras
find /path -type f -perm -0777 -ls     # Muito permissivo
find /path -type d -perm -0777 -ls     # Diretórios inseguros
```

## Exercícios Práticos

### 🎯 Missão 1: Configuração Básica
```bash
# Configure um ambiente seguro:
mkdir -p ~/projeto/{public,private,shared}
chmod 755 ~/projeto/public
chmod 700 ~/projeto/private
chmod 770 ~/projeto/shared
```

### 🎯 Missão 2: ACLs Avançadas
```bash
# Implemente controle fino de acesso:
setfacl -m u:user1:rx,u:user2:rwx,g:grupo1:r ~/projeto/shared
getfacl ~/projeto/shared
```

## Troubleshooting

### Problemas Comuns
- **Permissão negada**: Verifique com `ls -la` e `getfacl`
- **SUID não funciona**: Verifique sistema de arquivos (noexec)
- **ACLs não aplicam**: Verifique suporte do sistema de arquivos

### Diagnóstico
```bash
# Ferramentas de diagnóstico
namei -l /path/to/file    # Mostra permissões do caminho
strace -e trace=access comando  # Debug de acesso
ausearch -f /path/to/file # Busca em logs de auditoria
```

## Próximos Passos

1. [SELinux e AppArmor](mac-security.md)
2. [Criptografia de Arquivos](file-encryption.md)
3. [Auditoria de Sistema](system-audit.md)

---

> "Permissões são a primeira linha de defesa em segurança. Mantenha-as sempre atualizadas e adequadas."