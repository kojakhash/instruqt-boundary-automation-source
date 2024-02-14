output "ec2_first_addr" {
  value = aws_instance.target[0].public_ip
}

output "ec2_second_addr" {
  value = aws_instance.target[1].public_ip
}

output "db_name" {
  value = aws_db_instance.test.db_name
}

output "db_user" {
    value = var.db_username
}

output "db_pwd" {
  value = var.db_pwd
  sensitive = true
}

output "db_host" {
  value = aws_db_instance.test.address
}