#!/bin/bash

VAULT_ADDR=${VAULT_ADDR:-"http://127.0.0.1:8200"}
MAX_RETRIES=30
RETRY_INTERVAL=2

for i in $(seq 1 $MAX_RETRIES); do
  SEALED=$(curl -s "${VAULT_ADDR}/v1/sys/seal-status" | grep -o '"sealed":[^,]*' | cut -d':' -f2)
  
  if [ "$SEALED" = "false" ]; then
    echo "Vault is unsealed and ready"
    exit 0
  fi
  
  echo "Waiting for Vault to be unsealed (attempt $i/$MAX_RETRIES)"
  sleep $RETRY_INTERVAL
done

echo "Vault did not become unsealed within expected time"
exit 1
