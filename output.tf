output "vpc_id" {
  value = module.vpc.vpc_id
}

output "Bastion_ip" {
  value = module.Bastion.public_ip
}

output "Docker_ip" {
  value = module.Docker.*.private_ip
}

output "Jenkins-ip" {
  value = module.Jenkins.private_ip
}

output "jenkins_elb_dns" {
  value = module.jenkins_elb.jenkins_elb_dns
}

output "prod_elb_dns" {
  value = module.Prod_elb.prod_elb_dns
}

output "Sonar-pub_ip" {
  value = module.Sonarqube.public_ip
}
output "Ansible-ip" {
  value = module.Ansible.private_ip
}

output "lb_DNS" {
  value = module.App_loadbalancer.lb_DNS
}

output "name_servers" {
  value = module.R53.name_Servers
}