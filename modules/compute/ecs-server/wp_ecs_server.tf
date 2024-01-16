# # ---------------------------------------------------------------------------------------------------------------------
# # ECS CLUSTER
# # ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.stack}-Cluster"
}
# ---------------------------------------------------------------------------------------------------------------------
# CLOUDWATCH LOG GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "petclinic-cw-lgrp" {
  name = var.cw_log_group
}
# ---------------------------------------------------------------------------------------------------------------------
# ECS Task Definition
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ecs_task_definition" "aws_wordpress" {
  depends_on               = [aws_cloudwatch_log_group.petclinic-cw-lgrp, aws_efs_file_system.wordpress_efs , var.secrets_manager_secret_arn]
  family                   = "service-aws-wp-02"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu    # Specify the CPU units
  memory                   = var.memory # Specify the memory in MB
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = var.containername
      image = var.ecr_image
      portMappings = [
        {
          name          = "wordpress_container-80-tcp"
          containerPort = var.containerport
          hostPort      = var.hostPort
          protocol      = "tcp"
        }
      ]

      essential   = true
      entryPoint  = []
      command     = []
      environment = []
      secrets = [
        {
          name      = "PORT"
          valueFrom = "${var.secrets_manager_secret_arn}:PORT::"
        },
        {
          name      = "WORDPRESS_DB_HOST"
          valueFrom = "${var.secrets_manager_secret_arn}:WORDPRESS_DB_HOST::"
        },
        {
          name      = "WORDPRESS_DB_NAME"
          valueFrom = "${var.secrets_manager_secret_arn}:WORDPRESS_DB_NAME::"
        },
        {
          name      = "WORDPRESS_DB_PASSWORD"
          valueFrom = "${var.secrets_manager_secret_arn}:WORDPRESS_DB_PASSWORD::"
        },
        {
          name      = "WORDPRESS_DB_USER"
          valueFrom = "${var.secrets_manager_secret_arn}:WORDPRESS_DB_USER::"
        }
      ]
      mountPoints = [
        {
          sourceVolume  = "EFS-DEMO"
          containerPath = var.containerPath
          readOnly      = false
        }
      ]

      volumesfrom = []

      logconfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = var.region
          awslogs-group         = var.cw_log_group
          awslogs-stream-prefix = "ecs"
        }
        secret_options = []
      }
      runtimePlatform = {
        cpuArchitecture       = var.cpuArchitecture
        operatingSystemFamily = var.operatingSystemFamily
      }
    }
  ])

  volume {
    name = "EFS-DEMO"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.wordpress_efs.id
      root_directory = "/"
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS SERVICE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ecs_service" "service" {
  name            = "${var.stack}-Service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.aws_wordpress.arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [var.WP-SG] #[aws_security_group.WP-SG.id]
    subnets         = var.privet_subnets[*] #aws_subnet.privet_subnet[*].id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my-target-group.arn
    container_name   = var.containername 
    container_port   = var.conatiner_port_alb
  }

  depends_on = [
    aws_lb_listener.alb-htts-listner,
  ]
}




