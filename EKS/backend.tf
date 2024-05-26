terraform {
  backend "s3" {
    bucket = "cide-eks-terraform-13432"
    key = "jenkins/terraform.tfstate"
    region = "us-east-2"
  }
}