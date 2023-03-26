# VPC Name
variable "vpc_name" {
  default = "Codeman-VPC"
}
# Name to be attached to all resources
variable "name" {
  default = "Codeman"
}
# VPC Classless Inter-Domain Routing Block (cidr block)
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
# Availability Zone 1
variable "az1" {
  default = "eu-west-2a"
}
# Availability Zone 2
variable "az2" {
  default = "eu-west-2b"
}
# Private Subnet cidr-block 1
variable "prv-sn1" {
  default = "10.0.1.0/24"
}
#Private Subnet cidr-block 2
variable "prv-sn2" {
  default = "10.0.2.0/24"
}
# Public Subnet cidr-block 1
variable "pub-sn1" {
  default = "10.0.3.0/24"
}
# Public Subnet cidr-block 2
variable "pub-sn2" {
  default = "10.0.4.0/24"
}
# Keypair Name
variable "keyname" {
  default = "Codeman"
}

variable "ec2_name" {
  default = "Codeman-Docker"
}

variable "ec2_ami" {
  default = "ami-05c96317a6278cfaa"
}

variable "instancetype" {
  default = "t3.medium"
}

variable "sonar-name" {
  default            = "sonar-sever"
}

variable "docker_name" {
  default            = "docker_server"
}

# #ASG Variables
# variable "ami-name" {
# default = "host_ami"
# }
variable "target-instance" {
default = "docker_server"
}
# variable "launch-configname" {
# default = "host_ASG_LC"
# }

# variable "sg_name3" {
# default = "                                                "
# }

# variable "asg-group-name" {
# default = "Codeman_ASG"
# }
variable "vpc-zone-identifier" {
default = ""
}
variable "target-group-arn" {
default = ""
}
# variable "asg-policy" {
# default = ""
# }
variable "alb" {
  default = "Codeman-lb"
}

variable "lb-zone-id" {
  default = "dummy"
}