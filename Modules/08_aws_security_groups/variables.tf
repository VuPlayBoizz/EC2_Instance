variable "vpc_name" {
    description = "Name of the EKS cluster"
    type        = string
}
variable "vpc_id" {
    description = "The ID of the VPC where the security groups will be created"
    type        = string
}
variable "prefix_list_ids" {
    description = "id of prefix list"
    type = string
}
variable "My_computer_ip" {
    description = "My computer IP address"
    type        = string
}
variable "tags" {
    description = "Tags to apply to the security groups"
    type        = map(string)
}