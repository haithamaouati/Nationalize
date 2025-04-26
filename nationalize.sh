#!/bin/bash

# Author: Haitham Aouati
# GitHub: github.com/haithamaouati

# Text format
normal="\e[0m"
bold="\e[1m"
result="\e[1;32m"
faint="\e[2m"
underlined="\e[4m"
error_color="\e[1;31m"

# Dependencies check
dependencies=(figlet curl jq bc)
for cmd in "${dependencies[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
        echo -e "${error_color}Error:${normal} '$cmd' is required but not installed. Please install it and try again." >&2
        exit 1
    fi
done

# Clear the screen
clear

print_banner() {
  figlet -f standard "Nationalize"
  echo -e "${bold}Nationalize${normal} — Predict the Ethnicity of a Name\n"
  echo -e " Author: Haitham Aouati"
  echo -e " GitHub: ${underlined}github.com/haithamaouati${normal}\n"
}

print_banner

API_URL="https://api.nationalize.io"

show_help() {
  echo "Usage: $0 -n <NAME>"
  echo
  echo "Options:"
  echo "  -n, --name       Specify the name to analyze (required)"
  echo -e "  -h, --help       Show this help message\n"
}

# Parse args
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -n|--name)
      if [[ -z "$2" || "$2" == -* ]]; then
        echo -e "Error: Missing name for -n|--name\n"
        show_help
        exit 1
      fi
      NAME="$2"
      shift 2
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown parameter: $1"
      show_help
      exit 1
      ;;
  esac
done

if [[ -z "$NAME" ]]; then
  echo -e "Error: name is required.\n"
  show_help
  exit 1
fi

# Call API
RESPONSE=$(curl -s "${API_URL}?name=${NAME}")

# Extract name and countries array
NAME_RESULT=$(echo "$RESPONSE" | jq -r '.name // "N/A"')
COUNTRIES=$(echo "$RESPONSE" | jq -c '.country')

# Output
echo -e "Name: ${result}$NAME_RESULT${normal}"

if [[ "$COUNTRIES" == "[]" ]]; then
  echo "No country predictions found."
  exit 0
fi

echo -e "\nTop nationalities:"

COUNTER=1
for row in $(echo "$COUNTRIES" | jq -c '.[]'); do
  CODE=$(echo "$row" | jq -r '.country_id')
  RAW_PROB=$(echo "$row" | jq -r '.probability')
  PROB=$(printf "%.0f%%" "$(echo "$RAW_PROB * 100" | bc -l)")

  if [[ -f "countries.json" ]]; then
    COUNTRY_NAME=$(jq -r --arg code "$CODE" '.[] | select(.code == $code) | .name' countries.json)
  fi

  COUNTRY_NAME=${COUNTRY_NAME:-$CODE}
  echo -e "$COUNTER. ${result}$COUNTRY_NAME ($CODE)${normal} with ${result}$PROB${normal} probability"
  ((COUNTER++))
done

echo ""
