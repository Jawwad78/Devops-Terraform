output "rds_database_endpoint" {
  description = "rds id"
  value = aws_db_instance.rds.endpoint
}