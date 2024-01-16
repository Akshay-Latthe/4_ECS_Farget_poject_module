# ##ecs task defination ===================================================================
# region              = ""
# containername         = "wordpress_container"
# ecr_image             = "897708493501.dkr.ecr.us-east-1.amazonaws.com/wordpressapp"
# containerPath         = "/var/www/html/wp-content"
# cpuArchitecture       = "X86_64"
# operatingSystemFamily = "LINUX"
# #db_user           = "" {enter mysql rds user name through console as you wish }
# #db_password       = "" {enter password for mysql rds through console as you wish minimum length is 8 don't use special characters }
# image_repo_name           = "wordpress"
# fargate-task-service-role = "terraform-workshop-role"
# efs_name                  = "Wordpress-MyEFS"
# ecr_app_arn               = "wordpress:latest"
# cpu                       = "512"
# memory                    = "1024"