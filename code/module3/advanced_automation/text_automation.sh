#!/bin/bash
# Automação de processamento de texto

# Processamento de logs
process_logs() {
    local log_file="$1"
    local pattern="$2"
    
    awk -v pat="$pattern" '
    BEGIN { count=0 }
    $0 ~ pat { count++ }
    END { print "Ocorrências:", count }
    ' "$log_file"
}

# Transformação de dados
convert_csv_to_json() {
    local csv_file="$1"
    local json_file="$2"
    
    awk -F',' '
    BEGIN { print "[" }
    NR>1 {
        printf "  {\n"
        printf "    \"name\": \"%s\",\n", $1
        printf "    \"value\": \"%s\"\n", $2
        printf "  }%s\n", (NR==NR ? "" : ",")
    }
    END { print "]" }
    ' "$csv_file" > "$json_file"
}