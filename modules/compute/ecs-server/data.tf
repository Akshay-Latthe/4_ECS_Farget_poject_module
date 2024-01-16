data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "aws_efs_file_system" "efs_file_system" {
  file_system_id = aws_efs_file_system.wordpress_efs.id
}

