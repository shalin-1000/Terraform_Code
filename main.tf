#VPC

resource "aws_vpc" "CICD_VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "CICD_VPC"
  }

}

#Subnet

resource "aws_subnet" "CICD_Sub1" {
  vpc_id            = aws_vpc.CICD_VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "Pub-Subnet"
  }

}

# Internetgateway

resource "aws_internet_gateway" "Jen_IGW" {
  vpc_id = aws_vpc.CICD_VPC.id
  tags = {
    Name = "Terraform_IGW"
  }

}

# RouteTable

resource "aws_route_table" "RTA1" {
  vpc_id = aws_vpc.CICD_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Jen_IGW.id
  }

}

# Associate Route Table

resource "aws_route_table_association" "RTA" {
  subnet_id      = aws_subnet.CICD_Sub1.id
  route_table_id = aws_route_table.RTA1.id

}

#Security Group

resource "aws_security_group" "CICDSG" {
  name        = "webserver"
  description = "allow traffic for webserver"
  vpc_id      = aws_vpc.CICD_VPC.id

  ingress {
    description = "SSH from Anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "SSH from Anywhere"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "SSH from Anywhere"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "SSH from Anywhere"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "SSH from Anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow traffic"
  }
}

resource "aws_instance" "Jenkins" {
  ami                    = var.Linux_ami[var.region]
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.CICD_Sub1.id
  vpc_security_group_ids = [aws_security_group.CICDSG.id]
  tags = {
    "Name" = "Jenkins"
  }
  associate_public_ip_address = true
}

resource "aws_instance" "Sonarqube" {
  ami                    = var.Linux_ami[var.region]
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.CICD_Sub1.id
  vpc_security_group_ids = [aws_security_group.CICDSG.id]
  tags = {
    "Name" = "Sonarqube"
  }

  associate_public_ip_address = true


}

resource "aws_instance" "Nexus" {
  ami                    = var.Linux_ami[var.region]
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.CICD_Sub1.id
  vpc_security_group_ids = [aws_security_group.CICDSG.id]
  tags = {
    "Name" = "Nexus"
  }

  associate_public_ip_address = true

}

