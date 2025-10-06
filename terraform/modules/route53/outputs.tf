output "certificate_arn" {
    value = aws_acm_certificate.this.arn
}

output "certificate_validation_arn" {
    value = aws_acm_certificate_validation.this.certificate_arn
}

output "zone_id" {
    value = aws_route53_zone.this.zone_id
}