variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
}

variable "dynamodb_hash_key_name" {
  description = "DynamoDB table hash key name"
  type        = string
}

variable "dynamodb_attribute_name" {
  description = "DynamoDB attribute name (for attribute block)"
  type        = string
}

variable "dynamodb_attribute_type" {
  description = "DynamoDB attribute type (S | N | B) for attribute block"
  type        = string
}

variable "dynamodb_billing_mode" {
  description = "DynamoDB billing mode (PAY_PER_REQUEST | PROVISIONED)"
  type        = string
}

variable "dynamodb_pitr_enabled" {
  description = "Enable point-in-time recovery (PITR)"
  type        = bool
}

variable "dynamodb_ttl_attribute_name" {
  description = "DynamoDB TTL attribute name"
  type        = string
}

variable "dynamodb_ttl_enabled" {
  description = "Enable DynamoDB TTL"
  type        = bool
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}
