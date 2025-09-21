output "bastion_public_ip" {
 description = "public ip of bastion host" 
 value = aws_instance.bastion.public_ip
}

output "bastion_id" {
    description = "id of bastion"
    value = aws_instance.bastion.id

}

output "private_ip_app1" {
  description = "priavte ip of app1"
  value = aws_instance.first_app.private_ip
}

output "private_ip_app2" {
  description = "priavte ip of app2"
  value = aws_instance.second_app.private_ip
}

output "id_app1" {
  description = "ID of app 1"
  value = aws_instance.first_app.id
}

output "id_app2" {
  description = "ID of app 2"
  value = aws_instance.second_app.id
}