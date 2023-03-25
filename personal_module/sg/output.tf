output "bastion-sg-id" {
  value = aws_security_group.Bastion_SG.id
}

output "ansible-sg-id" {
  value = aws_security_group.Ansible_SG.id
}

output "docker-sg-id" {
  value = aws_security_group.Docker_SG.id
}

output "jenkins-sg-id" {
  value = aws_security_group.Jenkins_SG.id
}

output "sonarqube-sg-id" {
  value = aws_security_group.Sonarqube_SG.id
}

output "mysql-sg-id" {
  value = aws_security_group.Backend_SG.id
}

output "alb-sg-id" {
  value = aws_security_group.ALB_SG.id
}


