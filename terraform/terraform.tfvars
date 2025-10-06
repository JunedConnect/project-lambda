# General
name   = "prod"
aws_tags = {
  Environment = "prod"
  Owner       = "juned"
  Terraform   = "true"
}

# CloudFront
s3_origin_id                  = "myS3Origin"
domain_aliases                = ["test"]
price_class                   = "PriceClass_200"
geo_restriction_locations     = ["US", "CA", "GB", "DE"]

# Lambda
function_name = "my-function"

dynamodb_table_name      = "url-prod"
dynamodb_billing_mode    = "PAY_PER_REQUEST"
dynamodb_pitr_enabled    = true
dynamodb_hash_key_name   = "id"
dynamodb_attribute_name  = "id"
dynamodb_attribute_type  = "S"
dynamodb_ttl_attribute_name = "ttl"
dynamodb_ttl_enabled = true


# Route53
domain_name                     = "prod.juned.co.uk"
validation_method               = "DNS"
dns_ttl                         = 60

# S3
s3_version_expiration_days     = 30