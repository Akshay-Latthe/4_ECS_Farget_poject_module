# provider "aws" {
#   region = var.region
#   default_tags {
#     tags = {
#       Project     = var.project
#       Environment = var.env
#       ManagedBy   = "Terraform"
#     }
#   }
# }
# terraform {
#     backend "s3" {
#     bucket =  "aws-wp-demo415"
#     dynamodb_table = "state-lock"
#     key            = "global/mystatefile/vpc_newtworking/terraform.tfstate" 
#     region         = "us-east-1"
#     encrypt        = true
#   } 
#   required_providers {

#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }
