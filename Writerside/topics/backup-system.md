# Sistema de Backup

## Visão Geral
Sistema completo de backup com interface CLI, suporte a backup incremental, compressão, criptografia e notificações.

## Estrutura do Projeto
```bash
backup-system/
├── src/
│   ├── main.sh
│   ├── backup.sh
│   ├── compress.sh
│   ├── encrypt.sh
│   └── notify.sh
├── config/
│   └── backup.yaml
├── logs/
└── README.md
```

## Implementação

### 1. Script Principal
```bash
#!/bin/bash
# src/main.sh

source "$(dirname "$0")/backup.sh"
source "$(dirname "$0")/compress.sh"
source "$(dirname "$0")/encrypt.sh"
source "$(dirname "$0")/notify.sh"

main() {
    local config_file="$1"
    load_config "$config_file"
    perform_backup
    compress_files
    encrypt_backup
    send_notification
}

main "$@"
```

### 2. Configuração YAML
```yaml
# config/backup.yaml
backup:
  source_dirs:
    - /path/to/source1
    - /path/to/source2
  destination: /backup/destination
  retention: 7
  compression: gzip
  encryption: gpg
  notify:
    email: admin@example.com
```

## Como Usar

1. Clone o repositório
2. Configure `backup.yaml`
3. Execute:
```bash
./src/main.sh config/backup.yaml
```

## Recursos Avançados

- Backup incremental usando `rsync`
- Compressão com diferentes algoritmos
- Criptografia GPG
- Rotação automática de backups
- Sistema de logs detalhado
- Notificações por email/Slack