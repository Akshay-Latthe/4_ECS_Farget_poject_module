variable "region" {
  description = "Region in which the bastion host will be launched"
}
variable "project" {
  description = "Project or organisation name"
  type        = string
}
variable "env" {
  type        = string
  description = "current enviroment pod, dev etc.."
}
variable "stack" {
  description = "Name of the stack."
  default     = "GameDay"
}
## =============== MYSQL RDS =======================
variable "db_instance_class" {
  description = "EC2 database size/class as per the requirement"
  type        = string
}
variable "db_name" {
  description = "Database name is used for logging for wordpress"
  type        = string
}
variable "db_user" {
  description = "Database user name is used for logging for wordpress"
  type        = string
}
variable "db_password" {
  description = "Database  password is used for logging for wordpress"
  type        = string
}
variable "db_port" {
  description = "Database  port is used for logging for wordpress"
  type        = string
  default     = "3306"
}
variable "rds_subnets" {
  description = "List of RDS Subnet IDs"
  type        = list(string)
  # Add any other necessary configurations
}
variable "db-sg" {
  type = string
}
variable "redis_sg" {
  type = string
}
variable "availability_zone" {
  description = "List of RDS Subnet IDs"
  type        = list(string)
}
variable "subnet_group_name" {
  type = string
}
variable "engine" {
  type = string
}
variable "engine_version" {
  type = string
}
variable "parameter_group_name" {
  type = string
}