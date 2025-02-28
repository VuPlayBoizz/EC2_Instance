variable "instance_type" {
    description = "The type of instance to start"
    type        = string
}
variable "key_name" {
    description = "The key name to use for the instance"
    type        = string
}
variable "private_key_path" {
    description = "The path to the private key"
    type        = string
}
variable "subnet_id" {
    description = "The subnet ID to launch the instance in"
    type        = string
}
variable "associate_public_ip_address" {
    description = "Associate a public IP address with the instance"
    type        = bool
}
variable "security_groups_id" {
    description = "The security group ID to attach to the instance"
    type        = string
}
variable "workspace_path" {
    description = "The path to the workspace"
    type        = string
}
variable "script_name" {
    description = "The name of the script to run"
    type        = string
}
variable "name" {
    description = "The name of the EC2 instance"
    type        = string
}