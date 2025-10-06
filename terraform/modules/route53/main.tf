provider "aws" {
  region = "us-east-1"
  alias = "us_east_1" # this is required for CloudFront to work as CloudFront requires the certificate to be in the us-east-1 region
}

resource "aws_route53_zone" "this" {
  name = var.domain_name
}


resource "aws_acm_certificate" "this" {
  provider = aws.us_east_1
  domain_name       = var.domain_name
  subject_alternative_names = [for alias in var.domain_aliases : "${alias}.${var.domain_name}"]
  validation_method = var.validation_method
}


resource "aws_route53_record" "cert-validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = aws_route53_zone.this.zone_id
  name    = each.value.name
  records = [each.value.record]
  type    = each.value.type
  ttl     = var.dns_ttl
}


resource "aws_acm_certificate_validation" "this" {
  provider = aws.us_east_1
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.cert-validation : record.fqdn]
}

resource "aws_route53_record" "cloudfront" {
  for_each = var.cloudfront_aliases
  zone_id  = aws_route53_zone.this.zone_id
  name     = each.value
  type     = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}
