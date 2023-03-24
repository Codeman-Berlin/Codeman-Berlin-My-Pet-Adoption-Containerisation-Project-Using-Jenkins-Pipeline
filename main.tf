# VPC
module "vpc" {
  source                    = "terraform-aws-modules/vpc/aws"
  name                      = var.vpc_name
  cidr                      = var.vpc_cidr
  azs                       = [var.az1, var.az2]
  private_subnets           = [var.prv-sn1, var.prv-sn2]
  public_subnets            = [var.pub-sn1, var.pub-sn2]
  enable_nat_gateway        = true
  single_nat_gateway        = false
  one_nat_gateway_per_az    = true
  tags = {
    Terraform               = "true"
    Name                    = "${var.name}-vpc"
  }
}

module "key_pair" {
  source                    = "terraform-aws-modules/key-pair/aws"
  key_name                  = var.keyname
  public_key                = file("~/keypairs/Codeman.pub")
}

module "sg" {
  source                    = "./personal_module/sg"
  vpc                       = module.vpc.vpc_id
}

module "Bastion" {
  source                    = "terraform-aws-modules/ec2-instance/aws"
  name                      = var.ec2_name
  ami                       = var.ec2_ami
  instance_type             = var.instancetype
  key_name                  = module.key_pair.key_pair_name
  vpc_security_group_ids    = [module.sg.bastion-sg-id]
  subnet_id                 = module.vpc.public_subnets[0]
  user_data                 = templatefile("./User-data/Bastion.sh",
    {
      keypair = "~/keypairs/Codeman"
    }
  )
  tags = {
    Terraform               = "true"
    Name                    = "${var.name}-Bastion"
  }
}