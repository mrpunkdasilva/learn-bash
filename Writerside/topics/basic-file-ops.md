# Operações Básicas com Arquivos 

> Experimente o script interativo em `code/module2/file-ops/basic_ops.sh` para praticar estas operações.
> {style="note"}

```ascii
    INICIANDO OPERAÇÕES BÁSICAS...
    =============================
    STATUS: PRONTO
    NÍVEL: FUNDAMENTAL
    OPERAÇÕES: CRIAR, COPIAR, MOVER, REMOVER
```

## Criação de Arquivos

### Touch - Criando Arquivos Vazios
```bash
touch arquivo.txt           # Cria arquivo vazio
touch -t 202312251200 arq  # Define data/hora específica
touch {1..5}.txt          # Cria múltiplos arquivos
```

### Redirecionamento - Criando com Conteúdo
```bash
echo "conteúdo" > arquivo.txt    # Cria/sobrescreve
echo "mais texto" >> arquivo.txt # Adiciona ao final
cat > arquivo.txt << EOF         # Múltiplas linhas
linha 1
linha 2
EOF
```

## Cópia de Arquivos

### CP - Comando de Cópia
```bash
cp origem.txt destino.txt        # Cópia básica
cp -i arquivo.txt backup/        # Modo interativo
cp -r diretorio/ backup/        # Cópia recursiva
cp -p arquivo.txt destino.txt   # Preserva atributos
```

### Opções Úteis do CP
- `-v`: Modo verboso
- `-u`: Atualiza apenas se origem for mais nova
- `-l`: Cria hard links em vez de copiar
- `-s`: Cria symbolic links em vez de copiar

## Movimentação de Arquivos

### MV - Movendo e Renomeando
```bash
mv arquivo.txt novo.txt          # Renomeia
mv arquivo.txt /tmp/            # Move
mv -i *.txt destino/           # Move múltiplos
mv -n origem destino           # Não sobrescreve
```

### Boas Práticas
```bash
mv -b arquivo.txt destino/     # Cria backup
mv -- -arquivo.txt destino/    # Move arquivo com '-'
```

## Remoção de Arquivos

### RM - Removendo Arquivos
```bash
rm arquivo.txt                  # Remove arquivo
rm -i arquivo.txt              # Modo interativo
rm -r diretorio/              # Remove recursivamente
rm -f arquivo.txt             # Força remoção
```

### Dicas de Segurança
```bash
# Alias seguro para rm
alias rm='rm -i'

# Função de lixeira
trash() {
    local dest="$HOME/.trash"
    mkdir -p "$dest"
    mv "$@" "$dest/"
}
```

## Exercícios Práticos

### 🎯 Missão 1: Gerenciamento Básico
```bash
# Crie uma estrutura de trabalho
mkdir -p projeto/{src,docs,tests}
touch projeto/src/{main,util}.sh
cp projeto/src/main.sh projeto/docs/
mv projeto/src/util.sh projeto/tests/
```

### 🎯 Missão 2: Backup Seguro
```bash
# Crie um sistema de backup
timestamp=$(date +%Y%m%d_%H%M%S)
cp -r projeto/ backup_${timestamp}/
```

## Troubleshooting

### Problemas Comuns
- **Permissão negada**: Verifique permissões com `ls -l`
- **Arquivo não encontrado**: Confirme o caminho com `pwd` e `ls`
- **Disco cheio**: Verifique espaço com `df -h`

### Verificações de Segurança
```bash
# Antes de operações destrutivas
ls -l arquivo.txt          # Verificar existência
du -sh diretorio/         # Verificar tamanho
file arquivo.txt          # Verificar tipo
```

## Próximos Passos

Agora que você domina as operações básicas:
1. [Operações Avançadas](advanced-file-ops.md)
2. [Permissões de Arquivos](file-permissions.md)
3. [Compactação e Arquivamento](archive-compression.md)

---

> "A habilidade de manipular arquivos com precisão é o fundamento de todo administrador de sistemas."