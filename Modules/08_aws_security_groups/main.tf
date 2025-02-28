resource "aws_security_group" "public-sg" {
    name        = "${var.vpc_name}-public-sg"
    description = "Security group for public resources"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        prefix_list_ids = [var.prefix_list_ids]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        prefix_list_ids = [var.prefix_list_ids]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.My_computer_ip]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # Allow all outbound traffic
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(var.tags, { Name = "${var.vpc_name}-public-sg" })
}

resource "aws_security_group" "private-sg" {
    name        = "${var.vpc_name}-private-sg"
    description = "Security group for private resources"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # Allow all outbound traffic
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(var.tags, { Name = "${var.vpc_name}-private-sg" })
}