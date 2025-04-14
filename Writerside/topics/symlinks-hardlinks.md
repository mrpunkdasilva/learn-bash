# Links Simbólicos e Hardlinks: Conectando os Pontos 🔗

## Conceitos Básicos

### Links Simbólicos (Soft Links)
```bash
# Criação básica
ln -s arquivo.txt link_simbolico    # Cria link simbólico
ln -s /caminho/completo/arquivo link # Com caminho absoluto
ln -s ../arquivo link              # Com caminho relativo

# Opções úteis
ln -sf arquivo link               # Força criação
ln -snf arquivo link             # Força, não segue links
```

### Hardlinks
```bash
# Criação básica
ln arquivo.txt hardlink           # Cria hardlink
ln arquivo1 arquivo2 dir/        # Múltiplos hardlinks
ln -f origem destino            # Força criação
```

## Gerenciamento de Links

### 🔍 Identificação
```bash
# Verificação de links
ls -l                    # Lista com detalhes
ls -la                   # Inclui ocultos
readlink link           # Mostra destino do symlink
stat arquivo           # Informações detalhadas

# Contagem de hardlinks
ls -l arquivo           # Mostra número de links
find . -samefile arquivo # Encontra hardlinks
```

### 🔧 Manutenção
```bash
# Atualização de links
ln -sf novo_destino link    # Atualiza symlink
mv link novo_nome          # Renomeia link
rm link                   # Remove link

# Verificação de integridade
find . -type l -! -exec test -e {} \; -print  # Links quebrados
find . -xtype l           # Alternativa para links quebrados
```

## Boas Práticas

### ✅ Recomendações
```bash
# Links simbólicos
ln -s "$(readlink -f arquivo)" link  # Usa caminho absoluto
ln -s "$(pwd)/arquivo" link         # Alternativa explícita

# Hardlinks
ln arquivo link && chmod --reference=arquivo link  # Preserva permissões
```

### ⚠️ Cuidados
```bash
# Evite loops
ln -s link1 link2    # Pode criar loop
ln -s . loop        # Loop direto

# Backup antes de modificar
cp -P link link.bak  # Preserva links
```

## Scripts Úteis

### 🤖 Gerenciador de Links
```bash
#!/bin/bash
# link_manager.sh

check_links() {
    local dir="${1:-.}"
    echo "Verificando links em $dir..."
    
    # Links quebrados
    find "$dir" -type l -! -exec test -e {} \; -print
    
    # Hardlinks múltiplos
    find "$dir" -type f -links +1 -print
}

update_links() {
    local old_path="$1"
    local new_path="$2"
    
    find . -lname "*${old_path}*" -exec ln -sf \
        "$(readlink {} | sed "s|${old_path}|${new_path}|")" {} \;
}
```

### 🔄 Sincronização de Links
```bash
#!/bin/bash
# sync_links.sh

sync_directory() {
    local src="$1"
    local dst="$2"
    
    # Copia preservando links
    cp -a "$src/" "$dst/"
    
    # Atualiza links relativos
    cd "$dst"
    find . -type l -exec bash -c '
        link=$(readlink "$1")
        if [[ $link != /* ]]; then
            ln -sf "$link" "$1"
        fi
    ' _ {} \;
}
```

## Exercícios Práticos

### 🎯 Missão 1: Sistema de Links
```bash
# Crie uma estrutura de links
mkdir -p projeto/{bin,lib,config}
touch projeto/lib/biblioteca.so.1
ln -s biblioteca.so.1 projeto/lib/biblioteca.so
ln projeto/lib/biblioteca.so.1 projeto/bin/
```

### 🎯 Missão 2: Migração de Links
```bash
# Migre links entre diretórios
old_dir="/antigo/caminho"
new_dir="/novo/caminho"
find . -type l -lname "$old_dir/*" -exec \
    ln -sf "$(readlink {} | sed "s|$old_dir|$new_dir|")" {} \;
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Link quebrado**: Use `readlink` para verificar destino
- **Permissão negada**: Verifique com `ls -la`
- **Loop de links**: Use `readlink -f` para resolver
- **Links não seguidos**: Adicione `-L` aos comandos

### 📊 Diagnóstico
```bash
# Verificação completa
namei -l /caminho/do/link    # Mostra cadeia completa
stat -L link                # Info do arquivo linkado
file -L link               # Tipo do arquivo linkado
```

## Próximos Passos

1. [Monitoramento de Arquivos](file-monitoring.md)
2. [Operações em Lote](batch-operations.md)
3. [Troubleshooting](file-ops-troubleshooting.md)

---

> "Links são como portais no sistema de arquivos - use-os com sabedoria."

```ascii
    LINKS VERIFICADOS
    [████████████] 100%
    SISTEMA: CONECTADO
    INTEGRIDADE: OK
```