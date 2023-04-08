# Create a Prod elb
resource "aws_elb" "Prod_elb" {
  name               = var.Prod_elb_name
  subnets = [ var.subnet_id1, var.subnet_id2 ]
  security_groups = [ var.security_id ]


  listener {
    instance_port     = var.instance_prt
    instance_protocol = "http"
    lb_port           = var.http_port
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 30
  }

  instances                   = [var.Prod_id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = var.Prod_elb_name
  }
}