## RULES USED FOR THE TERRAFROM CODE AS APER THE AWS PROVIEDER FOR TERRAFORM code (700 RULES AVAILABE FOR "aws")
# USEFUL DOCKS (https://spacelift.io/blog/what-is-tflint)
# AWS PROVIDER RULES ( https://github.com/terraform-linters/tflint-ruleset-aws/tree/master/docs/rules )
# https://dhaneshmadavil.wordpress.com/2021/10/29/how-to-use-tflint-to-check-errors-in-your-terraform-code/

# plugin for the tflint as per proviers aws, gcp, az
plugin "aws" {
    enabled = true
    version = "0.21.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
config {
  module = true
}

# WE ARE PASIING THE VERIABLES FOR IN THE tflint 
config {
  module = true
  force = false
  disabled_by_default = false
  varfile = ["terraform.tfvars"]   # .tfvars file as input
}

## RULES USED FOR THE TERRAFROM CODE AS APER THE AWS PROVIEDER FOR TERRAFORM code (700 RULES AVAILABE FOR "aws")
#RULES FOR TERRAFORM CODE .
# Rule to prevent the use of deprecated interpolation syntax
rule "terraform_deprecated_interpolation" {
  enabled = true
}

# Rule to prevent the use of legacy dot index syntax
rule "terraform_deprecated_index" {
  enabled = true
}

# Rule to detect unused declarations like variables, data sources, and locals
rule "terraform_unused_declarations" {
  enabled = true
}

# Rule to enforce a specific comment syntax
rule "terraform_comment_syntax" {
  enabled = false
}

# Rule to ensure outputs are documented
rule "terraform_documented_outputs" {
  enabled = true
}

# Rule to ensure variables are documented and have a type
rule "terraform_documented_variables" {
  enabled = true
}

# Rule to enforce types on variables
rule "terraform_typed_variables" {
  enabled = true
}

# Rule to ensure Terraform declarations have a required_version
rule "terraform_required_version" {
  enabled = true
}

# Rule to require version constraints for providers through required_providers
rule "terraform_required_providers" {
  enabled = true
}

# Rule to enforce Terraform Standard Module Structure
rule "terraform_standard_module_structure" {
  enabled = true
}

rule "aws_alb_invalid_security_group" {
    description = "Disallow using invalid security groups"
    enabled = true
}

rule "aws_alb_invalid_subnet" {
    description = "Disallow using invalid subnets"
    enabled = true
}

rule "aws_api_gateway_model_invalid_name" {
    description = "Disallow using invalid name"
    enabled = true
}

rule "aws_db_instance_invalid_db_subnet_group" {
    description = "Disallow using invalid subnet group name"
    enabled = true
}

rule "aws_db_instance_invalid_engine" {
    description = "Disallow using invalid engine name"
    enabled = true
}

rule "aws_db_instance_invalid_option_group" {
    description = "Disallow using invalid option group"
    enabled = true
}

rule "aws_db_instance_invalid_parameter_group" {
    description = "Disallow using invalid parameter group"
    enabled = true
}

rule "aws_db_instance_invalid_type" {
    description = "Disallow using invalid instance class"
    enabled = true
}

rule "aws_db_instance_invalid_vpc_security_group" {
    description = "Disallow using invalid VPC security groups"
    enabled = true
}

rule "aws_dynamodb_table_invalid_stream_view_type" {
    description = "Disallow using invalid stream view types for DynamoDB"
    enabled = true
}

rule "aws_elastic_beanstalk_environment_invalid_name_format" {
    description = "Disallow invalid environment name"
    enabled = true
}

rule "aws_elasticache_cluster_invalid_parameter_group" {
    description = "Disallow using invalid parameter group"
    enabled = true
}

rule "aws_elasticache_cluster_invalid_security_group" {
    description = "Disallow using invalid security groups"
    enabled = true
}

rule "aws_elasticache_cluster_invalid_subnet_group" {
    description = "Disallow using invalid subnet group"
    enabled = true
}

rule "aws_elasticache_cluster_invalid_type" {
    description = "Disallow using invalid node type"
    enabled = true
}

rule "aws_elasticache_replication_group_invalid_type" {
    description = "Disallow using invalid node type"
    enabled = true
}

rule "aws_elb_invalid_instance" {
    description = "Disallow using invalid instances"
    enabled = true
}

rule "aws_elb_invalid_security_group" {
    description = "Disallow using invalid security groups"
    enabled = true
}

rule "aws_elb_invalid_subnet" {
    description = "Disallow using invalid subnets"
    enabled = true
}

rule "aws_iam_group_policy_too_long" {
    description = "Disallow IAM group policies that are too long"
    enabled = true
}

rule "aws_iam_policy_sid_invalid_characters" {
    description = "Disallow invalid characters in an IAM policy's SID"
    enabled = true
}

rule "aws_iam_policy_too_long_policy" {
    description = "Disallow IAM group policies that are too long"
    enabled = true
}

rule "aws_instance_invalid_ami" {
    description = "Disallow using invalid AMI"
    enabled = true
}

rule "aws_instance_invalid_iam_profile" {
    description = "Disallow using invalid IAM profile"
    enabled = true
}

rule "aws_instance_invalid_key_name" {
    description = "Disallow using invalid key name"
    enabled = true
}

rule "aws_instance_invalid_subnet" {
    description = "Disallow using invalid subnet"
    enabled = true
}

rule "aws_instance_invalid_vpc_security_group" {
    description = "Disallow using invalid VPC security groups"
    enabled = true
}

rule "aws_launch_configuration_invalid_iam_profile" {
    description = "Disallow using invalid IAM profile"
    enabled = true
}

rule "aws_launch_configuration_invalid_image_id" {
    description = "Disallow using invalid image ID"
    enabled = true
}

rule "aws_mq_broker_invalid_engine_type" {
    description = "Disallow invalid engine type for MQ Broker"
    enabled = true
}

rule "aws_mq_configuration_invalid_engine_type" {
    description = "Disallow invalid engine type for MQ Configuration"
    enabled = true
}

rule "aws_route_invalid_egress_only_gateway" {
    description = "Disallow using invalid egress only gateway"
    enabled = true
}

rule "aws_route_invalid_gateway" {
    description = "Disallow using invalid gateway"
    enabled = true
}

rule "aws_route_invalid_instance" {
    description = "Disallow using invalid instance"
    enabled = true
}

rule "aws_route_invalid_nat_gateway" {
    description = "Disallow using invalid NAT gateway"
    enabled = true
}

rule "aws_route_invalid_network_interface" {
    description = "Disallow using invalid network interface"
    enabled = true
}

rule "aws_route_invalid_route_table" {
    description = "Disallow using invalid route table"
    enabled = true
}

rule "aws_route_invalid_vpc_peering_connection" {
    description = "Disallow using invalid VPC peering connection"
    enabled = true
}

rule "aws_route_not_specified_target" {
    description = "Disallow routes that have no targets"
    enabled = true
}

rule "aws_route_specified_multiple_targets" {
    description = "Disallow routes that have multiple targets"
    enabled = true
}

rule "aws_s3_bucket_invalid_acl" {
    description = "Disallow invalid ACL rule for S3 bucket"
    enabled = true
}

// rule "aws_s3_bucket_invalid_region" {
//     description = "Disallow invalid region for S3 bucket"
//     enabled = true
// }

rule "aws_spot_fleet_request_invalid_excess_capacity_termination_policy" {
    description = "Disallow invalid excess capacity termination policy"
    enabled = true
}

rule "aws_security_group_invalid_protocol" {
    description = "Disallow using invalid protocol"
    enabled = true
}

rule "aws_security_group_rule_invalid_protocol" {
    description = "Disallow using invalid protocol"
    enabled = true
}
