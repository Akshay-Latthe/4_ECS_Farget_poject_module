

output "alb-sg" {
  value = aws_security_group.alb-sg.id
}

output "WP-SG" {
  value = aws_security_group.WP-SG.id
}

output "efs-sg" {
  value = aws_security_group.efs-sg.id
}

output "db-sg" {
  value = aws_security_group.db-sg.id
}
output "redis_sg" {
  value = aws_security_group.redis_sg.id
}