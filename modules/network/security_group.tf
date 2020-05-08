# Web SecurityGroup
resource "aws_security_group" "takahashi-web-sg" {
  name   = "takahashi-web-sg"
  vpc_id = var.vpc_id

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # http
  ingress {
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
}

output "security_group_web_id" {
  value = aws_security_group.takahashi-web-sg.id
}

# Ansible SecurityGroup
resource "aws_security_group" "takahashi-ansible-sg" {
  name   = "takahashi-ansible-sg"
  vpc_id = var.vpc_id

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_ansible_id" {
  value = aws_security_group.takahashi-ansible-sg.id
}
