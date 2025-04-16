# ACLs Básicas

## Comandos Essenciais

### Visualização de ACLs
```bash
# Listar ACLs de um arquivo
getfacl arquivo.txt

# Listar ACLs de um diretório recursivamente
getfacl -R diretorio/
```

### Configuração de ACLs
```bash
# Permissão de leitura para usuário
setfacl -m u:joao:r arquivo.txt

# Permissão de escrita para grupo
setfacl -m g:devs:w arquivo.txt

# Múltiplas permissões
setfacl -m u:maria:rw,g:admins:rx arquivo.txt
```

## Exercícios Práticos

### 🎯 Missão 1: Configuração Básica
1. Crie um arquivo de teste
2. Adicione permissão de leitura para um usuário
3. Adicione permissão de escrita para um grupo
4. Verifique as ACLs configuradas

### 🎯 Missão 2: Manipulação de ACLs
1. Remova uma ACL específica
2. Adicione múltiplas ACLs
3. Faça backup das ACLs
4. Restaure as ACLs

## Troubleshooting Comum

- **Permissão negada**: Verifique as ACLs com `getfacl`
- **ACLs não aplicam**: Confirme suporte do sistema de arquivos
- **Conflito de permissões**: Entenda a precedência de ACLs

## Próximos Passos

- [ACLs Avançadas](acl-advanced.md)
- [Herança de ACLs](acl-inheritance.md)