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


resource "aws_security_group" "Allow_all" {
  name        = "SG_AWS_Pmario"
  description = "grupo de seguridad creado con terraform"
  

  ingress {
    
    from_port        = 8600
    to_port          = 8600
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

     ingress {
    
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Nuevo_SG"
  }
}


resource "aws_autoscaling_group" "bar" {
 name = "AG-terraform-ron"
  availability_zones = ["us-east-1a","us-east-1b","us-east-1c"]
  desired_capacity   = 1
  max_size           = 4
  min_size           = 1

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
  tags = [
    {
      key                 = "Name"
      value               = "Pro_Mario_Ronmel"
      propagate_at_launch = true
    },
  ]
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

