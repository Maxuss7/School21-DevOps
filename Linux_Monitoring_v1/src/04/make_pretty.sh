#!/bin/bash

if [[ ! -f ./colors.conf ]]; then
    echo "Error: Config file does not exist"
    exit 1
fi

BG_COLORS=(
    "\033[47m"  # white
    "\033[41m"  # red
    "\033[42m"  # green
    "\033[44m"  # blue
    "\033[45m"  # purple
    "\033[40m"  # black
)

FONT_COLORS=(
    "\e[37m"  # white
    "\e[31m"  # red
    "\e[32m"  # green
    "\e[34m"  # blue
    "\e[35m"  # purple
    "\e[30m"  # black
)

COLOR_NAMES=("white" "red" "green" "blue" "purple" "black")

column1_background=$(grep "column1_background" colors.conf | cut -d "=" -f 2 | tr -d '[:space:]')
if [[ -z "$column1_background" ]]; then
    column1_background=6  # Default to black
    column1_background_name="default (black)"
else
    column1_background_name="${COLOR_NAMES[$((column1_background - 1))]}"
fi

column1_font_color=$(grep "column1_font_color" colors.conf | cut -d "=" -f 2 | tr -d '[:space:]')
if [[ -z "$column1_font_color" ]]; then
    column1_font_color=1  # Default to white
    column1_font_color_name="default (white)"
else
    column1_font_color_name="${COLOR_NAMES[$((column1_font_color - 1))]}"
fi

column2_background=$(grep "column2_background" colors.conf | cut -d "=" -f 2 | tr -d '[:space:]')
if [[ -z "$column2_background" ]]; then
    column2_background=2  # Default to red
    column2_background_name="default (red)"
else
    column2_background_name="${COLOR_NAMES[$((column2_background - 1))]}"
fi

column2_font_color=$(grep "column2_font_color" colors.conf | cut -d "=" -f 2 | tr -d '[:space:]')
if [[ -z "$column2_font_color" ]]; then
    column2_font_color=4  # Default to blue
    column2_font_color_name="default (blue)"
else
    column2_font_color_name="${COLOR_NAMES[$((column2_font_color - 1))]}"
fi

# Convert to indices
column1_background=$((column1_background - 1))
column1_font_color=$((column1_font_color - 1))
column2_background=$((column2_background - 1))
column2_font_color=$((column2_font_color - 1))

if [[ "$column1_background" -eq "$column1_font_color" || "$column2_background" -eq "$column2_font_color" ]]; then
    echo "Error: Background color and font color cannot be the same."
    exit 1
fi

print_line() {
    local name="$1"
    local value="$2"

    local NAME_COLOR="${BG_COLORS[$column1_background]}${FONT_COLORS[$column1_font_color]}"
    local VALUE_COLOR="${BG_COLORS[$column2_background]}${FONT_COLORS[$column2_font_color]}"
    local COLOR_RESET="\033[0m"

    echo -e "${NAME_COLOR}$name${COLOR_RESET} = ${VALUE_COLOR}$value${COLOR_RESET}"
}

print_line "HOSTNAME" "$HOSTNAME"
print_line "TIMEZONE" "$TIMEZONE"
print_line "USER" "$USER"
print_line "OS" "$OS"
print_line "DATE" "$DATE"
print_line "UPTIME" "$UPTIME"
print_line "UPTIME_SEC" "$UPTIME_SEC seconds"
print_line "IP" "$IP"
print_line "MASK" "$MASK"
print_line "GATEWAY" "$GATEWAY"
print_line "RAM_TOTAL" "$RAM_TOTAL"
print_line "RAM_USED" "$RAM_USED"
print_line "RAM_FREE" "$RAM_FREE"
print_line "SPACE_ROOT" "$SPACE_ROOT"
print_line "SPACE_ROOT_USED" "$SPACE_ROOT_USED"
print_line "SPACE_ROOT_FREE" "$SPACE_ROOT_FREE"

echo

echo "Column 1 background = $column1_background_name"
echo "Column 1 font color = $column1_font_color_name"
echo "Column 2 background = $column2_background_name"
echo "Column 2 font color = $column2_font_color_name"
