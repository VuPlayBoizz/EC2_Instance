resource "aws_subnet" "public_subnet" {
    vpc_id                  = var.vpc_id
    cidr_block              = var.public_subnet_cidr_block
    availability_zone       = var.availability_zone
    map_public_ip_on_launch = true
    tags                    = merge(var.tags, { Name = "${var.tags["Name"]}-public-subnet-${var.availability_zone}"})
}
