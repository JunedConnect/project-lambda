output "api_gateway_url" {
  description = "Invoke URL of the API Gateway"
  value       = aws_api_gateway_stage.this.invoke_url
}

output "api_gateway_stage_name" {
  description = "Name of the API Gateway stage"
  value       = aws_api_gateway_stage.this.stage_name
}
