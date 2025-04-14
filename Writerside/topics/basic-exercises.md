# Exercícios Básicos

## Navegação no Sistema de Arquivos

### Exercício 1: Exploração Básica
1. Crie uma pasta chamada `pratica_bash`
2. Navegue até ela
3. Crie três subpastas: `docs`, `scripts`, `backup`
4. Liste o conteúdo do diretório
5. Volte para o diretório pai

### Exercício 2: Manipulação de Arquivos
1. Crie um arquivo `notas.txt`
2. Adicione algumas linhas de texto
3. Copie para `backup/notas_backup.txt`
4. Compare os dois arquivos

## Comandos Básicos

### Exercício 3: Trabalho com Texto
1. Use `echo` para criar um arquivo
2. Conte as linhas com `wc`
3. Visualize com `cat` e `less`
4. Busque palavras com `grep`

### Exercício 4: Permissões
1. Crie um script simples
2. Torne-o executável
3. Execute o script
4. Verifique as permissões

## Soluções

### Exercício 1
```bash
mkdir pratica_bash
cd pratica_bash
mkdir docs scripts backup
ls
cd ..
```

### Exercício 2
```bash
echo "Linha 1" > notas.txt
echo "Linha 2" >> notas.txt
cp notas.txt backup/notas_backup.txt
diff notas.txt backup/notas_backup.txt
```

### Exercício 3
```bash
echo "Testando" > teste.txt
echo "Mais uma linha" >> teste.txt
wc -l teste.txt
cat teste.txt
grep "linha" teste.txt
```

### Exercício 4
```bash
echo '#!/bin/bash' > script.sh
echo 'echo "Olá, Mundo!"' >> script.sh
chmod +x script.sh
./script.sh
ls -l script.sh
```