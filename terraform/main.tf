module "api_gateway" {
  source = "./modules/api-gateway"

  name = var.name
  
  lambda_function_name = module.lambda.lambda_function_name
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
}

module "cloudfront" {
  source = "./modules/cloudfront"

  name                        = var.name
  s3_bucket_domain_name      = module.s3.s3_bucket_domain_name
  domain_name                = var.domain_name
  price_class                = var.price_class
  geo_whitelist  = var.geo_whitelist
  certificate_arn            = module.route53.certificate_arn
  certificate_validation_arn = module.route53.certificate_validation_arn
  api_gateway_url            = module.api_gateway.api_gateway_url
  api_gateway_stage_name     = module.api_gateway.api_gateway_stage_name
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

    domain_name          = var.domain_name
    validation_method    = var.validation_method
    dns_ttl              = var.dns_ttl

    cloudfront_domain_name     = module.cloudfront.cloudfront_domain_name
    cloudfront_hosted_zone_id  = module.cloudfront.cloudfront_hosted_zone_id
    cloudfront_aliases         = module.cloudfront.cloudfront_aliases
}

module "s3" {
  source = "./modules/s3"

  name                        = var.name
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
}
