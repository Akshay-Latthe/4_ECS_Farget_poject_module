resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  depends_on = [ var.rds_subnets ]
  name       = "redis-subnet-group"
  subnet_ids = var.rds_subnets
}

resource "aws_elasticache_replication_group" "instance" {
  count                         = 1
  node_type                     = "cache.t4g.micro"
  port                          = 6379
  parameter_group_name          = "default.redis7.cluster.on"
  replication_group_id          = "test"
  description = "Redis cluster for Hashicorp ElastiCache WORDPRESS"
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids            = [var.redis_sg]
  at_rest_encryption_enabled    = true
  multi_az_enabled              = true
  automatic_failover_enabled    = true
  apply_immediately             = true
  replicas_per_node_group = 1
  num_node_groups         = 1  
}

locals {
  port  = 6379
}