module "vpc" {
    source = "./Modules/01_aws_vpc"
    cidr_block              = var.cidr_block
    enable_dns_hostnames    = var.enable_dns_hostnames
    enable_dns_support      = var.enable_dns_support
    tags                    = var.tags
}

module "public_subnet_1a" {
    source                      = "./Modules/02_aws_public_subnet"
    vpc_id                      = module.vpc.vpc_id
    public_subnet_cidr_block    = var.public_subnet_cidr_block[0]
    availability_zone           = var.availability_zone[0]
    tags                        = var.tags
}

module "private_subnet_1a" {
    source                      = "./Modules/03_aws_private_subnet"
    vpc_id                      = module.vpc.vpc_id
    private_subnet_cidr_block   = var.private_subnet_cidr_block[0]
    availability_zone           = var.availability_zone[0]
    tags                        = var.tags
}
module "vpc-igw" {
    source      = "./Modules/04_aws_internet_gateway"
    vpc_id      = module.vpc.vpc_id
    tags        = var.tags
}

module "vpc-nat" {
    source              = "./Modules/05_aws_nat_gateway"
    vpc_id              = module.vpc.vpc_id
    public_subnet_id = module.public_subnet_1a.public_subnet_id
    tags                = var.tags
}

module "vpc-route-table" {
    source              = "./Modules/06_aws_route"
    vpc_id              = module.vpc.vpc_id
    internet_gateway_id = module.vpc-igw.internet_gateway_id
    nat_gateway_id      = module.vpc-nat.nat_gateway_id
    public_subnet_ids   = [module.public_subnet_1a.public_subnet_id]  
    private_subnet_ids  = [module.private_subnet_1a.private_subnet_id]
    depends_on          = [module.vpc-nat]
    tags                = var.tags
}
module "prefix_list" {
    source              = "./Modules/07_aws_prefix_list"
    jenkins_vpc_cidr    = var.jenkins_vpc_cidr
    eks_vpc_cidr        = var.eks_vpc_cidr
    ec2_vpc_cidr        = var.ec2_vpc_cidr
    My_computer_ip      = var.My_computer_ip
    nat_gateway_ip      = module.vpc-nat.nat_gateway_ip
}
module "vpc-security-group" {
    source                      = "./Modules/08_aws_security_groups"
    vpc_name                    = var.vpc_name 
    vpc_id                      = module.vpc.vpc_id
    prefix_list_ids             = module.prefix_list.ec2_prefix_list_id 
    My_computer_ip              = var.My_computer_ip
    tags                        = var.tags 
}

module "key-pair" {
    source      = "./Modules/09_aws_key_pair"
    key_name    = var.key_name 
}

module "Rancher-server" {
    source                      = "./Modules/10_aws_ec2_public_instance"
    instance_type               = var.instance_types[0]
    private_key_path            = var.private_key_path    
    key_name                    = module.key-pair.key_name
    subnet_id                   = module.public_subnet_1a.public_subnet_id
    security_groups_id          = module.vpc-security-group.public_sg_id
    name                        = "Rancher-Server" 
    workspace_path              = "/tools/rancher"
    script_name                 = "rancher.sh"
    associate_public_ip_address = true
}
module "Mongodb-server" {
    source                      = "./Modules/11_aws_ec2_private_instance"
    instance_type               = var.instance_types[0]
    private_key_path            = var.private_key_path    
    key_name                    = module.key-pair.key_name
    subnet_id                   = module.private_subnet_1a.private_subnet_id
    security_groups_id          = module.vpc-security-group.private_sg_id
    bastion_host                = module.Rancher-server.ec2_public_ip
    name                        = "Mongo-Server" 
    workspace_path              = "/tools/mongo"
    script_name                 = "mongodb.sh"
    associate_public_ip_address = false
}
