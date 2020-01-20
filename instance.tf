data "template_file" "userdata" {
  template      = "${file("script.sh")}"
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t3.small"
  provisioner "local-exec" {
    command     = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }
}
connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

ebs_block_device {
    volume_size               = "${var.server-volume_size}"
    delete_on_termination     =  true
    device_name               = "/dev/xvda"
    encrypted                 =  false
  }
ebs_block_device {
    volume_size               = "${var.jenkins_server-volume_size}"
    delete_on_termination     =  true
    device_name               = "/dev/xvdf"
    encrypted                 =  false
  }

output "ip" {
  value                       = aws_instance.example.public_ip
}
