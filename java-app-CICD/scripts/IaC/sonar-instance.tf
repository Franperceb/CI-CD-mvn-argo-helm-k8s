provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "sonarqube_instance" {
  ami             = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22.04 LTS (HVM)
  instance_type   = "t2.micro"              # A cost-effective instance type
  security_groups = [aws_security_group.web_server_sg.name]
  key_name        = "ec2-user"
  tags = {
    Name = "ubuntu-sq-instance"
  }
}

resource "aws_security_group" "web_server_sg" {
  name        = "sqube-server-sg"
  description = "Allow SSH, HTTPS, and Outbound Internet traffic"

  # Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH traffic from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTPS traffic from anywhere
  }
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH traffic from anywhere
  }

  # Egress rule to allow all outbound traffic (internet access)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Output the public IP address of the EC2 instance
output "public_ip" {
  value = aws_instance.sonarqube_instance.public_ip
}
