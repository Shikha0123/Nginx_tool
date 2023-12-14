locals {
#  inbound_ports = [80, 22, 443]
 inbound_ports = [
  { port = 80, protocol = "tcp" },   
  { port = 22, protocol = "tcp" },   
  { port = 443, protocol = "tcp" },  
  { port = -1, protocol = "icmp" },  
 ]
 outbound_ports = [0]
 }

resource "aws_security_group" "sq_grp" {
  name        = "sq_grp"
  description = "Security group for EC2 instance"
  vpc_id = var.vpc_id

  dynamic "ingress" {
  for_each = local.inbound_ports
  content {
   from_port = ingress.value.port
   to_port = ingress.value.port
   protocol = ingress.value.protocol
   cidr_blocks = ["0.0.0.0/0"]
  }
 }
 dynamic "egress" {
  for_each = local.outbound_ports
  content {
   from_port = egress.value
   to_port = egress.value
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
 }
  tags = {
    Name = var.seq_grp
  }
}

# Instances
resource "aws_instance" "bastion" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name  
  subnet_id = var.subnet_pub_id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sq_grp.id]
  tags = {
    Name = var.bastion_instance_name
  }
}


resource "aws_instance" "private-ec2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name
  subnet_id = var.subnet_pvt_id
  vpc_security_group_ids = [aws_security_group.sq_grp.id]
  tags = {
    Name = var.private_instance_name
  }
}

# Genrate Key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Genrate pen Key 
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

# pem Key download in sysytem
resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}