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

# variable "http_port" {
#   default            = 80
# }


# variable "ssh_port" {
#   default            = 22
# }

# variable "proxy_port1" {
#   default            = 8080
# }

# variable "proxy_port2" {
#   default            = 9000
# }

# variable "MySQL_port" {
#   default            = 3306
# }

# variable "des_http" {
#   default            = "This port allows http access"   
# }

# variable "des_ssh" {
#   default            = "This port allows ssh access"
# }


# variable "proxy" {
#   default            = "This port allows proxy access"
# }

# variable "prot" {
#   default            = "tcp"
# }

# variable "all_access" {
#   default            = "0.0.0.0/0"
# }

# variable "keyname" {
#   default            = "paceud-kp2"
# }

# variable "ec2_name" {
#   default            = "Test-ec2"
# }

# variable "ec2_ami" {
#   default            = "ami-05c96317a6278cfaa"
# }

# variable "instancetype" {
#   default            = "t3.medium"  
#   }

# variable "sonar-name" {
#   default            = "sonar-sever"
#   }
# variable "docker_name" {
#   default            = "docker_server"
# }

# #ASG Variables
# variable "ami-name" {
# default = "host_ami"
# }
# variable "target-instance" {
# default = "docker_server"
# }
# variable "launch-configname" {
# default = "host_ASG_LC"
# }

# variable "sg_name3" {
# default = "                                                "
# }

# variable "asg-group-name" {
# default = "pacaad_ASG"
# }
# variable "vpc-zone-identifier" {
# default = ""
# }
# variable "target-group-arn" {
# default = ""
# }
# variable "asg-policy" {
# default = ""
# }
# variable "alb" {
#   default = "pacaad-lb"
# }