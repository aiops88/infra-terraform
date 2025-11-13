variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region para desplegar recursos"
}

variable "project" {
  type        = string
  default     = "bookstore"
  description = "Nombre del proyecto"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "Ambiente (dev, staging, prod)"
}

# VPC Configuration
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block para la VPC"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "CIDRs para subnets públicas"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
  description = "CIDRs para subnets privadas"
}

# Database Configuration
variable "db_username" {
  type        = string
  default     = "bookstore_admin"
  description = "Usuario de la base de datos"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Password de la base de datos - debe estar en secrets.auto.tfvars"
}

variable "db_name" {
  type        = string
  default     = "bookstoredb"
  description = "Nombre de la base de datos"
}

variable "rds_allocated_storage" {
  type        = number
  default     = 20
  description = "Almacenamiento en GB para RDS"
}

variable "rds_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Tipo de instancia RDS"
}

# ECR Configuration
variable "ecr_front_repo" {
  type        = string
  default     = "bookstore-frontend"
  description = "Nombre del repositorio ECR para frontend"
}

variable "ecr_back_repo" {
  type        = string
  default     = "bookstore-backend"
  description = "Nombre del repositorio ECR para backend"
}

# ECS Configuration
variable "container_cpu" {
  type        = number
  default     = 256
  description = "CPU units para contenedores (256 = 0.25 vCPU)"
}

variable "container_memory" {
  type        = number
  default     = 512
  description = "Memoria en MB para contenedores"
}

variable "backend_port" {
  type        = number
  default     = 3000
  description = "Puerto del backend"
}

variable "frontend_port" {
  type        = number
  default     = 80
  description = "Puerto del frontend"
}

variable "desired_count_backend" {
  type        = number
  default     = 2
  description = "Número deseado de tareas backend"
}

variable "desired_count_frontend" {
  type        = number
  default     = 2
  description = "Número deseado de tareas frontend"
}
