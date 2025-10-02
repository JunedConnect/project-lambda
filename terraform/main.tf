module "alb" {
    source = "./modules/alb"
    security_group_id = module.vpc.security_group_id
    certificate_arn = module.route53.certificate_arn
    public_subnet_ids = module.vpc.public_subnet_ids

    name                         = var.name
    alb_internal                 = var.alb_internal
    alb_load_balancer_type       = var.alb_load_balancer_type
    listener_port_http           = var.listener_port_http
    listener_protocol_http       = var.listener_protocol_http
    listener_port_https          = var.listener_port_https
    listener_protocol_https      = var.listener_protocol_https

    vpc_id = module.vpc.vpc_id

    target_group_name              = var.target_group_name
    target_group_port              = var.target_group_port
    target_group_health_check_path = var.target_group_health_check_path
    target_group_protocol          = var.target_group_protocol
    target_group_target_type       = var.target_group_target_type
}

module "api_gateway" {
  source = "./modules/api-gateway"

  name = var.name

  lambda_function_name = module.lambda.lambda_function_name
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
}

module "lambda" {
  source = "./modules/lambda"

  name = var.name

  dynamodb_table_name        = var.dynamodb_table_name
  dynamodb_hash_key_name     = var.dynamodb_hash_key_name
  dynamodb_attribute_name    = var.dynamodb_attribute_name
  dynamodb_attribute_type    = var.dynamodb_attribute_type
  dynamodb_billing_mode      = var.dynamodb_billing_mode
  dynamodb_pitr_enabled      = var.dynamodb_pitr_enabled
  dynamodb_ttl_attribute_name = var.dynamodb_ttl_attribute_name
  dynamodb_ttl_enabled       = var.dynamodb_ttl_enabled

  function_name = var.function_name
}

module "route53" {
    source = "./modules/route53"
    alb_dns_name = module.alb.alb_dns_name
    alb_zone_id = module.alb.alb_zone_id

    domain_name          = var.domain_name
    validation_method    = var.validation_method
    dns_ttl              = var.dns_ttl
}

module "s3" {
  source = "./modules/s3"

  name                        = var.name
  s3_version_expiration_days  = var.s3_version_expiration_days
}
module "vpc" {
  source = "./modules/vpc"

  name                           = var.name
  vpc_cidr_block                 = var.vpc_cidr_block
  publicsubnet1_cidr_block       = var.publicsubnet1_cidr_block
  publicsubnet2_cidr_block       = var.publicsubnet2_cidr_block
  privatesubnet1_cidr_block      = var.privatesubnet1_cidr_block
  privatesubnet2_cidr_block      = var.privatesubnet2_cidr_block
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  subnet_map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  availability_zone_1            = var.availability_zone_1
  availability_zone_2            = var.availability_zone_2
  route_cidr_block               = var.route_cidr_block
}