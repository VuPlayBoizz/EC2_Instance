resource "aws_ec2_managed_prefix_list" "ec2_prefix_list" {
    name        = "ec2_prefix_list"
    address_family = "IPv4"
    max_entries = 5

    entry {
        cidr        = var.eks_vpc_cidr
        description = "CIDR cho 10.0.0.0/16"
    }

    entry {
        cidr        = var.jenkins_vpc_cidr
        description = "CIDR cho 11.0.0.0/16"
    }

    entry {
        cidr        = var.ec2_vpc_cidr
        description = "CIDR cho 12.0.0.0/16"
    }

    entry {
        cidr        = var.My_computer_ip
        description = "IPv4 of My computer"
    }

    entry {
        cidr = var.nat_gateway_ip
        description = "IPv4 of Nat gateway"
    }
}