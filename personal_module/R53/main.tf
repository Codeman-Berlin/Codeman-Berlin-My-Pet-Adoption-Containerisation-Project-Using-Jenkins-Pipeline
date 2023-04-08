# ACM Certificate
resource "aws_acm_certificate" "codeman_certificate" {
  domain_name       = var.domain-name
  validation_method = "DNS"

  tags = {
    "Environmet" = "codeman_certificate"
  }

  lifecycle {
    create_before_destroy = true 
  }
}

# To get details about the Route53 Hosted Zone Created in the AWS Console
data "aws_route53_zone" "codeman-hosted" {
  name         = var.domain-name
  private_zone = false
}

# A record set in Route53 for domain validation
resource "aws_route53_record" "codeman_record" {
  for_each = {
    for dvo in aws_acm_certificate.codeman_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.codeman-hosted.zone_id
}

# Validate ACM Certificate
resource "aws_acm_certificate_validation" "codeman_acm_cert_valid" {
  certificate_arn         = aws_acm_certificate.codeman_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.codeman_record : record.fqdn]
}

#Record
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.codeman-hosted.zone_id
  name    = var.domain-name
  type    = var.record_type

  alias {
    name                   = var.lb-dns
    zone_id                = var.lb-zone-id
    evaluate_target_health = true
  }
}