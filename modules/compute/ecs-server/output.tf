output "alb_dns_name" {
  value = aws_lb.wordpress-alb.dns_name
}

# output "image_repo_arn" {
#   value = aws_ecr_repository.image_repo.arn
# }
# output "image_repo_url" {
#   value = aws_ecr_repository.image_repo.repository_url
# }

output "efs_id" {
  value = aws_efs_file_system.wordpress_efs.id
}

output "efs_file_system_id" {
  value = data.aws_efs_file_system.efs_file_system.file_system_id
}

output "alb_zone_id" {
  value = aws_lb.wordpress-alb.zone_id  # Replace with the correct resource attribute
}

# output "route53_zone_id" {
#   value = data.aws_route53_zone.zone.id
# }


output "alb_id" {
  value = aws_lb.wordpress-alb.id
}

output "alb_security_group_id" {
  value = var.alb-sg
}

output "alb_target_group_id" {
  value = aws_lb_target_group.my-target-group.id
}

output "alb_listener_details" {
  value = {
    port = aws_lb_listener.alb-htts-listner.port
    protocol = aws_lb_listener.alb-htts-listner.protocol
  }
}

output "appautoscaling_target_resource_id" {
  value = aws_appautoscaling_target.target.resource_id
}

output "appautoscaling_policy_up_arn" {
  value = aws_appautoscaling_policy.up.arn
}

output "appautoscaling_policy_down_arn" {
  value = aws_appautoscaling_policy.down.arn
}

output "cloudwatch_alarm_high_arn" {
  value = aws_cloudwatch_metric_alarm.service_cpu_high.arn
}

output "cloudwatch_alarm_low_arn" {
  value = aws_cloudwatch_metric_alarm.service_cpu_low.arn
}

output "efs_backup_policy_status" {
  value = aws_efs_backup_policy.efs_backup_policy.backup_policy[0].status
}

output "efs_mount_target_A_id" {
  value = aws_efs_mount_target.efs-mt-A.id
}

output "efs_mount_target_B_id" {
  value = aws_efs_mount_target.efs-mt-B.id
}

output "efs_access_point_id" {
  value = aws_efs_access_point.efs_access.id
}


output "ecs_cluster_id" {
  value = aws_ecs_cluster.ecs-cluster.id
}

output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.petclinic-cw-lgrp.name
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.aws_wordpress.arn
}

output "ecs_service_id" {
  value = aws_ecs_service.service.id
}


output "ssl_certificate_arn" {
  value = aws_acm_certificate.ssl_certificate.arn
}

output "route53_record_fqdn" {
  value = aws_route53_record.s3_alias.fqdn
}
