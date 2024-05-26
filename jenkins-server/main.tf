#VPC 

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cide

  azs            = ["us-east-2a"]
  public_subnets = ["10.0.101.0/24"]

  enable_dns_hostnames = true

  tags = {
    name        = "Jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
}


#SG

module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security group for jenkins-sg"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }]

  tags = {
    name = "Jenkins-SG"

  }
}


#EC2


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-server"

  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = true
  vpc_security_group_ids = [module.vote_service_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data = file("jenkins-install.sh")
  availability_zone = data.aws_availability_zone.AZs.name
  tags = {
    name="jenkins_server"
    Terraform   = "true"
    Environment = "dev"
  }
}
