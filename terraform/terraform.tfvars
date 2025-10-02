# General
name   = "prod"
aws_tags = {
  Environment = "prod"
  Owner       = "juned"
  Terraform   = "true"
}

# ALB
alb_internal                    = false
alb_load_balancer_type          = "application"
listener_port_http              = "80"
listener_protocol_http          = "HTTP"
listener_port_https             = "443"
listener_protocol_https         = "HTTPS"

target_group_name          = "this"
target_group_port          = 8080
target_group_health_check_path = "/"
target_group_protocol           = "HTTP"
target_group_target_type        = "ip"

# DynamoDB
dynamodb_table_name      = "url-prod"
dynamodb_billing_mode    = "PAY_PER_REQUEST"
dynamodb_pitr_enabled    = true
dynamodb_hash_key_name   = "id"
dynamodb_attribute_name  = "id"
dynamodb_attribute_type  = "S"
dynamodb_ttl_attribute_name = "ttl"
dynamodb_ttl_enabled = true

function_name = "my-function"

# Route53
domain_name                     = "prod.juned.co.uk"
validation_method               = "DNS"
dns_ttl                         = 60

# VPC
vpc_cidr_block                 = "10.2.0.0/16"
publicsubnet1_cidr_block       = "10.2.1.0/24"
publicsubnet2_cidr_block       = "10.2.2.0/24"
privatesubnet1_cidr_block      = "10.2.3.0/24"
privatesubnet2_cidr_block      = "10.2.4.0/24"
enable_dns_support             = true
enable_dns_hostnames           = true
subnet_map_public_ip_on_launch = true
availability_zone_1            = "eu-west-2a"
availability_zone_2            = "eu-west-2b"
route_cidr_block               = "0.0.0.0/0"