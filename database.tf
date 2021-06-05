resource "aws_db_instance" "desafio-terraform-db" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "${var.database_name}"
  username             = "${var.username_db}"
  password             = "${var.password_db}"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  port = "3334"
  vpc_security_group_ids = ["${aws_security_group.database-sg.id}"]
}