resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amz-ami-jenkins.id
  instance_type = var.instance_type
  key_name      = var.key_name_linux
  tags = {
    "Name" = "Jenkins_server"
  }
  availability_zone = var.aws_availability_zone
  security_groups   = var.security_groups_linux
  user_data         = file("${path.module}/jenkins.sh")
}
