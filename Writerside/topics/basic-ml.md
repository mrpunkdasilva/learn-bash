# Machine Learning Básico

> Introdução a conceitos básicos de Machine Learning usando ferramentas do terminal.
> {style="note"}

## Fundamentos

### 🧮 Análise Estatística
```bash
#!/bin/bash
# statistical_analysis.sh

analyze_data() {
    local data="$1"
    
    awk '
    BEGIN {
        print "=== Análise Estatística ==="
    }
    {
        sum += $1
        sumsq += $1 * $1
        values[NR] = $1
    }
    END {
        # Média
        mean = sum/NR
        
        # Variância
        variance = sumsq/NR - mean^2
        
        # Desvio Padrão
        stddev = sqrt(variance)
        
        # Mediana
        asort(values)
        if (NR % 2)
            median = values[int(NR/2) + 1]
        else
            median = (values[NR/2] + values[NR/2 + 1])/2
            
        print "Amostras:", NR
        print "Média:", mean
        print "Mediana:", median
        print "Desvio Padrão:", stddev
    }' <<< "$data"
}
```

### 📊 Normalização de Dados
```bash
#!/bin/bash
# data_normalization.sh

normalize_data() {
    local data="$1"
    local method="$2"  # min-max ou z-score
    
    case "$method" in
        "min-max")
            awk '
            NR == 1 {
                min = max = $1
            }
            {
                if ($1 < min) min = $1
                if ($1 > max) max = $1
                values[NR] = $1
            }
            END {
                for (i=1; i<=NR; i++)
                    print (values[i] - min)/(max - min)
            }' <<< "$data"
            ;;
        "z-score")
            awk '
            {
                sum += $1
                sumsq += $1 * $1
                values[NR] = $1
            }
            END {
                mean = sum/NR
                stddev = sqrt(sumsq/NR - mean^2)
                for (i=1; i<=NR; i++)
                    print (values[i] - mean)/stddev
            }' <<< "$data"
            ;;
    esac
}
```

## Algoritmos Básicos

### 🎯 K-Means Simples
```bash
#!/bin/bash
# kmeans.sh

kmeans_clustering() {
    local data="$1"
    local k="$2"
    local max_iter=100
    
    awk -v k="$k" -v max_iter="$max_iter" '
    function dist(x1, y1, x2, y2) {
        return sqrt((x1-x2)^2 + (y1-y2)^2)
    }
    
    BEGIN {
        srand()
    }
    
    # Carrega dados
    {
        x[NR] = $1
        y[NR] = $2
    }
    
    END {
        # Inicializa centroides aleatoriamente
        for (i=1; i<=k; i++) {
            c_x[i] = x[int(rand() * NR)]
            c_y[i] = y[int(rand() * NR)]
        }
        
        # Iterações
        for (iter=1; iter<=max_iter; iter++) {
            # Associa pontos aos clusters
            changed = 0
            for (i=1; i<=NR; i++) {
                min_dist = dist(x[i], y[i], c_x[1], c_y[1])
                cluster[i] = 1
                for (j=2; j<=k; j++) {
                    d = dist(x[i], y[i], c_x[j], c_y[j])
                    if (d < min_dist) {
                        min_dist = d
                        cluster[i] = j
                    }
                }
            }
            
            # Atualiza centroides
            for (i=1; i<=k; i++) {
                new_x = new_y = count = 0
                for (j=1; j<=NR; j++) {
                    if (cluster[j] == i) {
                        new_x += x[j]
                        new_y += y[j]
                        count++
                    }
                }
                if (count > 0) {
                    new_x /= count
                    new_y /= count
                    if (new_x != c_x[i] || new_y != c_y[i])
                        changed = 1
                    c_x[i] = new_x
                    c_y[i] = new_y
                }
            }
            
            if (!changed) break
        }
        
        # Imprime resultados
        print "Clusters encontrados:"
        for (i=1; i<=NR; i++)
            print x[i], y[i], cluster[i]
    }' <<< "$data"
}
```

### 📈 Regressão Linear
```bash
#!/bin/bash
# linear_regression.sh

linear_regression() {
    local data="$1"
    
    awk '
    {
        x[NR] = $1
        y[NR] = $2
        sum_x += $1
        sum_y += $2
        sum_xy += $1 * $2
        sum_xx += $1 * $1
    }
    END {
        # Calcula coeficientes
        n = NR
        slope = (n * sum_xy - sum_x * sum_y)/(n * sum_xx - sum_x * sum_x)
        intercept = (sum_y - slope * sum_x)/n
        
        # Calcula R²
        mean_y = sum_y/n
        ss_tot = ss_res = 0
        for (i=1; i<=n; i++) {
            pred = slope * x[i] + intercept
            ss_tot += (y[i] - mean_y)^2
            ss_res += (y[i] - pred)^2
        }
        r2 = 1 - ss_res/ss_tot
        
        print "Coeficiente Angular:", slope
        print "Intercepto:", intercept
        print "R²:", r2
    }' <<< "$data"
}
```

## Avaliação de Modelos

### 📊 Métricas de Avaliação
```bash
#!/bin/bash
# model_evaluation.sh

evaluate_model() {
    local actual="$1"
    local predicted="$2"
    
    paste <(echo "$actual") <(echo "$predicted") | \
    awk '
    {
        error = $1 - $2
        abs_error += abs(error)
        sq_error += error^2
        if ($1 == $2) correct++
    }
    END {
        print "=== Métricas de Avaliação ==="
        print "MAE:", abs_error/NR
        print "MSE:", sq_error/NR
        print "RMSE:", sqrt(sq_error/NR)
        print "Acurácia:", correct/NR * 100 "%"
    }'
}
```

### 🔄 Validação Cruzada
```bash
#!/bin/bash
# cross_validation.sh

cross_validate() {
    local data="$1"
    local k=5  # k-fold
    
    awk -v k="$k" '
    {
        lines[NR] = $0
    }
    END {
        # Embaralha dados
        for (i=NR; i>1; i--) {
            j = int(rand() * i) + 1
            temp = lines[i]
            lines[i] = lines[j]
            lines[j] = temp
        }
        
        # K-fold CV
        fold_size = int(NR/k)
        for (fold=1; fold<=k; fold++) {
            start = (fold-1) * fold_size + 1
            end = fold * fold_size
            
            print "=== Fold", fold, "==="
            print "Test indices:", start, "-", end
        }
    }' <<< "$data"
}
```

## Exercícios Práticos

### 🎯 Missão 1: Classificação
```bash
# Implemente um classificador:
# 1. Prepare os dados
# 2. Treine o modelo
# 3. Avalie performance
# 4. Faça previsões
```

### 🎯 Missão 2: Regressão
```bash
# Desenvolva análise preditiva:
# 1. Analise correlações
# 2. Construa modelo
# 3. Valide resultados
# 4. Otimize parâmetros
```

## Próximos Passos

1. [Data Visualization](data-visualization.md)
2. [Text Analysis](text-analysis.md)

---

> "Dados + Algoritmos = Conhecimento"

```ascii
    MACHINE LEARNING
    [🤖🤖🤖🤖🤖] 100%
    STATUS: TREINADO
    MODELO: OTIMIZADO
```