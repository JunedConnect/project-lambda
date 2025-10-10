locals {
  api_gateway_domain = split("/", replace(var.api_gateway_url, "https://", ""))[0] # this removes "https://"" from the API Gateway URL, and it also removes the stage name. Otherwise it cant be used in the distribution resource below
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "${var.name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
  origin { # origin for the s3 bucket
    domain_name              = var.s3_bucket_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
    origin_id                = "${var.name}-s3"
  }

  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"

  aliases = [var.domain_name]

  default_cache_behavior { # default route to the s3 bucket
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.name}-s3"
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  origin { # origin for the api gateway
    domain_name = local.api_gateway_domain
    origin_id   = "${var.name}-api-gateway"
    
    custom_origin_config { # this is needed otherwise it will fail to be created since CloudFront would assume that the origin is an S3 bucket
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  ordered_cache_behavior { # routes api gateway requests to the api gateway origin
    path_pattern     = "/${var.api_gateway_stage_name}/*"
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.name}-api-gateway"

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response { # this is needed in order to route the health pathway, and any other pathway that is not found, to the error.html page
    error_code            = 403
    response_code         = 200
    response_page_path    = "/error.html"
    error_caching_min_ttl = 10
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = var.geo_whitelist
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }

    depends_on = [var.certificate_validation_arn] # this is needed otherwise this resource will fail to be created as it requires a validated certificate beforehand
}