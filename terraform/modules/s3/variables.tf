variable "name" {
  description = "Resource name prefix"
  type        = string
}


variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution for OAC access"
  type        = string
  default     = null
}