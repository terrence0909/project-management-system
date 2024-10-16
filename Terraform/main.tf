provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnets for EC2 and RDS
resource "aws_subnet" "main_subnet_az1" {
  vpc_id                     = aws_vpc.main_vpc.id
  cidr_block                 = "10.0.3.0/24"
  map_public_ip_on_launch    = true
  availability_zone          = "us-east-1a"
}

resource "aws_subnet" "main_subnet_az2" {
  vpc_id                     = aws_vpc.main_vpc.id
  cidr_block                 = "10.0.2.0/24"
  map_public_ip_on_launch    = true
  availability_zone          = "us-east-1b"
}

# Security Groups
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow inbound traffic for the EC2 instance"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Allow traffic for RDS instance"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance (Backend Server)
resource "aws_instance" "app_server" {
  ami                    = "ami-06b21ccaeff8cd686"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = aws_subnet.main_subnet_az1.id
  key_name               = "system-key"

  tags = {
    Name = "BackendEC2"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install python3-pip -y
              cd /home/ubuntu/
              git clone https://github.com/project-management-system/backend.git
              cd backend
              pip3 install -r requirements.txt
              python3 app.py
              EOF
}

# S3 Bucket (Project File Storage)
resource "aws_s3_bucket" "project_bucket" {
  bucket = "pm-system-bucket"

  tags = {
    Name        = "ProjectBucket"
    Environment = "Production"
  }
}

# S3 Bucket Policy
resource "aws_s3_bucket_policy" "project_bucket_policy" {
  bucket = aws_s3_bucket.project_bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "s3:GetObject",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::pm-system-bucket/*",
      "Principal": "*"
    }
  ]
}
EOF
}

# RDS (MySQL Database)
resource "aws_db_instance" "project_db" {
  allocated_storage       = 20
  engine                = "mysql"
  engine_version        = "5.7.44"
  instance_class        = "db.t3.micro"
  username              = var.db_username
  password              = var.db_password
  parameter_group_name  = "default.mysql5.7"
  skip_final_snapshot   = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name  = aws_db_subnet_group.main_db_subnet_group.name

  tags = {
    Name = "ProjectDB"
  }
}

# Database Subnet Group
resource "aws_db_subnet_group" "main_db_subnet_group" {
  name       = "main-db-subnet-group"
  subnet_ids = [
    aws_subnet.main_subnet_az1.id,
    aws_subnet.main_subnet_az2.id
  ]

  tags = {
    Name = "MainDBSubnetGroup"
  }
}
