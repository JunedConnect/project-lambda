output "website_url" {
  description = "URL of the S3 website"
  value       = "https://${module.s3.s3_bucket_domain_name}"
}

output "api_gateway_url" {
  description = "URL of the API Gateway"
  value       = module.api_gateway.api_gateway_invoke_url
}
