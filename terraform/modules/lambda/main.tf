resource "aws_dynamodb_table" "this" {
  name           = var.dynamodb_table_name
  hash_key       = var.dynamodb_hash_key_name
  billing_mode   = var.dynamodb_billing_mode
  
  point_in_time_recovery {
    enabled = var.dynamodb_pitr_enabled
  }

  attribute {
    name = var.dynamodb_attribute_name
    type = var.dynamodb_attribute_type
  }

  ttl {
    attribute_name = var.dynamodb_ttl_attribute_name
    enabled        = var.dynamodb_ttl_enabled
  }
}

resource "aws_iam_policy" "dynamodb_table_access" {
  name        = "${var.name}-DynamoDB-table-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem"
        ]
        Resource = aws_dynamodb_table.this.arn
      }
    ]
  })
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14
}

resource "aws_iam_role" "lambda" {
  name = "${var.name}-Lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.name}-lambda-logging"
  description = "IAM policy for logging from Lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.lambda.arn}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.dynamodb_table_access.arn
}

resource "aws_lambda_function" "this" {
  filename      = "${path.module}/../../../lambda/zip/function.zip"
  function_name = var.function_name
  role          = aws_iam_role.lambda.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.12"
  source_code_hash = data.archive_file.my_lambda_function_zip.output_base64sha256 # this will make Terraform to compare the zip file with the previous one and if there is a change, it will update the Lambda function on the next Terraform apply 

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }

  logging_config {
    log_format            = "JSON"
    application_log_level = "INFO"
    system_log_level      = "WARN"
  }
}

# below resource will zip the Lambda files so it can be used for the Lambda function 
data "archive_file" "my_lambda_function_zip" {
  type       = "zip"
  source_dir = "${path.module}/../../../lambda/raw"
  output_path = "${path.module}/../../../lambda/zip/function.zip"
}
