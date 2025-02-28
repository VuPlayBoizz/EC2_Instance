resource "aws_eip" "elastic_ip" {
  tags = merge(var.tags, {Name = "${var.tags["Name"]}-eip"})
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id   = aws_eip.elastic_ip.id
    subnet_id       = var.public_subnet_id
    tags            = merge(var.tags, {Name = "${var.tags["Name"]}-nat"})
}