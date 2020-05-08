# Web Server
resource "aws_instance" "takahashi-web" {
  ami           = var.ami_image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [
    var.security_group_web_id
  ]
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = "true"
  tags = {
    Name = "takahashi-web"
  }
}
