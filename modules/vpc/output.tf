output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "vpc_project" {
  value = aws_vpc.vpc.tags["project"]
}
output "project" {
  value = var.project
}
output "region" {
  value = data.aws_region.current.name
}
output "vpc_env" {
  value = aws_vpc.vpc.tags["env"]
}
output "availability_zones" {
  value = aws_subnet.public_subnet[*].availability_zone
}
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
output "public_subnets" {
  value = aws_subnet.public_subnet[*].id
}
output "privet_subnets" {
  value = aws_subnet.privet_subnet[*].id
}

output "rds_subnets" {
  value = aws_subnet.rds_subnet[*].id
}