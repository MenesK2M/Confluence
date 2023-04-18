resource "aws_instance" "Docker" {
  ami           = data.aws_ami.amz-ami-Docker.id
  instance_type = var.instance_type
  key_name      = var.key_name_linux
  tags = {
    "Name" = "Docker_server"
  }
  availability_zone = var.aws_availability_zone
  security_groups   = var.security_groups_linux
  user_data         = file("${path.module}/docker.sh")
}