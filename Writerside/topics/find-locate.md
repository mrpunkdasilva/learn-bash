# Find e Locate: Buscas Avançadas 🔍

## Find - O Rastreador Supremo

```bash
# Busca por nome
find . -name "*.log"              # Busca recursiva por logs
find . -iname "*.LOG"            # Case insensitive
find . -not -name "*.tmp"        # Exclusão
find . -path "*src*"            # Busca no caminho

# Busca por tipo
find . -type f                   # Apenas arquivos
find . -type d                   # Apenas diretórios
find . -type l                   # Apenas links simbólicos

# Busca por tempo
find . -mtime -7                 # Modificados nos últimos 7 dias
find . -mmin -60                # Modificados na última hora
```

## Locate - O Velocista

```bash
# Configuração e atualização
sudo updatedb                    # Atualiza banco de dados
locate -S                       # Estatísticas do banco

# Buscas básicas
locate arquivo.txt              # Busca rápida
locate -i ARQUIVO.TXT          # Case insensitive
locate -e arquivo.txt         # Verifica existência
```

## Exercícios

1. Encontre todos os arquivos .log modificados hoje
2. Use locate para encontrar arquivos de configuração
3. Compare a velocidade entre find e locate