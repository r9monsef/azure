#!/bin/bash


rm -rf prod/{.terraform,.terraform.lock.hcl,terraform.tfstate,terraform.tfstate.backup}
rm -rf stage/{.terraform,.terraform.lock.hcl,terraform.tfstate,terraform.tfstate.backup}

# Paths to the terraform state files
FILES=(
  "prod/terraform.tfvars"
  "stage/terraform.tfvars"
)

# Keys to clear
KEYS=(
  "resource_group_name"
  "subscription_id"
  "tenant_id"
  "client_id"
  "client_secret"
)

for FILE in "${FILES[@]}"; do
  if [[ -f "$FILE" ]]; then
    for KEY in "${KEYS[@]}"; do
      # Replace value with empty string
      sed -i "s/\($KEY[[:space:]]*=[[:space:]]*\).*/\1\"\"/" "$FILE"
    done
  else
    echo "File not found: $FILE"
  fi
done

