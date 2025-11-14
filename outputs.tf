# ALB
output "alb_dns" {
  description = "DNS del Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "alb_url" {
  description = "URL de la aplicación"
  value       = "http://${aws_lb.alb.dns_name}"
}

# ECR
output "ecr_backend_url" {
  description = "URL del repositorio ECR backend"
  value       = aws_ecr_repository.backend.repository_url
}

output "ecr_frontend_url" {
  description = "URL del repositorio ECR frontend"
  value       = aws_ecr_repository.frontend.repository_url
}

# ECS
output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = aws_ecs_cluster.this.name
}

# RDS
output "rds_endpoint" {
  description = "Endpoint de RDS"
  value       = aws_db_instance.postgres.endpoint
  sensitive   = true
}

# Comandos útiles
output "ecr_login_command" {
  description = "Comando para login a ECR"
  value       = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${split("/", aws_ecr_repository.backend.repository_url)[0]}"
}
