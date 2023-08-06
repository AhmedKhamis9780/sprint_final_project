# Configure the AWS Provider
provider "aws" {
    region = "us-east-1"
}

module "vpc" {
  source = "./vpc"
  cidr = "10.0.0.0/16"
  name = "sprint"
}
module "public_subnet" {
  source           = "./public_subnet"  
  subnet_cidr_list = ["10.0.0.0/24","10.0.1.0/24"]
  subnet_zone      = [ "us-east-1a","us-east-1b" ]
  vpc_id           = module.vpc.vpc_id
}
module "private_subnet" {
  source           = "./private_subnet"  
  subnet_cidr_list = ["10.0.2.0/24","10.0.3.0/24"]
  subnet_zone      = [ "us-east-1a","us-east-1b" ]
  vpc_id           = module.vpc.vpc_id
  subnet_public_id = module.public_subnet.subnet_id1[0]

}
module "sec_group" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
}
module "pub_ec2" {
  source = "./public_ec2"
  name = "jenkins"
  AMIS = "ami-053b0d53c279acc90"
  INSTANCE_Type = "t2.medium"
  subnet = [module.public_subnet.subnet_id1[0]]
  sg = module.sec_group.sg_id
  KEY = "new"
}
# module "private_ec2" {
#   source = "./private_ec2"
#   AMIS = "ami-053b0d53c279acc90"
#   INSTANCE_Type = "t2.micro"
#   subnet = module.private_subnet.subnet_id1
#   sg = module.sec_group.sg_id
#   KEY = "new"
# }
module "public_id" {
  source = "./lb"
  name = "public"
  tg_name = "public"
  internal = false
  sg = module.sec_group.sg_id
  subnet = module.public_subnet.subnet_id1
  vpc = module.vpc.vpc_id
  instance = module.pub_ec2.public_ec2_id1
}
# module "private_id" {
#   source = "./lb"
#   name = "private"
#   tg_name = "private"
#   internal = true
#   sg = module.sec_group.sg_id
#   subnet = module.private_subnet.subnet_id1
#   vpc = module.vpc.vpc_id
#   instance = module.private_ec2.private_ec2_id1
# }
# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "19.15.4"
# }