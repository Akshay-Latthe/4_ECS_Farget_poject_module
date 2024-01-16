## VPC , SUBNETS , ELASTIC IP , NATGETWAY , PROVIDER  ====================================

variable "project" {}
variable "env" {}
variable "region" {}

variable "public_cidrs" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}
variable "privet_cidrs" {
  type        = list(any)
  description = "CIDR block for Privet Subnet"
}
variable "rds_cidrs" {
  type        = list(any)
  description = "CIDR block for RDS Subnet"
}
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC "
}
variable "availability_zones" {
  type        = list(string)
  description = "AZ in which all the resources will be deployed"
}

variable "public_subnet_count" {
  type = number
}
variable "rds_subnet_count" {
  type = number
}
variable "privet_subnet_count" {
  type = number
}

variable "db_instance_class" {}
variable "db_name" {}
variable "db_user" {}
variable "db_password" {}
variable "subnet_group_name" {}
variable "engine" {}
variable "engine_version" {}
variable "parameter_group_name" {}
# variable "alb-sg" {}
# variable "privet_subnets" {}
variable "ecr_image" {
  description = "ecr image link ."
}
variable "containername" {
  description = "Name of the contain."
  type = string
}
variable "operatingSystemFamily" {
  description = "operating System Family used for runnig container"
}
variable "image_repo_name" {
  description = "Image repo name"
  type        = string
}
variable "fargate-task-service-role" {
  description = "Name of the stack."
  // default     = "GameDay"
}
variable "efs_name" {
  description = "EFS strage name should be unique for the use"
  type        = string
}
variable "ecr_app_arn" {
  description = "ecr application arn"
  type        = string
}
variable "cpu" {
  description = "Number of CPU units for the task"
  type        = number
}
variable "memory" {
  description = "Number of CPU units for the task"
  type        = number
}
variable "containerPath" {
  description = "container files Path for the maping the efs"
}
variable "cpuArchitecture" {
  description = "faimly of cpu used for runnig container "
}

variable "web_domain_name" {}
variable "alb_dns_name" {}
variable "route53_zone_id" {}
variable "hosted_zone_id" {}