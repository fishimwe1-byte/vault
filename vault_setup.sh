#!/bin/bash

# Define vault path in user's home directory
VAULT_DIR="$HOME/secure_vault"

# Create the secure_vault directory
mkdir -p "$VAULT_DIR"

echo "=== ENCRYPTION KEYS STORAGE ===" > "$VAULT_DIR/keys.txt"
echo "Welcome to the Keys Vault. Store your encryption keys securely here." >> "$VAULT_DIR/keys.txt"
echo "Created on: $(date)" >> "$VAULT_DIR/keys.txt"

echo "=== CONFIDENTIAL SECRETS STORAGE ===" > "$VAULT_DIR/secrets.txt"
echo "Welcome to the Secrets Vault. Store your confidential data securely here." >> "$VAULT_DIR/secrets.txt"
echo "Created on: $(date)" >> "$VAULT_DIR/secrets.txt"

echo "=== SYSTEM LOGS ===" > "$VAULT_DIR/logs.txt"
echo "Welcome to the Logs Vault. System activity will be recorded here." >> "$VAULT_DIR/logs.txt"
echo "Created on: $(date)" >> "$VAULT_DIR/logs.txt"

# Print success message
echo ""
echo "SUCCESS: Secure Vault has been created!"
echo ""
echo "Vault Location: $VAULT_DIR"
echo ""
echo "Files created:"
ls -l "$VAULT_DIR"
echo ""
echo "Your vault is ready for secure operations."

