output "instance_public_ip" {
  value = aws_instance.desafio-terraform-instance.public_ip
}

output "database_public_ip" {
  value = aws_db_instance.desafio-terraform-db.endpoint
}