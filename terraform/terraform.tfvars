# General
name   = "live"
aws_tags = {
  Environment = "prod"
  Owner       = "juned"
  Terraform   = "true"
}

# CloudFront
price_class                   = "PriceClass_200"
geo_whitelist     = ["US", "CA", "GB", "DE"]

# Lambda
function_name = "my-function"

# API Gateway

dynamodb_table_name      = "url-prod"
dynamodb_billing_mode    = "PAY_PER_REQUEST"
dynamodb_pitr_enabled    = true
dynamodb_hash_key_name   = "id"
dynamodb_attribute_name  = "id"
dynamodb_attribute_type  = "S"
dynamodb_ttl_attribute_name = "ttl"
dynamodb_ttl_enabled = true # this currently has no effect because the TTL is not being set in the Lambda function


# Route53
domain_name                     = "prod.juned.co.uk"
validation_method               = "DNS"
dns_ttl                         = 60