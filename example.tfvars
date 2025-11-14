# example.tfvars - Copiar a secrets.auto.tfvars y completar
aws_region  = "us-east-1"
project     = "bookstore"
environment = "prod"

# Database - CAMBIAR PASSWORD
db_password = "CHANGE_ME_SECURE_PASSWORD"

# Opcional: ajustar si es necesario
container_cpu           = 256
container_memory        = 512
desired_count_backend   = 2
desired_count_frontend  = 2
