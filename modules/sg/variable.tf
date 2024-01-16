variable "region" {
  description = "Region in which the bastion host will be launched"
  default = "us-east-1"
}
variable "stack" {
  description = "Name of the stack."
  default     = "GameDay"
}
variable "vpc_cidr" {
  description = "CIDR block of the VPC"
}
variable "vpc_id" {}
