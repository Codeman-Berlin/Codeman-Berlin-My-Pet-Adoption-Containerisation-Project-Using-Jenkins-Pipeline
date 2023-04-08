output "name_Servers" {
  value = data.aws_route53_zone.codeman-hosted.name_servers
}

output "zone_id" {
  value = data.aws_route53_zone.codeman-hosted.zone_id
}

