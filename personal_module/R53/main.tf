#Route53 Hosted Zone
resource "aws_route53_zone" "codeman_zone" {
  name = var.domain-name
  force_destroy = true
}

#Route53 Alias Record pointing to LB
resource "aws_route53_record" "codeman-record" {
  zone_id = aws_route53_zone.codeman_zone.id
  name    = var.domain-name
  type    = "A"

  alias {
    name                   = var.lb-dns
    zone_id                = var.lb-zone-id
    evaluate_target_health = false
  }
}