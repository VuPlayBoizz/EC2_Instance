resource "aws_subnet" "private_subnet" {
    vpc_id              = var.vpc_id
    cidr_block          = var.private_subnet_cidr_block
    availability_zone   = var.availability_zone
    tags                = merge(var.tags, { Name = "${var.tags["Name"]}-private-subnet-${var.availability_zone}"}) 
}