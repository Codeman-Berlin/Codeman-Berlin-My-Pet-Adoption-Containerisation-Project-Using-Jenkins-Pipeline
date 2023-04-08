output "lb_tg" {
    value = aws_lb_target_group.Codeman_lb_TG.arn
}

output "lb_DNS" {
    value = aws_lb.Codeman_lb.dns_name
}

output "lb_zone_id" {
    value = aws_lb.Codeman_lb.zone_id
}

output "lb_arn" {
    value = aws_lb.Codeman_lb.arn
}