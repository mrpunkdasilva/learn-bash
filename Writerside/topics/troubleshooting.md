# Troubleshooting

> Este módulo apresenta soluções para problemas comuns e técnicas de diagnóstico.
> {style="note"}

## Problemas Comuns

### Permissões

#### Problema: "Permission denied"
```bash
# Solução 1: Verificar permissões
ls -l arquivo
chmod u+x arquivo

# Solução 2: Executar como sudo
sudo ./script.sh
```

### Variáveis de Ambiente

#### Problema: "Command not found"
```bash
# Verificar PATH
echo $PATH

# Adicionar ao PATH
export PATH="$HOME/bin:$PATH"
```

### Scripts

#### Problema: "Bad interpreter"
```bash
# Verificar shebang
head -n 1 script.sh

# Corrigir formato de linha
dos2unix script.sh
```

## Ferramentas de Diagnóstico

### Logs
```bash
# Visualizar logs do sistema
tail -f /var/log/syslog

# Logs do Bash
history
```

### Debug
```bash
# Modo verbose
bash -v script.sh

# Modo debug
bash -x script.sh

# Debug em seção específica
set -x  # inicia debug
comandos
set +x  # termina debug
```

## Checklist de Verificação

1. Permissões corretas?
2. Variáveis de ambiente configuradas?
3. Dependências instaladas?
4. Formato de arquivo correto?
5. Logs de erro verificados?