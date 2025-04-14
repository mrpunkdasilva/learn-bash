# Referência de Comandos 📖

## Comandos Essenciais

### Navegação
| Comando | Descrição | Exemplo |
|---------|-----------|---------|
| `cd` | Muda diretório | `cd /home/user` |
| `pwd` | Mostra diretório atual | `pwd` |
| `ls` | Lista arquivos | `ls -la` |
| `find` | Busca arquivos | `find . -name "*.sh"` |

### Manipulação de Arquivos
| Comando | Descrição | Exemplo |
|---------|-----------|---------|
| `cp` | Copia | `cp arquivo.txt backup/` |
| `mv` | Move/renomeia | `mv old.txt new.txt` |
| `rm` | Remove | `rm -rf diretorio/` |
| `chmod` | Muda permissões | `chmod +x script.sh` |

### Processamento de Texto
| Comando | Descrição | Exemplo |
|---------|-----------|---------|
| `grep` | Busca texto | `grep -r "texto" .` |
| `sed` | Editor de stream | `sed 's/old/new/g'` |
| `awk` | Processamento | `awk '{print $1}'` |

### Sistema
| Comando | Descrição | Exemplo |
|---------|-----------|---------|
| `ps` | Lista processos | `ps aux` |
| `top` | Monitor sistema | `top` |
| `df` | Espaço em disco | `df -h` |
| `du` | Uso de disco | `du -sh *` |

## Operadores e Sintaxe

### Redirecionamento
```bash
comando > arquivo    # Saída para arquivo
comando >> arquivo   # Anexa ao arquivo
comando < arquivo    # Entrada do arquivo
comando 2> erro.log  # Redireciona erro
```

### Pipes e Concatenação
```bash
cmd1 | cmd2         # Pipe
cmd1 && cmd2        # AND lógico
cmd1 || cmd2        # OR lógico
cmd1 ; cmd2         # Sequencial
```

### Expansões
```bash
${variavel}         # Expansão variável
$(comando)          # Expansão comando
$((expressao))      # Expansão aritmética
{1..5}             # Expansão de sequência
```

## Referência Rápida por Categoria

### 🔍 Busca
```bash
find / -name arquivo
locate arquivo
which comando
whereis comando
```

### 📊 Monitoramento
```bash
free -h
vmstat
iostat
netstat
```

### 📝 Edição
```bash
nano arquivo
vim arquivo
head arquivo
tail -f arquivo
```

### 🔒 Segurança
```bash
sudo comando
chown usuario arquivo
chmod 755 arquivo
ssh usuario@host
```

## Flags Comuns

### Flags Universais
- `-h, --help`: Ajuda
- `-v, --version`: Versão
- `-f, --force`: Força
- `-r, --recursive`: Recursivo

### Flags de Listagem
- `-l`: Formato longo
- `-a`: Mostra ocultos
- `-h`: Tamanhos legíveis
- `-R`: Recursivo

## Atalhos do Terminal

### Navegação
- `Ctrl + A`: Início da linha
- `Ctrl + E`: Fim da linha
- `Ctrl + U`: Limpa linha
- `Ctrl + R`: Busca histórico

### Controle
- `Ctrl + C`: Cancela
- `Ctrl + Z`: Suspende
- `Ctrl + D`: EOF/Sair
- `Ctrl + L`: Limpa tela

---

> "Um comando vale mais que mil cliques."