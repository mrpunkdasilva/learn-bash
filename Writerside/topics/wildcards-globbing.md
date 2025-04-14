# Wildcards e Globbing: Dominando Padrões 🎯

## Wildcards Básicos

### Asterisco (*)
```bash
# Exemplos básicos
ls *.txt               # Todos arquivos .txt
ls data*              # Tudo começando com "data"
ls *2023*             # Contém "2023" em qualquer lugar
ls /etc/*.d/          # Todos diretórios .d em /etc

# Combinações múltiplas
ls *.{jpg,png,gif}    # Todas as imagens
ls */*                # Arquivos em subdiretórios
ls **/*.sh           # Recursivo: todos .sh em qualquer nível
```

### Interrogação (?)
```bash
# Substitui um caractere
ls file?.txt          # file1.txt, file2.txt, etc
ls ?.jpg              # Arquivos com um caractere
ls chapter_?.pdf      # chapter_1.pdf, chapter_2.pdf
```

## Globbing Avançado

### Conjuntos de Caracteres [...]
```bash
# Intervalos
ls [a-z]*.txt         # Começa com minúscula
ls [A-Z]*.doc         # Começa com maiúscula
ls file[0-9].txt      # file seguido de um número

# Conjuntos específicos
ls [aeiou]*           # Começa com vogal
ls [!aeiou]*          # Não começa com vogal
ls [[:upper:]]*       # Começa com maiúscula
ls [[:digit:]]*       # Começa com número
```

### Extended Globbing
```bash
# Ativar globbing estendido
shopt -s extglob

# Padrões
ls !(*.txt)           # Tudo exceto .txt
ls *(file|data)*      # Contém "file" ou "data"
ls +(*.jpg|*.png)     # Um ou mais arquivos de imagem
ls ?(test|prod).cfg   # test.cfg ou prod.cfg opcional
ls @(*.txt|*.doc)     # Exatamente um dos padrões
```

## Técnicas Avançadas

### Globbing com Find
```bash
# Combinando com find
find . -name "*.txt" -o -name "*.doc"
find . -path "**/test/*.py"
find . -regex ".*\(test\|prod\).*\.cfg"
```

### Globbing em Scripts
```bash
#!/bin/bash
# Configurações de globbing
shopt -s nullglob     # Arrays vazios para não-matches
shopt -s dotglob      # Inclui arquivos ocultos
shopt -s globstar     # Habilita **

# Processamento de arquivos
for file in **/*.{jpg,png,gif}; do
    echo "Processando: $file"
done
```

## Casos de Uso Comuns

### Organização de Arquivos
```bash
# Mover por tipo
mv *{.jpg,.png} imagens/
mv *{.mp3,.wav} musicas/

# Backup seletivo
cp /etc/*.conf backup/
cp [A-Z]*.txt maiusculas/
```

### Processamento em Lote
```bash
# Conversão de arquivos
for i in *.jpg; do
    convert "$i" "${i%.jpg}.png"
done

# Renomeação em massa
for f in [0-9]*.txt; do
    mv "$f" "arquivo_$f"
done
```

## Dicas e Truques

### Debug de Globbing
```bash
# Ver expansões
set -x
ls *.txt
set +x

# Testar padrões
echo *.txt            # Ver o que será expandido
printf '%s\n' *       # Lista um por linha
```

### Segurança e Boas Práticas
```bash
# Lidar com espaços
for file in "*.txt"; do  # Aspas importantes
    mv "$file" "novo_$file"
done

# Verificar existência
if compgen -G "*.txt" > /dev/null; then
    echo "Arquivos .txt encontrados"
fi
```

## Exercícios Práticos

### Básicos
1. Liste todos os arquivos PDF e DOCX
2. Encontre arquivos que começam com número
3. Mova todos os logs de 2023
4. Copie arquivos com vogais no nome

### Avançados
1. Use globbing estendido para organizar arquivos
2. Crie um script de backup seletivo
3. Implemente renomeação em massa com padrões
4. Desenvolva um sistema de classificação de arquivos

## Troubleshooting

### Problemas Comuns
```bash
# Muito arquivos
# Use find em vez de globbing
find . -name "*.log" -exec rm {} \;

# Nomes complexos
# Use -print0 com xargs
find . -name "*.txt" -print0 | xargs -0 process
```

---

> "O domínio dos padrões de globbing é como ter superpoderes no terminal."