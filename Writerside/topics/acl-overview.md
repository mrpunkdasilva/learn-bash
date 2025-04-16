# Access Control Lists (ACLs)

> Aprenda a utilizar ACLs para controle de acesso avançado no Linux.
> {style="note"}

## O que são ACLs?

ACLs (Access Control Lists) são um mecanismo de controle de acesso mais flexível que as permissões tradicionais do Unix. Elas permitem definir permissões específicas para múltiplos usuários e grupos em um mesmo arquivo ou diretório.

## Vantagens das ACLs

- Controle de acesso mais granular
- Suporte a múltiplos usuários e grupos
- Compatibilidade com permissões tradicionais
- Herança de permissões em diretórios

## Comandos Básicos

### Verificando Suporte a ACLs
```bash
# Verificar se o sistema de arquivos suporta ACLs
tune2fs -l /dev/sdXY | grep "Default mount options"
mount | grep acl

# Verificar se um arquivo tem ACLs
getfacl arquivo.txt
```

### Gerenciamento Básico de ACLs
```bash
# Definir ACL para usuário
setfacl -m u:usuario:rw arquivo.txt

# Definir ACL para grupo
setfacl -m g:grupo:rx arquivo.txt

# Remover ACL específica
setfacl -x u:usuario arquivo.txt

# Remover todas as ACLs
setfacl -b arquivo.txt
```

## Próximos Passos

- [ACLs Básicas](acl-basics.md)
- [ACLs Avançadas](acl-advanced.md)
- [Herança de ACLs](acl-inheritance.md)
- [Troubleshooting de ACLs](acl-troubleshooting.md)