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
resource "aws_launch_template" "foobar" {

  name = "launch-terraform-ron"
  description = "Launch template creado con terraform"
  security_group_names = ["SG_AWS_Terraform"]
  key_name ="LLave-Ronmel"
  image_id      = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  tags = {
    Estudiante = "Ronmel"
    Name = "Tarea-Terraform_user"
  }
  
   user_data = "${filebase64("Userdata.sh")}"
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
