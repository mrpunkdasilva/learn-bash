# Comandos Essenciais

> Os códigos de exemplo para este módulo estão disponíveis em `code/module2/`. Cada subdiretório contém scripts práticos para você experimentar.
> {style="note"}

```ascii
    CARREGANDO ARSENAL DE COMANDOS...
    ================================
    STATUS: FERRAMENTAS PREPARADAS
    NÍVEL: INTERMEDIÁRIO
    PODER: AUMENTANDO
    ================================
```

## Visão Geral

Neste módulo, você vai dominar as ferramentas essenciais do terminal, expandindo seu arsenal de comandos para:
- Navegar pelo sistema como um ninja 🥷
- Manipular arquivos com precisão cirúrgica 🎯
- Processar texto como um mestre Jedi ⚔️
- Extrair informações do sistema como um hacker de elite 🕵️

## Tópicos do Módulo

### 1. [Comandos de Navegação](navigation-commands.md)
- Navegação avançada com `cd`, `pushd`, `popd`
- Buscas com `find` e `locate`
- Atalhos e truques de navegação
- Gerenciamento de diretórios

### 2. [Operações com Arquivos](file-operations.md)
- Manipulação avançada com `cp`, `mv`, `rm`
- Compactação e descompactação
- Links simbólicos e hardlinks
- Gerenciamento de permissões

### 3. [Processamento de Texto](text-processing.md)
- Filtragem com `grep`
- Transformação com `sed`
- Processamento com `awk`
- Ordenação e contagem

### 4. [Informações do Sistema](system-info.md)
- Monitoramento com `top` e `htop`
- Análise de disco com `df` e `du`
- Gerenciamento de processos
- Informações de rede

## Ferramentas Essenciais

```bash
# Navegação Avançada
find / -name "*.log" 2>/dev/null    # Busca todos os logs
locate "*.conf"                      # Localiza configs
which python3                        # Onde está o executável?
whereis bash                         # Onde está tudo do bash?

# Operações com Arquivos
tar -czf backup.tar.gz ./docs       # Compacta
tar -xzf backup.tar.gz              # Descompacta
rsync -av source/ dest/             # Sincroniza diretórios
dd if=/dev/zero of=test bs=1M count=100  # Cria arquivo de teste

# Processamento de Texto
grep -r "TODO" .                    # Busca recursiva
sed 's/antigo/novo/g' arquivo.txt   # Substitui texto
awk '{print $1}' dados.txt          # Extrai primeira coluna
sort -u números.txt                 # Ordena e remove duplicatas

# Informações do Sistema
ps aux | grep nginx                 # Processos específicos
netstat -tulpn                      # Portas abertas
free -h                            # Memória disponível
uptime                             # Tempo ligado
```

## Dicas de Poder

### 🎯 Combinando Comandos
```bash
# Pipeline de processamento
find . -type f -name "*.log" | \
  xargs grep "ERROR" | \
  sort | uniq -c | \
  sort -nr
```

### ⚡ Atalhos de Teclado
- `Ctrl + R`: Busca no histórico
- `Alt + .`: Último argumento
- `Ctrl + W`: Apaga última palavra
- `Ctrl + U`: Apaga linha inteira

## Exercícios Práticos

### 🎓 Missões de Treinamento

1. **Navegação Ninja**
   - Encontre todos os arquivos modificados hoje
   - Liste apenas diretórios em uma árvore profunda
   - Localize todos os executáveis no PATH

2. **Manipulação de Arquivos**
   - Crie um backup compactado de uma estrutura
   - Sincronize dois diretórios
   - Encontre e remova arquivos duplicados

3. **Processamento de Dados**
   - Extraia endereços IP de um log
   - Conte ocorrências de palavras em múltiplos arquivos
   - Substitua texto em vários arquivos

4. **Análise do Sistema**
   - Monitore uso de CPU por processo
   - Verifique espaço em disco por diretório
   - Liste todas as conexões de rede ativas

## Próximos Passos

Depois de dominar estes comandos essenciais, você estará pronto para:
1. [Automação com Scripts](scripting.md)
2. [Administração do Sistema](system-admin.md)
3. [Redes e Conectividade](networking.md)

---

> "Com grandes comandos vem grandes responsabilidades."
> - Uncle Terminal

```ascii
    CARREGAMENTO CONCLUÍDO
    [████████████████] 100%
    STATUS: ARSENAL PREPARADO
    PODER: INTERMEDIÁRIO
    PRÓXIMA MISSÃO: AGUARDANDO...
```