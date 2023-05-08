resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amz-ami-jenkins.id
  instance_type = var.instance_type
  key_name      = var.key_name_linux
  count         = 2
  tags = {
    "Name" = "Jenkins_server-${count.index + 1}"
  }
  availability_zone = var.aws_availability_zone
  security_groups   = var.security_groups_linux
  user_data         = file("${path.module}/jenkins.sh")

}

resource "null_resource" "master" {
  depends_on = [aws_instance.jenkins]
  triggers = {
    change = timestamp()
  }


  connection {
    agent       = false
    type        = "ssh"
    user        = "ec2-user"
    password    = ""
    host        = element(aws_instance.jenkins.*.public_ip, 0)
    private_key = file("${path.module}/key.pem")
  }

  provisioner "file" {
    source      = "jenkins_master.sh"
    destination = "/home/ec2-user/jenkins_master.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 700 /home/ec2-user/jenkins_master.sh",
      "bash -x /home/ec2-user/jenkins_master.sh",
      "sleep 120",
      "sudo systemctl enable --now jenkins"
    ]

    on_failure = continue
  }
}

resource "null_resource" "slaves" {
  depends_on = [aws_instance.jenkins]
  triggers = {
    change = timestamp()
  }
  count = length(aws_instance.jenkins) > 1 ? length(aws_instance.jenkins) - 1 : 0


  connection {
    agent       = false
    type        = "ssh"
    user        = "ec2-user"
    password    = ""
    host        = element(aws_instance.jenkins.*.public_ip, count.index + 1)
    private_key = file("${path.module}/key.pem")
  }

  provisioner "file" {
    source      = "jenkins_slaves.sh"
    destination = "/home/ec2-user/jenkins_slaves.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 700 /home/ec2-user/jenkins_slaves.sh",
      "bash -x /home/ec2-user/jenkins_slaves.sh",
    ]
    on_failure = continue
  }
}
