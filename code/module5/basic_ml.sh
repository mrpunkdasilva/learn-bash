#!/bin/bash
# Processamento básico de Machine Learning

# Configurações
readonly DATA_DIR="/var/lib/ml/data"
readonly MODEL_DIR="/var/lib/ml/models"
readonly PYTHON_ENV="/opt/ml/venv/bin/python"

# Verificar ambiente Python
check_python_env() {
    if [[ ! -f "$PYTHON_ENV" ]]; then
        echo "Criando ambiente Python..."
        python3 -m venv /opt/ml/venv
        
        # Instalar dependências
        "$PYTHON_ENV" -m pip install numpy pandas scikit-learn
    fi
}

# Preparar dados
prepare_data() {
    local input_file=$1
    local output_file="$DATA_DIR/prepared_data.csv"
    
    # Exemplo de preparação de dados
    awk -F',' '
    NR > 1 {
        # Remover linhas vazias
        if (NF > 0) {
            # Normalizar dados numéricos
            for (i=1; i<=NF; i++) {
                if ($i ~ /^[0-9.]+$/) {
                    $i = ($i - min[i]) / (max[i] - min[i])
                }
            }
            print
        }
    }' "$input_file" > "$output_file"
}

# Treinar modelo
train_model() {
    local data_file=$1
    local model_name=$2
    
    cat > train_model.py <<EOF
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import joblib

# Carregar dados
data = pd.read_csv('$data_file')
X = data.drop('target', axis=1)
y = data['target']

# Dividir dados
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# Treinar modelo
model = RandomForestClassifier(n_estimators=100)
model.fit(X_train, y_train)

# Avaliar modelo
score = model.score(X_test, y_test)
print(f'Acurácia: {score:.2f}')

# Salvar modelo
joblib.dump(model, '$MODEL_DIR/$model_name.joblib')
EOF

    "$PYTHON_ENV" train_model.py
    rm train_model.py
}

# Fazer previsões
make_predictions() {
    local model_name=$1
    local input_data=$2
    
    cat > predict.py <<EOF
import pandas as pd
import joblib

# Carregar modelo
model = joblib.load('$MODEL_DIR/$model_name.joblib')

# Carregar dados
data = pd.read_csv('$input_data')

# Fazer previsões
predictions = model.predict(data)

# Salvar resultados
pd.DataFrame(predictions).to_csv('predictions.csv', index=False)
EOF

    "$PYTHON_ENV" predict.py
    rm predict.py
}

# Menu principal
main_menu() {
    while true; do
        echo -e "\n=== Processamento ML Básico ==="
        echo "1. Verificar ambiente"
        echo "2. Preparar dados"
        echo "3. Treinar modelo"
        echo "4. Fazer previsões"
        echo "5. Visualizar modelos"
        echo "6. Sair"
        
        read -p "Escolha uma opção: " option
        
        case $option in
            1)
                check_python_env
                ;;
            2)
                read -p "Arquivo de dados: " data_file
                prepare_data "$data_file"
                ;;
            3)
                read -p "Arquivo de dados: " data_file
                read -p "Nome do modelo: " model_name
                train_model "$data_file" "$model_name"
                ;;
            4)
                read -p "Nome do modelo: " model_name
                read -p "Dados para previsão: " input_data
                make_predictions "$model_name" "$input_data"
                ;;
            5)
                ls -l "$MODEL_DIR"
                ;;
            6)
                echo "Encerrando..."
                exit 0
                ;;
            *)
                echo "Opção inválida"
                ;;
        esac
    done
}

# Criar diretórios necessários
mkdir -p "$DATA_DIR" "$MODEL_DIR"

# Iniciar
main_menu