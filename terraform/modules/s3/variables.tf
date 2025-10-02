variable "name" {
  description = "Resource name prefix"
  type        = string
}

variable "s3_version_expiration_days" {
  description = "Number of days after which non-current versions of S3 objects are deleted"
  type        = number
  default     = 30
}
