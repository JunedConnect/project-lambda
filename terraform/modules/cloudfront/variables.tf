variable "name" {
  description = "Name prefix for CloudFront resources"
  type        = string
}

variable "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  type        = string
}


variable "domain_name" {
  description = "Domain name for the CloudFront distribution"
  type        = string
}


variable "price_class" {
  description = "CloudFront price class"
  type        = string
}

variable "geo_whitelist" {
  description = "List of whitelisted country codes for CloudFront geo restrictions"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
}

variable "certificate_validation_arn" {
  description = "ARN of the ACM certificate validation for dependency"
  type        = string
}

variable "api_gateway_url" {
  description = "URL of the API Gateway for CloudFront routing"
  type        = string
}

variable "api_gateway_stage_name" {
  description = "Name of the API Gateway stage"
  type        = string
}
