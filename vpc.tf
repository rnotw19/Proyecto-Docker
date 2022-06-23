data "aws_availability_zones" "default" {
    
}


data "aws_vpc" "available" {
  
  state = "available"
}

data "Aws_subnets" "idsubnets" {
  vpc_id = data.aws_vpc.available.id
}