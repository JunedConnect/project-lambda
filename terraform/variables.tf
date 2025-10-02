#General

variable "name" {
  description = "Resource Name"
  type        = string
  default     = "prod"
}

variable "aws_tags" {
  description = "Tags for Resources"
  type        = map(string)
  default = {
    Environment = "dev",
    Project     = "url-shortener",
    Owner       = "juned",
    Terraform   = "true"
  }
}


# ALB

variable "alb_internal" {
  description = "Whether the ALB is internal or not"
  type        = bool
  default     = false
}

variable "alb_load_balancer_type" {
  description = "Type of the load balancer"
  type        = string
  default     = "application"
}

variable "listener_port_http" {
  description = "Port for the HTTP listener"
  type        = string
  default     = "80"
}

variable "listener_protocol_http" {
  description = "Protocol for the HTTP listener"
  type        = string
  default     = "HTTP"
}

variable "listener_port_https" {
  description = "Port for the HTTPS listener"
  type        = string
  default     = "443"
}

variable "listener_protocol_https" {
  description = "Protocol for the HTTPS listener"
  type        = string
  default     = "HTTPS"
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
  default     = "this"
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 8080
}

variable "target_group_health_check_path" {
  description = "Health check path for the target group"
  type        = string
  default     = "/"
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "target_group_target_type" {
  description = "Target type for the target group"
  type        = string
  default     = "ip"
}


# Lambda

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "my-function"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "url-prod"
}

variable "dynamodb_hash_key_name" {
  description = "DynamoDB table hash key name"
  type        = string
  default     = "id"
}

variable "dynamodb_attribute_name" {
  description = "DynamoDB attribute name (for attribute block)"
  type        = string
  default     = "id"
}

variable "dynamodb_attribute_type" {
  description = "DynamoDB attribute type (S | N | B) for attribute block"
  type        = string
  default     = "S"
}

variable "dynamodb_billing_mode" {
  description = "DynamoDB billing mode (PAY_PER_REQUEST | PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_pitr_enabled" {
  description = "Enable point-in-time recovery (PITR)"
  type        = bool
  default     = true
}

variable "dynamodb_ttl_attribute_name" {
  description = "DynamoDB TTL attribute name"
  type        = string
  default     = "ttl"
}

variable "dynamodb_ttl_enabled" {
  description = "Enable DynamoDB TTL"
  type        = bool
  default     = true
}


# Route53

variable "domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
  default     = "prod.juned.co.uk"
}

variable "validation_method" {
  description = "The validation method for the ACM certificate"
  type        = string
  default     = "DNS"
}

variable "dns_ttl" {
  description = "Time to live (TTL) for DNS records"
  type        = number
  default     = 60
}


# VPC

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "publicsubnet1_cidr_block" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.2.1.0/24"
}

variable "publicsubnet2_cidr_block" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.2.2.0/24"
}

variable "privatesubnet1_cidr_block" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.2.3.0/24"
}

variable "privatesubnet2_cidr_block" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.2.4.0/24"
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "subnet_map_public_ip_on_launch" {
  description = "Whether to map public IP on launch for subnets"
  type        = bool
  default     = true
}

variable "availability_zone_1" {
  description = "Availability zone 1"
  type        = string
  default     = "eu-west-2a"
}

variable "availability_zone_2" {
  description = "Availability zone 2"
  type        = string
  default     = "eu-west-2b"
}

variable "route_cidr_block" {
  description = "CIDR block for the route"
  type        = string
  default     = "0.0.0.0/0"
}