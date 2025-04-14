# Criptografia de Arquivos

> Proteja seus dados com criptografia robusta
> {style="warning"}

## Criptografia Simétrica

### OpenSSL
```bash
# Encriptar arquivo
openssl enc -aes-256-cbc -salt -in arquivo.txt -out arquivo.enc
# Decriptar arquivo
openssl enc -d -aes-256-cbc -in arquivo.enc -out arquivo.txt
```

### GPG
```bash
# Encriptar com senha
gpg -c arquivo.txt
# Decriptar
gpg arquivo.txt.gpg
```

## Criptografia Assimétrica

### Gerenciamento de Chaves
```bash
# Gerar par de chaves
gpg --gen-key
# Exportar chave pública
gpg --export -a "Usuario" > public.key
```

### Operações com Arquivos
```bash
# Encriptar para destinatário
gpg -e -r "Usuario" arquivo.txt
# Assinar arquivo
gpg --sign arquivo.txt
```

## LUKS (Linux Unified Key Setup)

### Configuração
```bash
# Criar volume criptografado
cryptsetup luksFormat /dev/sdb1
# Abrir volume
cryptsetup luksOpen /dev/sdb1 volume_secreto
```

### Gerenciamento
```bash
# Adicionar chave
cryptsetup luksAddKey /dev/sdb1
# Remover chave
cryptsetup luksRemoveKey /dev/sdb1
```

## Scripts de Automação

### Backup Criptografado
```bash
#!/bin/bash
# backup_cripto.sh

encrypt_backup() {
    tar -czf - "$1" | \
    openssl enc -aes-256-cbc -salt -out "$2"
}

# Uso
encrypt_backup /dados backup.tar.gz.enc
```

## Exercícios Práticos

### 🎯 Missão: Sistema de Arquivos Seguros
1. Implemente backup criptografado
2. Configure volume LUKS
3. Estabeleça rotação de chaves
4. Monitore integridade