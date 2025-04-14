# Pilha de Diretórios 

## Comandos da Pilha

```bash
pushd /var/log        # Empilha diretório atual e vai para /var/log
pushd /etc           # Empilha novamente
dirs                 # Mostra a pilha
popd                # Volta para o último diretório empilhado
dirs -v             # Mostra pilha numerada
pushd +2            # Vai para posição 2 da pilha
pushd -n            # Empilha sem mudar de diretório
dirs -c             # Limpa a pilha
```

## Usos Práticos

```bash
# Salvando múltiplos caminhos
pushd ~/projetos
pushd /var/log
pushd /etc/nginx
dirs -v             # Ver todos os caminhos salvos
popd               # Voltar na ordem inversa
```

## Exercícios

1. Crie uma pilha com 3 diretórios diferentes
2. Navegue entre eles usando pushd +n
3. Limpe a pilha e comece uma nova