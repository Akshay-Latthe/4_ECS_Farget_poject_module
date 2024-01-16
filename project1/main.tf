# provider "aws" {
#   region = var.region
#   default_tags {
#     tags = {
#       ManagedBy   = "Terraform"
#     }
#   }
# }


# terraform {
#   backend "s3" {
#     bucket         = "wordpress-demo-app"
#     dynamodb_table = "starte-lock-wordpress-demo-app"
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


module "vpc" {
  source              = "../modules/vpc"
  project             = var.project
  env                 = var.env
  region              = var.region
  availability_zones  = var.availability_zones
  vpc_cidr            = var.vpc_cidr
  public_cidrs        = var.public_cidrs
  privet_cidrs        = var.privet_cidrs
  rds_cidrs           = var.rds_cidrs
  public_subnet_count = var.public_subnet_count
  privet_subnet_count = var.privet_subnet_count
  rds_subnet_count    = var.rds_subnet_count
}

module "sg" {
  source   = "../modules/sg"
  vpc_cidr = module.vpc.vpc_cidr
  vpc_id   = module.vpc.vpc_id
}

module "database" {
  source               = "../modules/database"
  region               = module.vpc.region
  env                  = module.vpc.vpc_env
  availability_zone    = module.vpc.availability_zones
  rds_subnets          = module.vpc.rds_subnets
  db-sg                = module.sg.db-sg
  redis_sg             = module.sg.redis_sg
  project              = module.vpc.vpc_project

  db_instance_class    = var.db_instance_class
  db_name              = var.db_name
  db_user              = var.db_user     #{enter mysql rds user name through console as you wish }
  db_password          = var.db_password #{enter password for mysql rds through console as you wish minimum length is 8 don't use special characters }
  subnet_group_name    = var.subnet_group_name
  engine               = var.engine
  engine_version       = var.engine_version
  parameter_group_name = var.parameter_group_name
}


module "comput_ecs_server" {
  source                     = "../modules/compute/ecs-server"
  vpc_id                     = module.vpc.vpc_id
  region                     = module.vpc.region
  alb-sg                     = module.sg.alb-sg
  efs-sg                     = module.sg.efs-sg
  WP-SG                      = module.sg.WP-SG
  privet_subnets             = module.vpc.privet_subnets
  containername              = var.containername
  ecr_image                  = var.ecr_image
  containerPath              = var.containerPath
  cpuArchitecture            = var.cpuArchitecture
  operatingSystemFamily      = var.operatingSystemFamily
  image_repo_name            = var.image_repo_name
  fargate-task-service-role  = var.fargate-task-service-role
  efs_name                   = var.efs_name
  ecr_app_arn                = var.ecr_app_arn
  cpu                        = var.cpu
  memory                     = var.memory
  web_domain_name            = var.web_domain_name
  alb_dns_name               = var.alb_dns_name
  route53_zone_id            = var.route53_zone_id
  secrets_manager_secret_arn = module.database.secret_version_arn
  public_subnets = module.vpc.public_subnets
  hosted_zone_id  = var.hosted_zone_id
}


# module "acm_route53" {
#   source          = "../modules/acm_route53"
  
# }



# variable "db_user" {
#   description = "db user name pssed by user"
# }
# variable "db_password" {
#   description = "db password also been pased by user"
# }



# output "all_outputs" {
#   value = {

#     vpc_id = module.vpc.vpc_id
#     vpc_project = module.vpc.vpc_project
#     project = module.vpc.project
#     region = module.vpc.region
#     vpc_env = module.vpc.vpc_env
#     availability_zones = module.vpc.availability_zones
#     vpc_cidr = module.vpc.vpc_cidr
#     public_subnets = module.vpc.public_subnets
#     privet_subnets = module.vpc.privet_subnets
#     rds_subnets = module.vpc.rds_subnets

#     alb-sg = module.sg.alb-sg
#     WP-SG = module.sg.WP-SG
#     efs-sg = module.sg.efs-sg
#     db-sg = module.sg.db-sg

#     redis_sg = module.sg.redis_sg
#     rds_endpoint = module.database.rds_endpoint
#     db_host = module.database.db_host
#     db_port = module.database.db_port
#     db_url = module.database.db_url
#     secret_version_arn =  module.database.secret_version_arn

#     alb_dns_name                   = module.comput_ecs_server.alb_dns_name
#     efs_id                         = module.comput_ecs_server.efs_id
#     efs_file_system_id             = module.comput_ecs_server.efs_file_system_id
#     alb_zone_id                    = module.comput_ecs_server.alb_zone_id
#     alb_id                         = module.comput_ecs_server.alb_id
#     alb_security_group_id          = module.comput_ecs_server.alb_security_group_id
#     alb_target_group_id            = module.comput_ecs_server.alb_target_group_id
#     alb_listener_details           = module.comput_ecs_server.alb_listener_details
#     appautoscaling_target_resource_id = module.comput_ecs_server.appautoscaling_target_resource_id
#     appautoscaling_policy_up_arn   = module.comput_ecs_server.appautoscaling_policy_up_arn
#     appautoscaling_policy_down_arn = module.comput_ecs_server.appautoscaling_policy_down_arn
#     cloudwatch_alarm_high_arn      = module.comput_ecs_server.cloudwatch_alarm_high_arn
#     cloudwatch_alarm_low_arn       = module.comput_ecs_server.cloudwatch_alarm_low_arn
#     efs_backup_policy_status       = module.comput_ecs_server.efs_backup_policy_status
#     efs_mount_target_A_id          = module.comput_ecs_server.efs_mount_target_A_id
#     efs_mount_target_B_id          = module.comput_ecs_server.efs_mount_target_B_id
#     efs_access_point_id            = module.comput_ecs_server.efs_access_point_id
#     ecs_cluster_id                 = module.comput_ecs_server.ecs_cluster_id
#     cloudwatch_log_group_name      = module.comput_ecs_server.cloudwatch_log_group_name
#     ecs_task_definition_arn        = module.comput_ecs_server.ecs_task_definition_arn
#     ecs_service_id                 = module.comput_ecs_server.ecs_service_id
#   }
# }




