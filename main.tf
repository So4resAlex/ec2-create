data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] #Canonical 
}

resource "aws_instance" "ec2_server" {
  ami = data.aws_ami.ubuntu.id
  availability_zone = var.availability_zone
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  root_block_device {
    delete_on_termination = true
    volume_size = min(var.volume_size, 25)
    volume_type = "gp3"
  }
  tags = {
    Name = var.instance_name
    Manager = "Terraform"
    Environment = var.environment
  }
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.ec2_server.id
  domain = "vpc"
}