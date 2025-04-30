#!/bin/bash

# Function to select directories using dialog
select_directories() {
    # Temporary files for dialog interaction
    local tempfile=$(mktemp)
    local resultfile=$(mktemp)

    # Get list of directories in the current working directory
    # Use find to get directories, sed to remove ./ prefix, sort alphabetically
    mapfile -t dirs < <(find . -maxdepth 1 -type d | sed 's|^\./||' | sort | grep -v '^\.$')

    # Check if no directories exist
    if [ ${#dirs[@]} -eq 0 ]; then
        echo "No directories found in the current working directory."
        return 1
    fi

    # Prepare directory list for dialog
    local menu_items=()
    for dir in "${dirs[@]}"; do
        menu_items+=("$dir" "$dir" "off")
    done

    # Use dialog to create checklist
    dialog --clear \
        --title "Select Directories" \
        --checklist "Choose directories (use space to select):" 20 60 15 \
        "${menu_items[@]}" \
        2>"$tempfile"

    # Check dialog exit status
    local status=$?

    # Process results
    if [ $status -eq 0 ]; then
        # Read selected directories
        mapfile -t selected < <(cat "$tempfile" | tr -d '"')

        # Check if any directories were selected
        if [ ${#selected[@]} -eq 0 ]; then
            echo "No directories selected."
            return 1
        fi

        # Write selected directories to result file
        printf '%s\n' "${selected[@]}" > "$resultfile"

        # Clear the screen after dialog
        clear

        # Display selected directories
        echo "Selected Directories:"
        cat "$resultfile"
    else
        # User cancelled
        echo "Selection cancelled."
        return 1
    fi

    # Clean up temporary files
    rm -f "$tempfile" "$resultfile"
}

# Main script execution
main() {
    # Check if dialog is installed
    if ! command -v dialog &> /dev/null; then
        echo "Error: dialog is not installed."
        exit 1
    fi

    # Call directory selection function
    select_directories
}

# Run the main function
main

