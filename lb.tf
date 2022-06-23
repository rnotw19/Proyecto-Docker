
resource "aws_lb" "test" {
  name               = "LB-APPmario"
  internal           = false
  load_balancer_type = "application"
  ip_address_type = "ipv4"
  security_groups    = [aws_security_group.Allow_all.id]
  subnets            = data.Aws_subnets.idsubnets.id
 

  enable_deletion_protection = true

  tags = {
    Name  = "AWS_LB"
  Environment = "production"
     }

}

resource "aws_lb_listener" "Lb_listener" {
  load_balancer_arn = aws_lb.test.arn
  port =80
  protocol = "HTTP"
  default_action{
target_group_arn = aws_lb_target_group.t_group.arn
type = "forward"
  }
}
resource "aws_lb_target_group" "t_group" {

  
}
