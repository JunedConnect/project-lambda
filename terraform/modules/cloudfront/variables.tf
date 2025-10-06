variable "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  type        = string
}

variable "s3_origin_id" {
  description = "Origin ID for S3 bucket in CloudFront distribution"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the CloudFront distribution"
  type        = string
}

variable "domain_aliases" {
  description = "List of domain  aliases to append to the main domain name for CloudFront distribution"
  type        = list(string)
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
}

variable "geo_restriction_locations" {
  description = "List of country codes for CloudFront geo restrictions"
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