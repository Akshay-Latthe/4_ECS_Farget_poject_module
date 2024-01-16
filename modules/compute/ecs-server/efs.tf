# locals {
#   public_subnet_ids = [for subnet in aws_subnet.public_subnet : subnet.id]
# }
# locals {
#   privet_subnet_ids = [for subnet in aws_subnet.privet_subnet : subnet.id]
# }

data "aws_kms_key" "efs" {
  key_id = "alias/aws/elasticfilesystem"
}
## ================================================EFS  ========================================================
resource "aws_efs_file_system" "wordpress_efs" {
  creation_token   = var.creation_token #"wordpress-efs" # A unique name for the EFS file system
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  kms_key_id       = data.aws_kms_key.efs.arn
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name = var.efs_name
  }
}
resource "aws_efs_backup_policy" "efs_backup_policy" {
  file_system_id = aws_efs_file_system.wordpress_efs.id

  backup_policy {
    status = "ENABLED"
  }
}
# Mounting EFS to the EC2 instance
resource "aws_efs_mount_target" "efs-mt-A" {
  depends_on      = [aws_efs_file_system.wordpress_efs]
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = var.privet_subnets[0] #aws_subnet.privet_subnet[0].id
  security_groups = [var.efs-sg] #["${aws_security_group.efs-sg.id}"]
}

resource "aws_efs_mount_target" "efs-mt-B" {
  depends_on      = [aws_efs_file_system.wordpress_efs]
  file_system_id  = aws_efs_file_system.wordpress_efs.id
  subnet_id       = var.privet_subnets[1] #aws_subnet.privet_subnet[1].id
  security_groups = [var.efs-sg] #["${aws_security_group.efs-sg.id}"]
}

resource "aws_efs_access_point" "efs_access" {
  depends_on = [
    aws_efs_file_system.wordpress_efs,
  ]
  file_system_id = aws_efs_file_system.wordpress_efs.id
}


