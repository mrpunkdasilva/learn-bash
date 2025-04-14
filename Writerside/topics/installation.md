# Instalação do Bash 🛠️

## Windows

### Usando WSL (Windows Subsystem for Linux)
1. Abra o PowerShell como administrador
2. Execute:
   ```bash
   wsl --install
   ```
3. Reinicie o computador
4. O Ubuntu será instalado automaticamente com Bash

### Usando Git Bash
1. Baixe o Git para Windows em https://git-scm.com/download/win
2. Durante a instalação, mantenha as opções padrão
3. Git Bash será instalado com recursos Bash essenciais

## macOS

O Bash já vem instalado, mas você pode atualizar:

```bash
# Usando Homebrew
brew install bash

# Tornar o novo Bash padrão
echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash
```

## Linux

O Bash geralmente já vem instalado. Para garantir a última versão:

### Ubuntu/Debian
```bash
sudo apt update
sudo apt install bash
```

### Fedora/RHEL
```bash
sudo dnf update
sudo dnf install bash
```

## Verificação da Instalação

```bash
# Verificar versão do Bash
bash --version

# Verificar shell padrão
echo $SHELL
```