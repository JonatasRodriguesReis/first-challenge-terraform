data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "desafio-terraform-instance" {

    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"

    # VPC
    subnet_id = "${aws_subnet.desafio-terraform-subnet-1.id}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

    # the Public SSH key
    key_name = "${aws_key_pair.desafio-terraform-aws-pair.id}"

    # nginx installation
    provisioner "file" {
        source = "nginx.sh"
        destination = "/tmp/nginx.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/nginx.sh",
            "sudo /tmp/nginx.sh"
        ]
    }

    connection {
        type = "ssh"
        user = "${var.EC2_USER}"
        host = "${self.public_ip}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
        timeout = "10m"
    }

    tags = {
        Name = "desafio-terraform-instance"
    }
}

resource "aws_key_pair" "desafio-terraform-aws-pair" {
    key_name = "desafio-terraform-aws-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}