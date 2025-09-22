output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = module.ec2.bastion_public_ip
}

output "app1_id" {
  description = "ID of app server 1"
  value       = module.ec2.id_app1
}

output "app2_id" {
  description = "ID of app server 2"
  value       = module.ec2.id_app2
}
