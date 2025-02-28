// Define the variables in Provider block
variable "region" {
    description = "The region where resources will be created"
    type        = string
}
variable "tags" {
    description = "A map of tags to assign to the resources"
    type        = map(string)
}

// Define the variables in aws_vpc module
variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}
variable "enable_dns_hostnames" {
    description = "A boolean flag to enable/disable DNS hostnames in the VPC"
    type        = bool
}
variable "enable_dns_support" {
    description = "A boolean flag to enable/disable DNS support in the VPC"
    type        = bool
}

// Define the variables in aws_public_subnet module
variable "public_subnet_cidr_block" {
    description = "The CIDR block for the public subnet"
    type        = list(string)
}

// Define the variables in aws_private_subnet module
variable "private_subnet_cidr_block" {
    description = "The CIDR block for the public subnet"
    type        = list(string)
}

variable "availability_zone" {
    description = "The availability zone"
    type        = list(string)
}

// Define the variables in aws_igw module
// Define the variables in aws_nat module
// Define the variables in aws_route module
// Define the variables in aws_prefix_list module
variable "eks_vpc_cidr" {
    description = "The CIDR block for the EKS VPC"
    type        = string
}
variable "jenkins_vpc_cidr" {
    description = "The CIDR block for the Jenkins VPC"
    type        = string
}
variable "ec2_vpc_cidr" {
    description = "The CIDR block for the ec2 VPC"
    type        = string
}
// Define the variables in aws_security_groups module
variable "vpc_name" {
    description = "Name of VPC"
    type        = string
}
variable "My_computer_ip" {
    description = "The IP address of the computer"
    type        = string
}

// Define the variables in aws_key_pair module
variable "key_name" {
    description = "The name of the key pair"
    type        = string
}
variable "private_key_path" {
    description = "The path to the private key"
    type        = string
}
//Define the variables in aws_ec2_instance module
variable "instance_types" {
    description = "The instance type"
    type        = list(string)
}