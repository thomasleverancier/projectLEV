#!/bin/bash

# Переход в директорию с Terraform файлами
cd terraform/environments/dev

# Получение плана изменений
terraform plan -out=tfplan

# Проверка статуса выполнения
if [ $? -ne 0 ]; then
    echo "Terraform plan failed."
    exit 1
fi

# Применение изменений
terraform apply tfplan

# Проверка статуса выполнения
if [ $? -eq 0 ]; then
    echo "Terraform apply completed successfully."
else
    echo "Terraform apply failed."
    exit 1
fi

# Удаление файла плана
rm tfplan
