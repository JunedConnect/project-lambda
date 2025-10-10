variable "domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
}


variable "validation_method" {
  description = "The validation method for the ACM certificate"
  type        = string
}

variable "dns_ttl" {
  description = "Time to live (TTL) for DNS records"
  type        = number
}

variable "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "CloudFront distribution hosted zone ID"
  type        = string
}

variable "cloudfront_aliases" {
  description = "CloudFront distribution aliases"
  type        = set(string)
}
