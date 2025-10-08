output "website_url" {
  description = "URL of the S3 website"
  value       = "https://${module.s3.s3_bucket_domain_name}"
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket hosting the frontend"
  value       = module.s3.s3_bucket_name
}

output "api_gateway_url" {
  description = "URL of the API Gateway"
  value       = module.api_gateway.api_gateway_invoke_url
}
