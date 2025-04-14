# Automatização DevOps 🔄

## Visão Geral
Suite de scripts para automação de CI/CD, gestão de ambientes e deploy.

## Estrutura
```bash
devops-automation/
├── ci/
│   ├── pipeline.sh
│   └── tests.sh
├── cd/
│   ├── deploy.sh
│   └── rollback.sh
├── environments/
│   ├── dev.env
│   ├── staging.env
│   └── prod.env
└── scripts/
```

## Implementação

### 1. Pipeline CI
```bash
#!/bin/bash
# ci/pipeline.sh

set -e

# Configuração
source "$(dirname "$0")/../environments/${ENV:-dev}.env"

# Etapas do Pipeline
run_tests() {
    echo "Running tests..."
    ./ci/tests.sh
}

build_app() {
    echo "Building application..."
    docker build -t myapp:${VERSION} .
}

push_image() {
    echo "Pushing to registry..."
    docker push myapp:${VERSION}
}

main() {
    run_tests
    build_app
    push_image
}

main "$@"
```

### 2. Deploy Automatizado
```bash
#!/bin/bash
# cd/deploy.sh

set -e

# Configuração
source "$(dirname "$0")/../environments/${ENV:-dev}.env"

# Funções de Deploy
deploy_app() {
    echo "Deploying to ${ENV}..."
    
    # Backup atual
    backup_current_version
    
    # Deploy nova versão
    kubectl apply -f k8s/
    
    # Verificar health
    check_deployment_health
}

backup_current_version() {
    echo "Backing up current version..."
    kubectl get deployment -o yaml > backup/deploy-$(date +%Y%m%d_%H%M%S).yaml
}

check_deployment_health() {
    echo "Checking deployment health..."
    kubectl rollout status deployment/myapp
}

main() {
    deploy_app
}

main "$@"
```

## Configuração de Ambientes
```bash
# environments/prod.env
export ENV="prod"
export VERSION="1.0.0"
export REGISTRY="registry.example.com"
export K8S_NAMESPACE="production"
```

## Como Usar

1. Configure o ambiente:
```bash
source environments/dev.env
```

2. Execute o pipeline:
```bash
./ci/pipeline.sh
```

3. Deploy:
```bash
./cd/deploy.sh
```

## Recursos Avançados

- Integração com Git
- Testes automatizados
- Multi-ambiente
- Rollback automático
- Monitoramento de deploy