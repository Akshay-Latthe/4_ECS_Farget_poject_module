## VPC , subnetS , ELASTIC IP , NATGETWAY , PROVIDER  ====================================

variable "project" {
  description = "Project or organisation name"
  type        = string
}

variable "env" {
  type        = string
  description = "current enviroment pod, dev etc.."
  default = "dev"
}

variable "region" {
  description = "Region in which the bastion host will be launched"
}

variable "public_cidrs" {
  type        = list(any)
  description = "CIDR block for Public subnet"
}
variable "privet_cidrs" {
  type        = list(any)
  description = "CIDR block for Privet subnet"
}
variable "rds_cidrs" {
  type        = list(any)
  description = "CIDR block for RDS subnet"
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
