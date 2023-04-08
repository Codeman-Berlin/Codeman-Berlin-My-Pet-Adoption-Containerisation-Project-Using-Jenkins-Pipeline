# VPC
module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = var.vpc_name
  cidr                   = var.vpc_cidr
  azs                    = [var.az1, var.az2]
  private_subnets        = [var.prv-sn1, var.prv-sn2]
  public_subnets         = [var.pub-sn1, var.pub-sn2]
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  tags = {
    Terraform = "true"
    Name      = "${var.name}-vpc"
  }
}

# Security Group
module "sg" {
  source = "./personal_module/sg"
  vpc    = module.vpc.vpc_id
}

# Keypair
module "key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = var.keyname
  public_key = file("~/keypairs/Codeman.pub")
}

# Bastion Host Instance
module "Bastion" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.ec2_name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.bastion-sg-id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data = templatefile("./User-data/Bastion.sh",
    {
      keypair = "~/keypairs/Codeman"
    }
  )
  tags = {
    Terraform = "true"
    Name      = "${var.name}-Bastion"
  }
}

# Docker Instance
module "Docker" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.ec2_name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.docker-sg-id]
  subnet_id              = module.vpc.private_subnets[0]
  count                  = 2
  user_data              = file("./User-data/Docker.sh")
  tags = {
    Terraform = "true"
    Name      = "${var.docker_name}${count.index}"
  }
}

# Jenkins Instance
module "Jenkins" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.ec2_name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.jenkins-sg-id]
  subnet_id              = module.vpc.private_subnets[0]
  user_data              = file("./User-data/Jenkins.sh")
  tags = {
    Terraform = "true"
    Name      = "${var.name}-Jenkins"
  }
}

# Elastic Load balancer for Jenkins
module "jenkins_elb" {
  source      = "./personal_module/Jenkins_elb"
  subnet_id1  = module.vpc.public_subnets[0]
  subnet_id2  = module.vpc.public_subnets[1]
  security_id = module.sg.alb-sg-id
  jenkins_id  = module.Jenkins.id
}

# Production Server ELB
module "Prod_elb" {
  source      = "./personal_module/Prod_elb"
  subnet_id1  = module.vpc.public_subnets[0]
  subnet_id2  = module.vpc.public_subnets[1]
  security_id = module.sg.alb-sg-id
  Prod_id     = module.Docker[1].id
}

# Ansible Instance (QA & Prod)
module "Ansible" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.ec2_name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.ansible-sg-id]
  subnet_id              = module.vpc.private_subnets[0]
  user_data = templatefile("./User-data/Ansible.sh",
    {
      QAcontainer         = "./playbooks/QAcontainer.yml",
      PRODcontainer       = "./playbooks/PRODcontainer.yml",
      QA_Server_priv_ip   = module.Docker[0].private_ip,
      PROD_Server_priv_ip = module.Docker[1].private_ip,
      keypair             = "~/keypairs/Codeman"
    }
  )
  tags = {
    Terraform = "true"
    Name      = "${var.name}-Ansible"
  }
}

# SonarQube Instance
module "Sonarqube" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.sonar-name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.sonarqube-sg-id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("./User-data/Sonar.sh")
  tags = {
    Terraform = "true"
    Name      = "${var.name}-sonar-instance"
  }
}

# Application Load Balancer
module "App_loadbalancer" {
  source          = "./personal_module/App_loadbalancer"
  lb_security     = module.sg.alb-sg-id
  lb_subnet1      = module.vpc.public_subnets[0]
  lb_subnet2      = module.vpc.public_subnets[1]
  vpc_name        = module.vpc.vpc_id
  target_instance = module.Docker[1].id
}

# Auto Scaling Group
module "Auto_Scaling_Group" {
  source              = "./personal_module/Auto_Scaling_Group"
  vpc_subnet1         = module.vpc.public_subnets[0]
  vpc_subnet2         = module.vpc.public_subnets[1]
  lb_arn              = module.App_loadbalancer.lb_tg
  asg_sg              = module.sg.docker-sg-id
  key_pair            = module.key_pair.key_pair_name
  ami_source_instance = module.Docker[1].id
}

# Database
module "db" {
  source                 = "terraform-aws-modules/rds/aws"
  identifier             = "codemandb"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.medium"
  allocated_storage      = 5
  db_name                = "codemanDB"
  username               = "admin"
  password               = "admin"
  port                   = "3306"
  vpc_security_group_ids = [module.sg.mysql-sg-id]
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  # DB parameter group
  family = "mysql5.7"
  # DB option group
  major_engine_version = "5.7"
  # Database Deletion Protection
  deletion_protection = false
}

# Route53 & Alias Record
module "R53" {
  source     = "./personal_module/R53"
  lb-zone-id = module.App_loadbalancer.lb_zone_id
  lb-dns     = module.App_loadbalancer.lb_DNS
}


