#General

variable "name" {
  description = "Resource Name"
  type        = string
  default     = "prod"
}

variable "aws_tags" {
  description = "Tags for Resources"
  type        = map(string)
  default = {
    Environment = "prod",
    Project     = "lambda",
    Owner       = "juned",
    Terraform   = "true"
  }
}


# CloudFront

variable "s3_origin_id" {
  description = "Origin ID for S3 bucket in CloudFront distribution"
  type        = string
  default     = "myS3Origin"
}

variable "domain_aliases" {
  description = "List of domain  aliases to append to the main domain name for CloudFront distribution"
  type        = list(string)
  default     = ["test"]
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_200"
}

variable "geo_restriction_locations" {
  description = "List of country codes for CloudFront geo restrictions"
  type        = list(string)
  default     = ["US", "CA", "GB", "DE"]
}


# Lambda

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "my-function"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "url-prod"
}

variable "dynamodb_hash_key_name" {
  description = "DynamoDB table hash key name"
  type        = string
  default     = "id"
}

variable "dynamodb_attribute_name" {
  description = "DynamoDB attribute name (for attribute block)"
  type        = string
  default     = "id"
}

variable "dynamodb_attribute_type" {
  description = "DynamoDB attribute type (S | N | B) for attribute block"
  type        = string
  default     = "S"
}

variable "dynamodb_billing_mode" {
  description = "DynamoDB billing mode (PAY_PER_REQUEST | PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_pitr_enabled" {
  description = "Enable point-in-time recovery (PITR)"
  type        = bool
  default     = true
}

variable "dynamodb_ttl_attribute_name" {
  description = "DynamoDB TTL attribute name"
  type        = string
  default     = "ttl"
}

variable "dynamodb_ttl_enabled" {
  description = "Enable DynamoDB TTL"
  type        = bool
  default     = true
}


# Route53

variable "domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
  default     = "prod.juned.co.uk"
}

variable "validation_method" {
  description = "The validation method for the ACM certificate"
  type        = string
  default     = "DNS"
}

variable "dns_ttl" {
  description = "Time to live (TTL) for DNS records"
  type        = number
  default     = 60
}


# S3

variable "s3_version_expiration_days" {
  description = "Number of days after which non-current versions of S3 objects are deleted"
  type        = number
  default     = 30
}