#!/bin/bash
# Visualizador de métricas de capacidade

readonly METRICS_DIR="/var/log/capacity_history"
readonly OUTPUT_DIR="/var/www/html/capacity"

# Função para gerar gráficos usando gnuplot
generate_graphs() {
    local data_file="$1"
    local output_file="$2"
    local title="$3"
    local ylabel="$4"

    gnuplot <<EOF
    set terminal png
    set output "$output_file"
    set title "$title"
    set xlabel "Tempo"
    set ylabel "$ylabel"
    set grid
    plot "$data_file" using 1:2 with lines title "$title"
EOF
}

# Processar métricas e gerar visualizações
process_metrics() {
    mkdir -p "$OUTPUT_DIR"

    # CPU
    awk '/Cpu/ {print strftime("%Y-%m-%d %H:%M:%S"), $2}' "$METRICS_DIR"/cpu_* > "$OUTPUT_DIR/cpu_data.txt"
    generate_graphs "$OUTPUT_DIR/cpu_data.txt" "$OUTPUT_DIR/cpu_usage.png" "CPU Usage" "Percentage"

    # Memória
    awk '/Mem/ {print strftime("%Y-%m-%d %H:%M:%S"), $3/$2*100}' "$METRICS_DIR"/memory_* > "$OUTPUT_DIR/memory_data.txt"
    generate_graphs "$OUTPUT_DIR/memory_data.txt" "$OUTPUT_DIR/memory_usage.png" "Memory Usage" "Percentage"

    # Disco
    awk 'NR==2 {print strftime("%Y-%m-%d %H:%M:%S"), $5}' "$METRICS_DIR"/disk_* > "$OUTPUT_DIR/disk_data.txt"
    generate_graphs "$OUTPUT_DIR/disk_data.txt" "$OUTPUT_DIR/disk_usage.png" "Disk Usage" "Percentage"

    echo "Visualizações geradas em $OUTPUT_DIR"
}

# Gerar relatório HTML
generate_html_report() {
    cat > "$OUTPUT_DIR/index.html" <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Capacity Planning Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .graph { margin: 20px 0; }
        img { max-width: 100%; }
    </style>
</head>
<body>
    <h1>Capacity Planning Dashboard</h1>
    <div class="graph">
        <h2>CPU Usage</h2>
        <img src="cpu_usage.png" alt="CPU Usage">
    </div>
    <div class="graph">
        <h2>Memory Usage</h2>
        <img src="memory_usage.png" alt="Memory Usage">
    </div>
    <div class="graph">
        <h2>Disk Usage</h2>
        <img src="disk_usage.png" alt="Disk Usage">
    </div>
    <p>Last updated: $(date)</p>
</body>
</html>
EOF

    echo "Dashboard HTML gerado em $OUTPUT_DIR/index.html"
}

# Menu principal
main() {
    if ! command -v gnuplot &> /dev/null; then
        echo "gnuplot não está instalado. Por favor, instale-o primeiro."
        exit 1
    }

    echo "=== Visualizador de Métricas de Capacidade ==="
    echo "1. Processar métricas e gerar gráficos"
    echo "2. Gerar dashboard HTML"
    echo "3. Sair"

    read -p "Escolha uma opção: " option

    case $option in
        1)
            process_metrics
            ;;
        2)
            generate_html_report
            ;;
        3)
            exit 0
            ;;
        *)
            echo "Opção inválida"
            ;;
    esac
}

# Execução principal
main