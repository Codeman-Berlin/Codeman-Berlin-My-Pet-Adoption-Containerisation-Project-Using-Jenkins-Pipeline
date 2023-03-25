variable "name_lb" {
    default = "Codeman-lb"
}

variable "lb_security" {
    default = "dummy"
}

variable "lb_subnet1" {
    default = "dummy"
}

variable "lb_subnet2" {
    default = "dummy"
}

variable "env" {
    default = "development"
}

variable "lb_TG_name" {
    default = "Codeman-lb-TG"
}

variable "vpc_name" {
    default = "dummy"
}

variable "target_instance" {
    default = "dummy"
}   

variable "proxy_port1" {
  default  = 8080
}

variable "http_port" {
  default  = 80
}