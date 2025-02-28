# Terraform Infrastructure for AWS EC2 Server Deployment

## Overview
This Terraform project automates the provisioning of AWS infrastructure for an EC2 instance deployment. The setup includes a Virtual Private Cloud (VPC), subnets, security groups, NAT gateway, and an EC2 instance. Additionally, it includes Terraform modules to manage different AWS services efficiently.

## Infrastructure Overview
![Picture_1](https://github.com/user-attachments/assets/70cbb24a-ea78-45d2-9149-91db6b12601e)

This Terraform script provisions the following AWS resources:
- VPC with configurable CIDR block, DNS support, and hostname resolution.
- Public and Private Subnets in a specified availability zone.
- Internet Gateway (IGW) for public subnet connectivity.
- NAT Gateway for private subnet connectivity.
- Route Tables for traffic routing.
- Security Groups to manage inbound and outbound rules.
- Key Pair for secure SSH access.
- EC2 Instance with automated provisioning scripts for MongoDB and Rancher.

## Project Structure
```
EC2_Server/
│── Modules/
│   ├── 01_aws_vpc/
│   ├── 02_aws_public_subnet/
│   ├── 03_aws_private_subnet/
│   ├── 04_aws_internet_gateway/
│   ├── 05_aws_nat_gateway/
│   ├── 06_aws_route/
│   ├── 07_aws_security_groups/
│   ├── 08_aws_key_pair/
│   ├── 09_aws_ec2_instance/
│   │   ├── install/mongodb.sh
│   │   ├── install/rancher.sh
│── main.tf
│── provider.tf
│── variables.tf
│── terraform.tfvars
│── README.md
```

## Configuration Variables
### AWS Provider
```hcl
region = "<aws-region>"
```
- **region**: AWS region where the infrastructure will be deployed.

### VPC Configuration
```hcl
cidr_block           = "<vpc-cidr-block>"
enable_dns_support   = <true/false>
enable_dns_hostnames = <true/false>
```
- **cidr_block**: CIDR range for the VPC.
- **enable_dns_support**: Enable or disable DNS resolution support.
- **enable_dns_hostnames**: Enable or disable DNS hostnames for instances.

### Subnet Configuration
```hcl
public_subnet_cidr_block  = "<public-subnet-cidr>"
private_subnet_cidr_block = "<private-subnet-cidr>"
availability_zone         = "<availability-zone>"
```
- **public_subnet_cidr_block**: CIDR block for the public subnet.
- **private_subnet_cidr_block**: CIDR block for the private subnet.
- **availability_zone**: AWS availability zone to deploy the subnets.

### Security Group Configuration
```hcl
My_computer_ip = "<your-ip-address>/32"
```
- **My_computer_ip**: IP address allowed to connect via SSH.

### Key Pair
```hcl
key_name = "<key-pair-name>"
```
- **key_name**: Name of the SSH key pair used for EC2 instance access.

### EC2 Instance Configuration
```hcl
instance_type      = "<instance-type>"
private_key_path   = "<path-to-private-key>"
```
- **instance_type**: AWS instance type for the EC2 server.
- **private_key_path**: Path to the private key file for SSH access.

## Variables Table
| Variable Name                | Description                                      | Example Value          |
|------------------------------|--------------------------------------------------|------------------------|
| region                       | AWS region for resource deployment              | ap-southeast-1        |
| cidr_block                   | CIDR block for VPC                              | 10.0.0.0/16           |
| enable_dns_support           | Enable DNS resolution support                   | true                   |
| enable_dns_hostnames         | Enable DNS hostnames for instances              | true                   |
| public_subnet_cidr_block     | CIDR block for public subnet                    | 10.0.1.0/24           |
| private_subnet_cidr_block    | CIDR block for private subnet                   | 10.0.2.0/24           |
| availability_zone            | Availability zone for subnets                   | ap-southeast-1a       |
| My_computer_ip               | IP address allowed for SSH access               | 192.168.1.100/32      |
| key_name                     | SSH key pair name                               | my-aws-key            |
| instance_type                | AWS instance type                               | t2.micro              |
| private_key_path             | Path to the SSH private key                     | ./my-aws-key.pem      |

## Usage
### Initialize Terraform
```sh
terraform init
```

### Validate Configuration
```sh
terraform validate
```

### Plan Deployment
```sh
terraform plan
```

### Apply Configuration
```sh
terraform apply -auto-approve
```

### Destroy Infrastructure (if needed)
```sh
terraform destroy -auto-approve
```

## Prerequisites
- Terraform installed (`>= v5.0`).
- AWS CLI configured with necessary permissions.
- SSH key pair created for EC2 instance access.

## Author
**VuPlayBoizz**
