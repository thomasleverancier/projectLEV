#!/bin/bash

# Установка переменных
BUCKET_NAME="projectlev-terraform-state"
KEY="dev/terraform.tfstate"
REGION="us-east-1"
DYNAMODB_TABLE="projectlev-terraform-locks"

# Переход в директорию с Terraform файлами
SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR/terraform/environments/dev"

# Инициализация Terraform
terraform init -reconfigure \
    -backend-config="bucket=${BUCKET_NAME}" \
    -backend-config="key=${KEY}" \
    -backend-config="region=${REGION}" \
    -backend-config="dynamodb_table=${DYNAMODB_TABLE}"

# Проверка статуса выполнения
if [ $? -eq 0 ]; then
    echo "Terraform initialization completed successfully."
else
    echo "Terraform initialization failed."
    exit 1
fi
