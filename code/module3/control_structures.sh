#!/bin/bash
# Demonstração de estruturas de controle

# If-else
if [ "$1" = "teste" ]; then
    echo "Modo teste ativado"
else
    echo "Modo normal"
fi

# Case
case "$1" in
    start)
        echo "Iniciando..."
        ;;
    stop)
        echo "Parando..."
        ;;
    *)
        echo "Uso: $0 {start|stop}"
        ;;
esac

# Loops
for i in {1..5}; do
    echo "Contagem: $i"
done

# While
count=0
while [ $count -lt 3 ]; do
    echo "While loop: $count"
    ((count++))
done

# Until
until [ $count -eq 0 ]; do
    echo "Until loop: $count"
    ((count--))
done