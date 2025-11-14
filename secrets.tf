# Secret para DB Password
resource "aws_secretsmanager_secret" "db_password" {
  name                    = "${var.project}/db_password"
  recovery_window_in_days = 7
  tags                    = local.common_tags
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
  
  secret_string = jsonencode({
    password = var.db_password
    username = var.db_username
    host     = aws_db_instance.postgres.address
    port     = aws_db_instance.postgres.port
    dbname   = var.db_name
  })
}
