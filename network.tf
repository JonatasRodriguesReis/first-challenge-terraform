resource "aws_internet_gateway" "desafio-terraform-igw" {
    vpc_id = "${aws_vpc.desafio-terraform-vpc.id}"
    tags = {
        Name = "desafio-terraform-igw"
    }
}

resource "aws_route_table" "desafio-terraform-crt" {
    vpc_id = "${aws_vpc.desafio-terraform-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"

        gateway_id = "${aws_internet_gateway.desafio-terraform-igw.id}"
    }

    tags = { 
        Name = "desafio-terraform-crt"
    }
}

resource "aws_route_table_association" "desafio-terraform-ctra-public-subnet-1" {
    subnet_id = "${aws_subnet.desafio-terraform-subnet-1.id}"
    route_table_id = "${aws_route_table.desafio-terraform-crt.id}"
}

resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.desafio-terraform-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
    //If you do not add this rule, you can not reach the NGIX  
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-allowed"
    }
}

resource "aws_security_group" "database-sg" {
   /*  vpc_id      = aws_vpc.main.id */
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    //If you do not add this rule, you can not reach the NGIX  
    ingress {
        from_port = 3334
        to_port = 3334
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "database-sg"
    }
}

