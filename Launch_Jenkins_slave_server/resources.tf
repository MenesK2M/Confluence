resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amz-ami-jenkins.id
  instance_type = var.instance_type
  key_name      = var.key_name_linux
  count         = 2
  tags = {
    "Name" = "agent-${count.index + 1}"
  }
  availability_zone = var.aws_availability_zone
  security_groups   = var.security_groups_linux
  user_data         = file("${path.module}/jenkins_slave.sh")
}
