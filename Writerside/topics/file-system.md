# Sistema de Arquivos: Navegando na Matrix 

> Experimente o script interativo em `code/module1/file-system/file_explorer.sh` para uma exploração prática do sistema de arquivos e suas operações.
> {style="note"}

```ascii
    MAPEANDO ESTRUTURA DA MATRIX...
    ==============================
    /
    ├── bin/
    ├── etc/
    ├── home/
    └── usr/
    
    STATUS: ESCANEANDO DIRETÓRIOS
    NÍVEL DE ACESSO: INTERMEDIÁRIO
```

## Anatomia do Sistema de Arquivos

### 🌲 A Árvore de Diretórios

```bash
/                   # Raiz do sistema
├── bin/            # Binários essenciais
├── boot/           # Arquivos de inicialização
├── dev/            # Dispositivos
├── etc/            # Configurações do sistema
├── home/           # Diretórios dos usuários
├── lib/            # Bibliotecas compartilhadas
├── media/          # Mídias removíveis
├── mnt/            # Montagens temporárias
├── opt/            # Pacotes opcionais
├── proc/           # Processos do sistema
├── root/           # Home do superusuário
├── run/            # Dados de runtime
├── sbin/           # Binários do sistema
├── srv/            # Dados de serviços
├── sys/            # Sistema
├── tmp/            # Arquivos temporários
├── usr/            # Programas do usuário
└── var/            # Dados variáveis
```

## Navegação Avançada

### 🗺️ Comandos de Navegação Pro
```bash
pwd                     # Mostra diretório atual
cd -                    # Volta ao diretório anterior
cd ~                    # Vai para home
cd ..                   # Sobe um nível
pushd /path/to/dir     # Empilha diretório
popd                   # Desempilha diretório
```

### 🔍 Buscando na Matrix
```bash
find / -name "*.log"    # Busca por nome
locate arquivo.txt      # Busca rápida (requer updatedb)
which comando           # Localiza executável
whereis programa       # Localiza binários e manuais
```

## Manipulação de Arquivos e Diretórios

### 📂 Operações Básicas
```bash
touch arquivo.txt       # Cria arquivo vazio
mkdir -p dir1/dir2     # Cria diretórios recursivamente
cp -r origem destino   # Copia recursivamente
mv origem destino      # Move/renomeia
rm -rf diretorio       # Remove recursivamente (cuidado!)
```

### 🔗 Links e Atalhos
```bash
ln arquivo hard_link    # Link físico
ln -s arquivo soft_link # Link simbólico
readlink link          # Mostra destino do link
```

## Análise do Sistema de Arquivos

### 📊 Comandos de Análise
```bash
df -h                  # Uso do disco
du -sh *              # Tamanho dos arquivos
stat arquivo          # Detalhes do arquivo
file arquivo          # Tipo do arquivo
lsof                  # Arquivos abertos
```

### 🔬 Monitoramento
```bash
inotifywait -m /path  # Monitora mudanças
ncdu                  # Análise de uso do disco
tree                  # Visualiza estrutura
```

## Permissões e Propriedade

### 🔒 Sistema de Permissões
```bash
chmod 755 arquivo     # Modifica permissões
chown user:group arq  # Muda proprietário
chgrp grupo arquivo  # Muda grupo
umask 022            # Define máscara
```

### 📋 Interpretando Permissões
```
rwxr-xr--  1 user group  4096  Jan 1 12:00 arquivo
│││││││││
│││││││└└─ outros (r--)
│││││└└── grupo (r-x)
│└└└└─── dono  (rwx)
└────── tipo (-)
```

## Exercícios Práticos

### 🎯 Missão: Exploração do Sistema

1. **Reconhecimento**
```bash
# Mapeie sua home
tree ~/ -L 2
# Liste arquivos ocultos
ls -la ~/
# Encontre arquivos grandes
find ~/ -size +100M
```

2. **Manipulação**
```bash
# Crie estrutura de diretórios
mkdir -p projeto/{src,docs,tests}
# Crie links simbólicos
ln -s ~/projeto/src ~/src-link
# Archive diretórios
tar -czf backup.tar.gz ~/projeto
```

3. **Análise**
```bash
# Analise uso do disco
du -sh */
# Verifique tipos de arquivo
file *
# Monitore mudanças
watch -n 1 'ls -l'
```

## Troubleshooting

### 🔧 Problemas Comuns
- **Permissão negada**: Use `sudo` ou verifique permissões
- **Disco cheio**: Use `df -h` e `du -sh *`
- **Arquivo não encontrado**: Verifique `$PATH` e permissões
- **Link quebrado**: Use `find -L -type l`

## Power-Ups (Aliases)

### ⚡ Aliases para Navegação
```bash
# Adicione ao .bashrc
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias tree='tree --dirsfirst -C'
```

## Próximos Passos

Agora que você domina o sistema de arquivos:
1. [Aprenda sobre Permissões](permissions.md)
2. [Explore o Processamento de Texto](text-processing.md)
3. [Domine os Scripts](scripting.md)

---

> "O sistema de arquivos é como a Matrix - está em todo lugar, é o que você vê, o que você não vê, e tudo que está entre eles."
> - Morpheus do Terminal

```ascii
    ANÁLISE DO SISTEMA CONCLUÍDA
    [████████████████] 100%
    STATUS: MAPEAMENTO COMPLETO
    MATRIZ DE ARQUIVOS: DOMINADA
```