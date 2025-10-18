variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-multi-env-aws"
}

variable "allowed_ip_cidr" {
  description = "CIDR block for stage environment SSH access"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpn_cidr" {
  description = "CIDR block for production environment SSH access (VPN/bastion)"
  type        = string
  default     = "10.0.0.0/8"
}