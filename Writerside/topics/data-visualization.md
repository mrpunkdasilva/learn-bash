# Visualização Avançada de Dados

> Aprenda técnicas avançadas para visualizar dados no terminal e criar relatórios visuais efetivos.
> {style="note"}

## Gráficos no Terminal

### 📊 Histogramas Avançados
```bash
#!/bin/bash
# advanced_histogram.sh

create_histogram() {
    local data="$1"
    local width=50  # largura máxima do histograma
    
    # Caracteres para diferentes níveis
    local bars=(' ' '▁' '▂' '▃' '▄' '▅' '▆' '▇' '█')
    
    awk -v w="$width" '
    {
        count[$1]++
        total++
    }
    END {
        max = 0
        for (item in count)
            if (count[item] > max) max = count[item]
            
        for (item in count) {
            scaled = count[item]/max * w
            bar = ""
            for (i=0; i<scaled; i++) bar = bar "█"
            printf "%-15s %5d |%s\n", item, count[item], bar
        }
    }' <<< "$data" | sort -k2nr
}
```

### 📈 Gráficos de Linha
```bash
#!/bin/bash
# line_chart.sh

plot_line_chart() {
    local data="$1"
    local height=20
    local width=60
    
    # Matriz para o gráfico
    declare -A plot
    
    # Inicializa matriz
    for ((y=0; y<height; y++)); do
        for ((x=0; x<width; x++)); do
            plot[$y,$x]=" "
        done
    done
    
    # Plota pontos
    awk -v h="$height" -v w="$width" '
    BEGIN {
        min = 999999; max = -999999
    }
    {
        if ($2 < min) min = $2
        if ($2 > max) max = $2
        values[NR] = $2
    }
    END {
        scale = (h-1)/(max-min)
        for (i=1; i<=NR; i++) {
            x = int((i-1) * (w-1)/(NR-1))
            y = int((values[i]-min) * scale)
            print x, y
        }
    }' <<< "$data" | while read x y; do
        plot[$y,$x]="●"
    done
    
    # Imprime gráfico
    for ((y=height-1; y>=0; y--)); do
        for ((x=0; x<width; x++)); do
            echo -n "${plot[$y,$x]}"
        done
        echo
    done
}
```

## Visualizações Especializadas

### 📊 Mapas de Calor
```bash
#!/bin/bash
# heatmap.sh

create_heatmap() {
    local data="$1"
    local colors=('\e[0m' '\e[38;5;239m' '\e[38;5;242m' '\e[38;5;245m' 
                  '\e[38;5;248m' '\e[38;5;251m' '\e[38;5;254m')
    
    awk -v reset="\e[0m" '
    function get_color(val, max) {
        level = int(val/max * 6)
        return sprintf("\e[38;5;%dm", 239 + level * 3)
    }
    {
        for (i=1; i<=NF; i++) {
            if ($i > max) max = $i
            matrix[NR,i] = $i
        }
    }
    END {
        for (i=1; i<=NR; i++) {
            for (j=1; j<=NF; j++) {
                printf "%s█%s", get_color(matrix[i,j], max), reset
            }
            print ""
        }
    }' <<< "$data"
}
```

### 🌳 Árvores e Hierarquias
```bash
#!/bin/bash
# tree_viz.sh

display_tree() {
    local dir="$1"
    local prefix=""
    local last_dirs=()
    
    tree_recursive() {
        local dir="$1"
        local prefix="$2"
        local items=()
        
        # Lista itens
        while IFS= read -r item; do
            items+=("$item")
        done < <(ls -1A "$dir")
        
        local total=${#items[@]}
        local count=0
        
        for item in "${items[@]}"; do
            ((count++))
            local is_last=$([[ $count -eq $total ]] && echo 1 || echo 0)
            local current_prefix="$prefix"
            
            if ((is_last)); then
                echo "${current_prefix}└── $item"
                current_prefix="${current_prefix}    "
            else
                echo "${current_prefix}├── $item"
                current_prefix="${current_prefix}│   "
            fi
            
            [[ -d "$dir/$item" ]] && tree_recursive "$dir/$item" "$current_prefix"
        done
    }
    
    echo "$dir"
    tree_recursive "$dir" ""
}
```

## Ferramentas e Utilidades

### 🛠️ Gerador de Relatórios
```bash
#!/bin/bash
# report_generator.sh

generate_report() {
    local data="$1"
    local output="$2"
    
    {
        echo "=== Relatório de Análise ==="
        echo "Data: $(date)"
        echo
        echo "1. Distribuição de Dados"
        create_histogram "$data"
        echo
        echo "2. Tendência Temporal"
        plot_line_chart "$data"
        echo
        echo "3. Mapa de Correlação"
        create_heatmap "$data"
    } > "$output"
}
```

### 📊 Formatação de Dados
```bash
#!/bin/bash
# data_formatter.sh

format_table() {
    local data="$1"
    
    # Determina larguras das colunas
    awk '
    {
        for (i=1; i<=NF; i++) {
            l = length($i)
            if (l > max[i]) max[i] = l
        }
    }
    END {
        # Imprime cabeçalho
        for (i=1; i<=NF; i++)
            printf "%-*s ", max[i], $i
        print ""
        
        # Imprime linha separadora
        for (i=1; i<=NF; i++)
            printf "%*s ", max[i], replicate("-", max[i])
        print ""
        
        # Imprime dados
        while (getline) {
            for (i=1; i<=NF; i++)
                printf "%-*s ", max[i], $i
            print ""
        }
    }
    function replicate(str, n) {
        return n <= 0 ? "" : str replicate(str, n-1)
    }' <<< "$data"
}
```

## Exercícios Práticos

### 🎯 Missão 1: Dashboard
```bash
# Crie um dashboard que:
# 1. Mostre múltiplos gráficos
# 2. Atualize em tempo real
# 3. Permita interatividade
# 4. Exporte relatórios
```

### 🎯 Missão 2: Visualização Customizada
```bash
# Desenvolva visualizações para:
# 1. Dados específicos
# 2. Análises complexas
# 3. Relatórios executivos
# 4. Monitoramento em tempo real
```

## Próximos Passos

1. [Text Analysis](text-analysis.md)
2. [Machine Learning Básico](basic-ml.md)

---

> "Uma imagem vale mais que mil logs."

```ascii
    DATA VISUALIZATION
    [📊📊📊📊📊] 100%
    STATUS: VISUALIZADO
    DADOS: COMPREENDIDOS
```