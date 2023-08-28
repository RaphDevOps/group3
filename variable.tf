variable "vpc_cidr" {
  description = "required cidr_block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "VPC_tags" {
  description = "expected name"
  type        = map(string)
  default = {
    "Name" = "Group3_vpc"
    "Env"  = "DEV"
  }
}

variable "sn_cidr" {
  description = "value"
  type        = string
  default     = "10.0.0.0/24"
}

variable "az_privsn" {
  description = "value"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "sn_tags" {
  description = "value"
  type        = map(string)
  default = {
    "Name" = "group_SN"
    "Env"  = "DEV"
  }
}

variable "sg_ports" {
  description = "port to allow traffic through"
  type        = list(string)
  default     = ["22", "80", "443"]
}

variable "instance_type" {
  description = "expected"
  type        = list(string)
  default     = ["t2.micro", "t2.medium", "t2.large"]
}

variable "tags_ec2" {
  description = "value"
  type        = map(string)
  default = {
    "Name" = "group3_ec2"
    "Env"  = "DEV"
  }
}

# resource "aws_vpc" "group3_vpc" {
#   cidr_block = var.vpc_cidr
#   tags       = var.VPC_tags
# }

# resource "aws_subnet" "private-sn" {
#   vpc_id            = aws_vpc.group3_vpc.id
#   cidr_block        = var.sn_cidr
#   availability_zone = var.az_privsn[0]
#   tags              = var.sn_tags
# }

# resource "aws_security_group" "group3_sg" {
#   name = "group3_sg"
#   vpc_id = aws_vpc.group3_vpc.id

#   dynamic "ingress" {
#     for_each = var.sg_ports

#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
# }

# data "aws_ami" "latest_ami" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["amazon"]
# }

# resource "aws_instance" "group3_ec2" {
#   subnet_id              = aws_subnet.private-sn.id
#   vpc_security_group_ids = [aws_security_group.group3_sg.id]
#   instance_type          = var.instance_type[0]  # Select the desired instance type
#   ami                    = data.aws_ami.latest_ami.id
#   tags                   = var.tags_ec2
# }
