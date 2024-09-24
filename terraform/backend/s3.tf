# Конфигурация S3 бакета для хранения state файла Terraform
resource "aws_s3_bucket" "terraform_state" {
  bucket = "projectlev-terraform-state"  # Имя S3 бакета

  # Предотвращаем случайное удаление этого S3 бакета
  lifecycle {
    prevent_destroy = true
  }
}

# Включаем версионирование для S3 бакета
resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Включаем шифрование по умолчанию для S3 бакета
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Создаем DynamoDB таблицу для блокировки state файла
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "projectlev-terraform-locks"  # Имя DynamoDB таблицы
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Конфигурация Terraform бэкенда
terraform {
  backend "s3" {
    bucket         = "projectlev-terraform-state"  # Имя S3 бакета
    key            = "dev/terraform.tfstate"  # Путь к state файлу внутри бакета
    region         = "us-east-1"  # Регион, где находится S3 бакет
    dynamodb_table = "projectlev-terraform-locks"  # Имя DynamoDB таблицы для блокировки
    encrypt        = true  # Включаем шифрование state файла
  }
}
