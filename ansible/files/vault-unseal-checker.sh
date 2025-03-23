#!/bin/bash

# Path to the file containing the unseal key
UNSEAL_KEY_FILE="/etc/vault.d/unseal.key"

# Vault address
VAULT_ADDR="https://127.0.0.1:8200"

# Function to check if Vault is sealed
is_vault_sealed() {
    sealed=$(curl -s ${VAULT_ADDR}/v1/sys/seal-status | jq -r .sealed)
    [ "$sealed" = "true" ]
}

# Function to unseal Vault
unseal_vault() {
    key=$(cat $UNSEAL_KEY_FILE)
    curl -s -X POST -d "{\"key\": \"$key\"}" ${VAULT_ADDR}/v1/sys/unseal
}

# Main loop
while true; do
    if is_vault_sealed; then
        echo "Vault is sealed. Unsealing..."
        unseal_vault
    else
        echo "Vault is unsealed."
    fi
    sleep 60
done