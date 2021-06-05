resource "aws_vpc" "desafio-terraform-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"
    tags = {
        Name = "desafio-terraform-vpc"
    }
}

resource "aws_subnet" "desafio-terraform-subnet-1" {
    vpc_id = "${aws_vpc.desafio-terraform-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags = {
        Name = "desafio-terraform-subnet-1"
    }
}