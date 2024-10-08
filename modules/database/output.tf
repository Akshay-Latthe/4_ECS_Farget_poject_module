output "rds_endpoint" {
  value = aws_db_instance.db.endpoint
}
output "db_host" {
  value = aws_db_instance.db.address
}
output "db_port" {
  value = aws_db_instance.db.port
}
output "db_url" {
  value = "jdbc:mysql://${aws_db_instance.db.address}/${var.db_name}"
}
output "secret_version_arn" {
  value = aws_secretsmanager_secret_version.secrets_version.arn
}

