output "public_sg_id" {
    value = aws_security_group.public-sg.id
}
output "private_sg_id" {
    value = aws_security_group.private-sg.id
}