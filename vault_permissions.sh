#!/bin/bash
# Define vault path
VAULT_DIR="$HOME/secure_vault"

# Default permissions
DEFAULT_KEYS_PERM="600"
DEFAULT_SECRETS_PERM="640"
DEFAULT_LOGS_PERM="644"

# Function to update permissions
update_permission() {
    local file=$1
    local default_perm=$2
    local filename=$(basename "$file")
    
    echo ""
    echo "--------------------------------------------"
    echo "File: $filename"
    echo "Current permissions:"
    ls -l "$file"
    echo ""
    
    read -p "Do you want to update the permission? (y/n): " choice
    
    case $choice in
        [Yy]|[Yy][Ee][Ss])
            read -p "Enter new permission (e.g., 600): " new_perm
            if [[ -z "$new_perm" ]]; then
                echo "No input provided. Applying default permission: $default_perm"
                chmod "$default_perm" "$file"
            else
                chmod "$new_perm" "$file"
                echo "Permission updated to $new_perm"
            fi
            ;;
        [Nn]|[Nn][Oo])
            echo "Permission unchanged."
            ;;
        "")
            echo "No input provided. Applying default permission: $default_perm"
            chmod "$default_perm" "$file"
            ;;
        *)
            echo "Invalid input. Applying default permission: $default_perm"
            chmod "$default_perm" "$file"
            ;;
    esac
}

# Check if secure_vault exists
if [[ ! -d "$VAULT_DIR" ]]; then
    echo "ERROR: Secure vault does not exist at $VAULT_DIR"
    echo "Please run vault_setup.sh first to create the vault."
    exit 1
fi

echo "SECURE VAULT PERMISSIONS MANAGER"
echo "================================"
echo "Vault Location: $VAULT_DIR"

# Update permissions for each file
update_permission "$VAULT_DIR/keys.txt" "$DEFAULT_KEYS_PERM"
update_permission "$VAULT_DIR/secrets.txt" "$DEFAULT_SECRETS_PERM"
update_permission "$VAULT_DIR/logs.txt" "$DEFAULT_LOGS_PERM"

# Display final permissions
echo ""
echo "--------------------------------------------"
echo "FINAL FILE PERMISSIONS:"
echo "--------------------------------------------"
ls -l "$VAULT_DIR"
echo ""
echo "Permission management complete."

