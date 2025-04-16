# Troubleshooting de ACLs

> Guia completo para identificação e resolução de problemas com ACLs no Linux.
> {style="note"}

## Problemas Comuns

### 1. Permissão Negada
```bash
# Diagnóstico
getfacl arquivo                    # Verificar ACLs atuais
ls -la arquivo                     # Verificar permissões básicas
namei -l /caminho/completo/arquivo # Verificar caminho completo

# Soluções
setfacl -m u:usuario:rw arquivo    # Adicionar permissões específicas
chmod +r arquivo                   # Ajustar permissões básicas
chown usuario:grupo arquivo        # Alterar proprietário
```

### 2. ACLs Não Aplicadas
```bash
# Verificar suporte do sistema de arquivos
tune2fs -l /dev/sdXY | grep "Default mount options"
mount | grep acl

# Verificar montagem
mount -o remount,acl /particao
```

### 3. Problemas de Herança
```bash
# Verificar ACLs padrão
getfacl -d diretorio/

# Corrigir herança
setfacl -d -m u:usuario:rx diretorio/   # Definir ACL padrão
setfacl -R -m u:usuario:rx diretorio/   # Aplicar recursivamente
```

## Ferramentas de Diagnóstico

### Análise de ACLs
```bash
# Visualização detalhada
getfacl -e arquivo    # Mostra entradas efetivas
getfacl -R diretorio/ # Análise recursiva
getfacl -c arquivo    # Omite comentários

# Backup e comparação
getfacl -R /dir1 > acls1.txt
getfacl -R /dir2 > acls2.txt
diff acls1.txt acls2.txt
```

### Monitoramento
```bash
# Auditoria de acesso
auditctl -w /path/to/file -p rwxa
ausearch -f /path/to/file

# Monitoramento em tempo real
inotifywait -m -r /diretorio
```

## Cenários de Troubleshooting

### Cenário 1: Conflito de Permissões
```bash
# Problema: ACLs x Permissões Unix
getfacl -e arquivo     # Verificar máscara efetiva
setfacl -m m::rwx arquivo  # Ajustar máscara
chmod 755 arquivo      # Ajustar permissões base
```

### Cenário 2: Migração de ACLs
```bash
# Backup antes da migração
getfacl -R /origem > acls_backup.txt

# Restauração em caso de problemas
setfacl --restore=acls_backup.txt
```

## Checklist de Verificação

1. **Verificação Básica**
   - Sistema de arquivos suporta ACLs?
   - Partição montada com suporte a ACLs?
   - Permissões Unix básicas corretas?

2. **Análise de ACLs**
   - ACLs configuradas corretamente?
   - Máscara efetiva adequada?
   - Herança funcionando?

3. **Auditoria**
   - Logs de acesso verificados?
   - Histórico de modificações?
   - Backup das ACLs existe?

## Scripts de Diagnóstico

### Script de Verificação de ACLs
```bash
#!/bin/bash
echo "Verificando ACLs em $1"
getfacl -R "$1" > /tmp/acls_atual.txt
if [ -f /tmp/acls_backup.txt ]; then
    diff /tmp/acls_backup.txt /tmp/acls_atual.txt
fi
```

### Script de Correção Automática
```bash
#!/bin/bash
# Corrige permissões comuns
setfacl -R -m u:www-data:rx,g:developers:rwx "$1"
setfacl -R -d -m u:www-data:rx,g:developers:rwx "$1"
```

## Boas Práticas

1. **Prevenção**
   - Mantenha backup das ACLs
   - Documente alterações
   - Use grupos em vez de usuários individuais

2. **Diagnóstico**
   - Comece pelo mais simples
   - Verifique logs do sistema
   - Use ferramentas apropriadas

3. **Correção**
   - Faça backup antes de alterações
   - Teste em ambiente seguro
   - Valide após mudanças

## Próximos Passos

- [ACLs Avançadas](acl-advanced.md)
- [Herança de ACLs](acl-inheritance.md)
- [Boas Práticas de Segurança](security-best-practices.md)