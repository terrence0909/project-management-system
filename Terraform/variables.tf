variable "aws_region" {
  description = "The AWS region to deploy the resources"
  default     = "us-west-1"  # Change as needed
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}
