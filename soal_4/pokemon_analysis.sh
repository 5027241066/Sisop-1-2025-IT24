#!/bin/bash

# ASCII Art 
display_ascii_art() {
    echo "========================================="
    echo "Y   Y  EEEEE  L      L       OOO   W   W"
    echo " Y Y   E      L      L      O   O  W   W"
    echo "  Y    EEEE   L      L      O   O  W W W"
    echo "  Y    E      L      L      O   O  WW WW"
    echo "  Y    EEEEE  LLLLL  LLLLL   OOO   W   W"
    echo "========================================="
}

#  help screen
show_help() {
    display_ascii_art
    echo "Usage: ./pokemon_analysis.sh <input_file> <option> [arguments]"
    echo ""
    echo "Options:"
    echo "  --info               : Show summary of Pokemon usage (Usage% and RawUsage)"
    echo "  --sort <column>      : Sort Pokemon by column (usage, rawusage, name, hp, atk, def, spatk, spdef, speed)"
    echo "  --grep <name>        : Search Pokemon by name"
    echo "  --filter <type>      : Filter Pokemon by type (e.g., Dark, Fire)"
    echo "  -h, --help           : Show this help screen"
    echo ""
    echo "Examples:"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --info"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --sort usage"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --grep Rotom"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --filter Dark"
} 

# summary
show_summary() {
    input_file=$1

    if [[ ! -f "$input_file" ]]; then
        echo "Error: File '$input_file' not found!"
        exit 1
    fi

    highest_usage=$(awk -F',' 'NR>1 {if ($2+0 > max) {max=$2+0; name=$1}} END {print name, max"%"}' "$input_file")
    highest_raw=$(awk -F',' 'NR>1 {if ($3+0 > max) {max=$3+0; name=$1}} END {print name, max" uses"}' "$input_file")

    echo "📊 Summary of $input_file"
    echo "🔥 Highest Adjusted Usage: $highest_usage"
    echo "⚔  Highest Raw Usage: $highest_raw"
}

# mengurutkan Pokemon
sort_pokemon() {
    input_file=$1
    sort_by=$2
    limit=10  

    case $sort_by in
        "usage")   col=2;;
        "rawusage") col=3;;
        "name")    col=1;;
        "hp")      col=6;;
        "atk")     col=7;;
        "def")     col=8;;
        "spatk")   col=9;;
        "spdef")   col=10;;
        "speed")   col=11;;
        *) echo "Error: Invalid sort option"; show_help; exit 1;;
    esac

    head -n 1 "$input_file"
    tail -n +2 "$input_file" | sort -t, -k${col},${col}nr | head -n $limit
}

# Pokemon berdasarkan nama
search_pokemon() {
    input_file=$1
    search_term=$2

    # Pastikan header tetap tampil
    head -n 1 "$input_file"

    # Cari Pokemon dengan nama yang mengandung keyword dan urutkan berdasarkan Us>   
    awk -F',' -v name="$search_term" 'NR>1 && tolower($1) ~ tolower(name)' "$inpu>}
    
# Pokemon berdasarkan type
filter_by_type() {
    input_file=$1
    filter_type=$2

    echo "Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed"
    awk -F',' -v type="$filter_type" 'NR>1 && ($4 == type || $5 == type)' "$input_file" | sort -t, -k2,2nr
}



if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <pokemon_usage.csv> <option> [arguments]"
    echo "Use -h or --help for more information."
    exit 1
fi

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

if [[ $# -lt 2 ]]; then
    echo "Error: Insufficient arguments"
    show_help
    exit 1
fi

input_file=$1
option=$2

if [[ ! -f "$input_file" ]]; then
    echo "Error: File '$input_file' not found!"
    exit 1
fi

case $option in
    "--info")
        show_summary "$input_file"
        ;;
    "--sort")
        if [[ $# -lt 3 ]]; then
            echo "Error: No sort option provided"
            show_help
            exit 1
        fi
        sort_pokemon "$input_file" "$3"
        ;;
    "--grep")
        if [[ $# -lt 3 ]]; then
            echo "Error: No search term provided"
            show_help
            exit 1
        fi
        search_pokemon "$input_file" "$3"
        ;;
    "--filter")
        if [[ $# -lt 3 ]]; then
            echo "Error: No filter option provided"
            show_help
            exit 1
        fi
        filter_by_type "$input_file" "$3"
        ;;
    *)
        echo "Error: Invalid option '$option'"
        show_help
        exit 1
        ;;
esac
