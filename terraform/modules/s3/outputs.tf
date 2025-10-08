output "s3_bucket_domain_name" {
  description = "Regional domain name of the S3 bucket"
  value       = aws_s3_bucket.website.bucket_regional_domain_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website.bucket
}