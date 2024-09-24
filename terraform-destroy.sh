#!/bin/bash

# Переход в директорию с Terraform файлами
SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR/terraform/environments/dev"

# Запуск команды terraform destroy
terraform destroy -auto-approve

# Проверка статуса выполнения
if [ $? -eq 0 ]; then
    echo "Terraform destroy completed successfully."
else
    echo "Terraform destroy failed."
    exit 1
fi
