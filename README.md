# 📦 Infraestructura BookStore - Terraform on AWS

Este repositorio contiene el código IaC para desplegar la aplicación **BookStore**, compuesta por un frontend en **React** y un backend en **Node.js**, en **AWS ECS Fargate**, aplicando buenas prácticas DevOps de versionamiento, despliegue automatizado y observabilidad.

---

## 🧱 Arquitectura

La infraestructura desplegada incluye:

- VPC con subredes públicas y privadas  
- ECS Fargate para ejecutar contenedores sin administrar servidores  
- ECR (Elastic Container Registry) para almacenar las imágenes Docker del front y back  
- Application Load Balancer (ALB) para distribuir tráfico hacia los servicios ECS  
- RDS (PostgreSQL) para persistencia de datos  
- AWS Secrets Manager para manejo seguro de contraseñas y credenciales  
- CloudWatch Logs y Alarms para monitoreo y alertas  
- Roles IAM con privilegios mínimos para ECS y tareas  

---

## 🧩 Estructura del repositorio

```bash
infra/
├─ backend.tf               # Configuración del backend remoto (S3 + DynamoDB)
├─ providers.tf             # Proveedor AWS
├─ variables.tf             # Variables principales
├─ outputs.tf               # Salidas del despliegue
├─ vpc.tf                   # Red y subredes
├─ ecr.tf                   # Repositorios de imágenes
├─ iam.tf                   # Roles y permisos mínimos
├─ ecs-cluster-service.tf   # Definición del cluster, servicios y tareas
├─ alb.tf                   # Load Balancer y Target Groups
├─ rds.tf                   # Base de datos PostgreSQL
├─ secrets.tf               # Gestión de secretos
└─ cloudwatch.tf            # Métricas y alarmas


## 🚀 Flujo de despliegue

### 1. Infraestructura (Terraform)

Se ejecuta manualmente o mediante un pipeline de IaC:
```bash
terraform init
terraform plan
terraform apply


Esto crea toda la infraestructura base (**VPC, ECS, ECR, ALB, RDS, etc.**).

### 2. Aplicación (CI/CD Pipeline en Azure DevOps)

Cada desarrollador hace **push** del código actualizado (front o back). El pipeline ejecuta automáticamente:
- Build & Test del código (`npm run build`)
- Linting y Scanning (**Hadolint, Trivy**)
- Build de imagen Docker
- Push a ECR con una etiqueta versionada (`v1.0.${BUILD_ID}`)
- Actualización del servicio ECS reemplazando el tag en el `taskdef.json`:

aws ecs register-task-definition --cli-input-json file://taskdef.json
aws ecs update-service --cluster bookstore-cluster --service bookstore-backend-svc --force-new-deployment


*(Esto se hace con un script de shell o un paso “AWS CLI” en el pipeline).*

## 🧠 Buenas prácticas aplicadas

- Backend remoto (**S3 + DynamoDB**) para control de estado y locking
- Separación de entornos (usa workspaces **dev, staging, prod**)
- Manejo seguro de secretos con **AWS Secrets Manager**
- Principio de privilegio mínimo en roles **IAM**
- Versionamiento de imágenes en **ECR** para trazabilidad y rollback
- Alerta temprana con **CloudWatch Alarms** sobre errores 5XX en el ALB
- IaC 100% declarativo y reproducible

## 🛠️ Requisitos previos

- Terraform >= 1.2.0
- AWS CLI configurado
- Permisos de IAM para crear los recursos
- Bucket S3 y tabla DynamoDB existentes para backend remoto
- Azure DevOps con acceso a ECR (usando un **AWS Service Connection**)

## ⚙️ Variables principales

Edita `variables.tf` o pasa valores con `-var`:

| Variable                | Descripción              | Valor por defecto          |
|-------------------------|--------------------------|----------------------------|
| aws_region              | Región AWS               | us-east-1                  |
| project                 | Nombre del proyecto      | bookstore                  |
| vpc_cidr                | CIDR principal           | 10.0.0.0/16                |
| rds_instance_class      | Clase de instancia DB    | db.t3.micro                |
| db_password_secret_name | Nombre del secreto       | bookstore/db_password      |

## 📦 Outputs principales

Tras aplicar Terraform:

| Output          | Descripción                                |
|-----------------|--------------------------------------------|
| alb_dns         | DNS público del Load Balancer              |
| ecr_front_repo  | URL del repositorio ECR (frontend)         |
| ecr_back_repo   | URL del repositorio ECR (backend)          |
| ecs_cluster     | Nombre del cluster ECS creado              |



