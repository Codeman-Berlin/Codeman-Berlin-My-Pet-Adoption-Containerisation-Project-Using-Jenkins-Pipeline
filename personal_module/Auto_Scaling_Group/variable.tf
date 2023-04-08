variable "asg-group-name"{
    default = "codeman_asg"
}
variable "vpc_subnet1" {
    default = "dummy"
}
variable "vpc_subnet2" {
    default = "dummy"
}
variable "lb_arn" {
    default = "dummy"
}
variable "asg-policy" {
    default = "codeman_asg_policy"
}
variable "lc_name" {
    default = "codeman_lc_name"
}
variable "lc_instance_type" {
    default = "t3.medium"
}
variable "asg_sg" {
    default = "dummy"
}
variable "key_pair" {
    default = "dummy"
}
variable "launch_ami_name" {
    default = "codeman_lc_ami"
}
variable "ami_source_instance" {
    default = "dummy"
}