# DB Subnet Group
resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-db-subnet"
  subnet_ids = local.private_subnet_ids
  tags       = local.common_tags
}

# RDS PostgreSQL
resource "aws_db_instance" "postgres" {
  identifier     = "${var.project}-db"
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = var.rds_instance_class

  allocated_storage = var.rds_allocated_storage
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false

  backup_retention_period = 7
  skip_final_snapshot     = true

  tags = local.common_tags
}
