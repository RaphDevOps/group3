resource "aws_vpc" "group3_vpc" {
  cidr_block = var.vpc_cidr
  tags       = var.VPC_tags
}

resource "aws_subnet" "private-sn" {
  vpc_id            = aws_vpc.group3_vpc.id
  cidr_block        = var.sn_cidr
  availability_zone = var.az_privsn[0]
  tags              = var.sn_tags
}

resource "aws_security_group" "group3_sg" {
  name   = "group3_sg"
  vpc_id = aws_vpc.group3_vpc.id

  dynamic "ingress" {
    for_each = var.sg_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

data "aws_ami" "latest_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "group3_ec2" {
  subnet_id              = aws_subnet.private-sn.id
  vpc_security_group_ids = [aws_security_group.group3_sg.id] # Change var.sg_ports to the specific security group ID
  instance_type          = var.instance_type[0]
  ami                    = data.aws_ami.latest_ami.id
  tags                   = var.tags_ec2
}

