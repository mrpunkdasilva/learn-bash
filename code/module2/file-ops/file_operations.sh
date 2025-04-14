#!/bin/bash
# Demonstração de operações com arquivos

# Operações básicas
touch arquivo.txt                    # Cria arquivo vazio
cp arquivo.txt backup.txt           # Copia arquivo
mv backup.txt ~/backups/            # Move arquivo
rm arquivo_antigo.txt              # Remove arquivo

# Permissões
chmod +x script.sh                  # Torna executável
chmod 755 diretorio                # Define permissões
chown usuario:grupo arquivo.txt    # Muda proprietário

# Compressão
tar -czf backup.tar.gz diretorio/  # Compacta diretório
tar -xzf backup.tar.gz            # Descompacta
zip -r backup.zip diretorio/      # Cria zip
unzip backup.zip                  # Descompacta zip

# Links
ln -s arquivo.txt link_simbolico   # Cria link simbólico
ln arquivo.txt link_fisico        # Cria hard link

# Monitoramento
watch -n 1 ls -l                   # Monitora diretório
inotifywait -m diretorio/         # Monitora mudanças