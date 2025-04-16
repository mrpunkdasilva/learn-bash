# Herança de ACLs

> Aprenda a configurar e gerenciar herança de permissões usando ACLs no Linux.
> {style="note"}

## Conceitos Básicos de Herança

### O que é Herança de ACLs?
A herança de ACLs permite que novos arquivos e subdiretórios herdem automaticamente as permissões do diretório pai.

### Tipos de Herança
- **ACLs Padrão**: Aplicadas apenas a diretórios
- **ACLs Herdadas**: Permissões efetivamente aplicadas aos novos itens
- **ACLs Calculadas**: Combinação de permissões herdadas e explícitas

## Configuração de Herança

### ACLs Padrão Básicas
```bash
# Configurar ACL padrão para usuário
setfacl -d -m u:usuario:rx diretorio/

# Configurar ACL padrão para grupo
setfacl -d -m g:grupo:rwx diretorio/

# Verificar ACLs padrão
getfacl diretorio/
```

### ACLs Padrão Múltiplas
```bash
# Configurar múltiplas ACLs padrão
setfacl -d -m u:user1:rx,u:user2:rwx,g:grupo1:rx diretorio/

# Aplicar recursivamente em subdiretórios
setfacl -R -d -m u:user1:rx,g:grupo1:rx diretorio/
```

## Cenários de Uso

### Ambiente de Desenvolvimento
```bash
# Setup para projeto de desenvolvimento
setfacl -d -m g:developers:rwx projeto/
setfacl -d -m g:testers:rx projeto/
setfacl -R -m g:developers:rwx,g:testers:rx projeto/
```

### Compartilhamento de Arquivos
```bash
# Configuração para pasta compartilhada
setfacl -d -m g:shared:rwx /shared/
setfacl -d -m o::- /shared/
setfacl -R -m g:shared:rwx /shared/
```

## Gerenciamento de Herança

### Modificação de Herança
```bash
# Remover ACLs padrão específicas
setfacl -d -x u:usuario diretorio/

# Remover todas as ACLs padrão
setfacl -k diretorio/

# Atualizar ACLs padrão existentes
setfacl -d -m u:usuario:rwx diretorio/
```

### Propagação de Mudanças
```bash
# Propagar novas ACLs para conteúdo existente
setfacl -R -m u:usuario:rx diretorio/

# Atualizar ACLs padrão e propagar
setfacl -R -d -m g:grupo:rx diretorio/
```

## Troubleshooting de Herança

### Problemas Comuns
1. **ACLs não são herdadas**
   - Verificar suporte do sistema de arquivos
   - Confirmar ACLs padrão
   - Checar permissões do diretório pai

2. **Conflitos de Herança**
   - Verificar máscara efetiva
   - Analisar precedência de permissões
   - Revisar ACLs explícitas vs herdadas

### Diagnóstico
```bash
# Verificar herança efetiva
getfacl -R diretorio/

# Analisar máscara de permissões
getfacl -e arquivo

# Debug de permissões
namei -l /caminho/completo/arquivo
```

## Exercícios Práticos

### 🎯 Missão 1: Estrutura de Projeto
1. Crie uma estrutura de diretórios para um projeto
2. Configure herança para diferentes equipes
3. Teste a criação de novos arquivos
4. Verifique as permissões herdadas

### 🎯 Missão 2: Migração de Permissões
1. Exporte ACLs existentes
2. Modifique a estrutura de herança
3. Aplique as novas ACLs
4. Valide as mudanças

## Boas Práticas

1. **Planejamento**
   - Documente a estrutura de permissões
   - Defina hierarquia clara de acesso
   - Considere futuras expansões

2. **Implementação**
   - Use grupos em vez de usuários individuais
   - Mantenha ACLs simples e organizadas
   - Implemente backup das configurações

3. **Manutenção**
   - Monitore mudanças nas ACLs
   - Realize auditorias periódicas
   - Mantenha documentação atualizada

## Próximos Passos

- [ACLs Avançadas](acl-advanced.md)
- [Troubleshooting de ACLs](acl-troubleshooting.md)