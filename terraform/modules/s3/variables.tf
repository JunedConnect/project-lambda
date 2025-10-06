variable "name" {
  description = "Resource name prefix"
  type        = string
}

variable "s3_version_expiration_days" {
  description = "Number of days after which non-current versions of S3 objects are deleted"
  type        = number
  default     = 30
}

variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution for OAC access"
  type        = string
  default     = null
}