output "app_server_ip" {
  value = aws_instance.app_server.public_ip
}

output "bucket_name" {
  value = aws_s3_bucket.project_bucket.id  # Updated to use .id
}

output "db_endpoint" {
  value = aws_db_instance.project_db.endpoint
}

output "db_port" {
  value = aws_db_instance.project_db.port
}

output "db_username" {
  value = aws_db_instance.project_db.username
}

output "db_password" {
  value     = var.db_password
  sensitive = true
}
