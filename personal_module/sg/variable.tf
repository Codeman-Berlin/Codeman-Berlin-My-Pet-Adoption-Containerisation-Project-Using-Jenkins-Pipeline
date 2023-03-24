# VPC_id
variable "vpc" {
  default = "vpc-09e65c2c07a323881"
}
# Name Associated to all resources
variable "name" {
  description = "Name to be associated with all resources for this Project"
  type        = string
  default     = "Codeman"
}
# All Accessible Ports In The Security group
variable "http_port" {
  default     = 80
  description = "this port allows http access"
}
variable "proxy_port1" {
  default     = 8080
  description = "this port allows proxy access"
}
variable "ssh_port" {
  default     = 22
  description = "this port allows ssh access"
}
variable "proxy_port2" {
  default     = 9000
  description = "this port allows proxxy access"
}

variable "MYSQL_port" {
  default     = 3306
  description = "this port allows proxy access"
}
# Allow access from everywhere
variable "all_access" {
  default = "0.0.0.0/0"
}