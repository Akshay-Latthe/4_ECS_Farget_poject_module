variable "region" {
  description = "Region in which the bastion host will be launched"
  default = "us-east-1"
}
variable "stack" {
  description = "Name of the stack."
  default     = "GameDay"
}
variable "ecr_image" {
  description = "ecr image link ."
}
variable "containername" {
  description = "Name of the contain."
}
variable "containerport" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}
variable "hostPort" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}
variable "containerPath" {
  description = "container files Path for the maping the efs"
}
variable "cpuArchitecture" {
  description = "faimly of cpu used for runnig container "
}
variable "operatingSystemFamily" {
  description = "operating System Family used for runnig container"
}
variable "family" {
  description = "Family of the Task Definition"
  default     = "wordpress"
}
variable "conatiner_port_alb" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

## aws_ecs_task_definition  =========================================
variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "wordpress:latest"
}
variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}
variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}
variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}
variable "cw_log_group" {
  description = "CloudWatch Log Group"
  default     = "GameDay"
}
variable "volumne_name" {
  description = "Define the EFS volumne name"
  default     = "wordpress-efs"
}
variable "task_count" {
  description = "Number of ECS tasks to run"
  default     = 1
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

## ================== IAM_Role ===========================================
variable "fargate-task-service-role" {
  description = "Name of the stack."
  // default     = "GameDay"
}
# Image repo name for ECR
variable "image_repo_name" {
  description = "Image repo name"
  type        = string
}
## ==================EFS & EFS MOUNT VERIABLES=============================================================
variable "efs_name" {
  description = "EFS strage name should be unique for the use"
  type        = string
}
variable "creation_token" {
  type = string
  default  = "wordpress-efs"
}
variable "monitoring" {
  description = "whether to enable ec2 detailed monitoring"
  type        = bool
  default     = true
}

variable "disable_api_termination" {
  description = "whether to disable api termination"
  type        = bool
  default     = false
}
# variable "privet_subnets" {
#   description = "List of RDS Subnet IDs"
#   type        = list(string)
# }
variable "privet_subnets" {}
variable "alb-sg" {}
variable "public_subnets" {}
variable "vpc_id" {}
variable "ssl_policy" {
  type = string
  default = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
} #
variable "min_capacity" {
  type = number
  default = 1
}  #1
variable "max_capacity" {
  type = number
  default = 6
}  # 6
variable "name_sacle_up" {
  type = string
  default = "cb_scale_up"
}  
variable "name_sacle_down" {
  type = string
  default = "cb_scale_down"
} 
variable "metric_name" {
  type = string
  default = "CPUUtilization"
}
variable "alarm_name_01" {
  type = string
  default = "cb_cpu_utilization_high"
}
variable "alarm_name_02" {
  type = string
  default = "cb_cpu_utilization_low"
}
variable "comparison_operator_01" {
  type = string
  default = "GreaterThanOrEqualToThreshold"
}
variable "comparison_operator_02" {
  type = string
  default = "LessThanOrEqualToThreshold"
}

variable "policy1_name" {
  type = string
  default = "ECR-Logs-Policy"
}
variable "policy2_name" {
  type = string
  default = "EFS-Policy"
}
variable "policy3_name" {
  type = string
  default = "Secrets-KMS-Policy"
}
variable "policy4_name" {
  type = string
  default = "SSM-Messages-Policy"
}
variable "ecs_task_role_name" {
  type = string
  default = "WordPress-ecs-task"
}
variable "efs-sg" {
  type = string
}
variable "secrets_manager_secret_arn" {
  
}
variable "WP-SG" {
  type = string
}



variable "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer (ALB)"
  # Define any other necessary attributes for the variable
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID"
  # Define any other necessary attributes for the variable
}
# variable "ssl_certificate_arn" {
#   type = string
# }

## =============================== ACM AND ROUTE 53 ===========================
variable "web_domain_name" {
  type = string
}
variable "domain_name" {
  description = "hosted zone domin name"
  default     = "dev.devopsinabox.aaic.cc"
  type        = string
}
variable "hosted_zone_id" {
  description = "The name of the hosted zone in which to register this site"
  type        = string
}

variable "website-additional-domains" {
  type        = string
  description = "extra domain name"
  default     = "www.wordpress.dev.devopsinabox.aaic.cc"

}

