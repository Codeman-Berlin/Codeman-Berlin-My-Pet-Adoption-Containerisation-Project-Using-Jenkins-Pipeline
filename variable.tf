# VPC Name
variable "vpc_name" {
  default                          = "Codeman-VPC"
}
# Name to be attached to all resources
variable "name" {
  default                          = "Codeman"
}
# VPC Classless Inter-Domain Routing Block (cidr block)
variable "vpc_cidr" {
  default                          = "10.0.0.0/16"
}
# Availability Zone 1
variable "az1" {
  default            = "eu-west-2a"
}
# Availability Zone 2
variable "az2" {
  default            = "eu-west-2b"
}
# Private Subnet cidr-block 1
variable "prv-sn1" {
  default            = "10.0.1.0/24"
}
#Private Subnet cidr-block 2
variable "prv-sn2" {
  default            = "10.0.2.0/24"
}
# Public Subnet cidr-block 1
variable "pub-sn1" {
  default            = "10.0.3.0/24"
}
# Public Subnet cidr-block 2
variable "pub-sn2" {
  default            = "10.0.4.0/24"
}

