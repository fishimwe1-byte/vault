#!/bin/bash
# Define vault path
VAULT_DIR="$HOME/secure_vault"

# Check if vault exists
if [[ ! -d "$VAULT_DIR" ]]; then
    echo "ERROR: Secure vault does not exist at $VAULT_DIR"
    echo "Please run vault_setup.sh first to create the vault."
    exit 1
fi

# Function to add a secret
add_secret() {
    echo ""
    read -p "Enter your secret: " secret
    if [[ -n "$secret" ]]; then
        echo "$secret" >> "$VAULT_DIR/secrets.txt"
        echo "Secret added successfully!"
    else
        echo "No secret entered. Operation cancelled."
    fi
}

# Function to update a secret
update_secret() {
    echo ""
    echo "Current secrets in vault:"
    echo "--------------------------"
    cat "$VAULT_DIR/secrets.txt"
    echo "--------------------------"
    echo ""
    read -p "Enter the text to find: " old_text
    read -p "Enter the replacement text: " new_text
    
    if [[ -n "$old_text" && -n "$new_text" ]]; then
        # Check if the text exists
        if grep -q "$old_text" "$VAULT_DIR/secrets.txt"; then
            sed -i "s/$old_text/$new_text/g" "$VAULT_DIR/secrets.txt"
            echo "Secret updated successfully!"
        else
            echo "No match found."
        fi
    else
        echo "Invalid input. Operation cancelled."
    fi
}

# Function to add a log entry
add_log() {
    echo ""
    read -p "Enter log message: " log_message
    if [[ -n "$log_message" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $log_message" >> "$VAULT_DIR/logs.txt"
        echo "Log entry added with timestamp!"
    else
        echo "No message entered. Operation cancelled."
    fi
}

# Function to access keys (always denied)
access_keys() {
    echo ""
    echo "ACCESS DENIED"
    echo "You do not have permission to view encryption keys."
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] UNAUTHORIZED ACCESS ATTEMPT - keys.txt" >> "$VAULT_DIR/logs.txt"
}

# Main menu loop
while true; do
    echo ""
    echo "===== SECURE VAULT OPERATIONS ====="
    echo "  1. Add Secret"
    echo "  2. Update Secret"
    echo "  3. Add Log Entry"
    echo "  4. Access Keys"
    echo "  5. Exit"
    echo ""
    read -p "Select an option (1-5): " choice
    
    case $choice in
        1)
            add_secret
            ;;
        2)
            update_secret
            ;;
        3)
            add_log
            ;;
        4)
            access_keys
            ;;
        5)
            echo ""
            echo "Exiting Secure Vault Operations."
            echo "Vault secured. Goodbye!"
            exit 0
            ;;
        *)
            echo ""
            echo "Invalid option. Please select 1-5."
            ;;
    esac
done

