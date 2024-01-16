
# ---------------------------------------------------------------------------------------------------------------------
# RDS DB SUBNET GROUP
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_db_subnet_group" "db-subnet-grp" {
  depends_on  = [var.rds_subnets]
  name        = var.subnet_group_name
  description = "Database Subnet Group"
  subnet_ids  = var.rds_subnets
}

# ---------------------------------------------------------------------------------------------------------------------
# RDS (MYSQL)
# -----------------------------------------------------------c:\Users\akshay\Desktop\aws-ecs-cicd-terraform-master\terraform\iam-fargate.tf----------------------------------------------------------

resource "aws_db_instance" "db" {
  depends_on = [var.db-sg] 
  identifier             = "wp-rds-mysql"
  allocated_storage      = 20
  engine                 = var.engine
  engine_version         = var.engine_version
  port                   = var.db_port
  instance_class         = var.db_instance_class
  db_name = var.db_name
  username               = var.db_user
  password               = var.db_password
  availability_zone      = var.availability_zone[1]
  vpc_security_group_ids = [var.db-sg]
  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-grp.id
  parameter_group_name   = var.parameter_group_name
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Stack = var.stack
    Name = var.db_name 
  }
}


## =================== secret_manager ====================================
data "aws_db_instance" "existing_db" {
  # Specify the identifier of your existing RDS instance
  db_instance_identifier = aws_db_instance.db.arn
}
# Use the retrieved values in the Secrets Manager secret creation
resource "aws_secretsmanager_secret" "secrets" {
  depends_on              = [aws_db_instance.db]
  name                    = format("%v-%v-wordpress-secret-01", var.project, var.env) # Choose a name for your secret
  description             = "My new RDS secret"
  recovery_window_in_days = 0  ## "{{Replace with  as per your reqirmrnt for rds secret}}"
}

resource "aws_secretsmanager_secret_version" "secrets_version" {

  secret_id = aws_secretsmanager_secret.secrets.id
  secret_string = jsonencode({
    "PORT" : data.aws_db_instance.existing_db.port,                  # Replace with the actual port value
    "WORDPRESS_DB_HOST" : data.aws_db_instance.existing_db.endpoint, # Replace with the actual host value
    "WORDPRESS_DB_NAME" : data.aws_db_instance.existing_db.db_name,  # Replace with the actual DB name
    "WORDPRESS_DB_PASSWORD" : var.db_password,                       # Replace with the actual password
    "WORDPRESS_DB_USER" : var.db_user,                               # Replace with the actual DB user
  })
}

data "aws_secretsmanager_secret" "my_secrets" {
  name = aws_secretsmanager_secret.secrets.name
}



