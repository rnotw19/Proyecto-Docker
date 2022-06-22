terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

variable "my_access_key" {
  description = "Access-key-for-AWS"
  default = "no_access_key_value_found"
}
 
variable "my_secret_key" {
  description = "Secret-key-for-AWS"
  default = "no_secret_key_value_found"
}
 
output "access_key_is" {
  value = var.my_access_key
}
 
output "secret_key_is" {
  value = var.my_secret_key
}
 
provider "aws" {
	region = "eu-west-3"
	access_key = var.my_access_key
	secret_key = var.my_secret_key
}

resource "aws_instance" "app_server" {
count = 2
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  key_name = "LLave-Ronmel"
  security_groups = ["launch-wizard-6-Kelvin"]
  user_data = "${file("Userdata.sh")}"

  tags = {
    Name = "Terraform-Chat-app"
  }
}
resource "aws_lb" "test" {
  name               = "LB-APPmario"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}
