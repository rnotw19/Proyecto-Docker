
resource "aws_lb" "test" {
  name               = "LB-APPmario"
  internal           = false
  load_balancer_type = "application"
  ip_address_type = "ipv4"
  security_groups    = [aws_security_group.Allow_all.id]
  subnets            = data.aws_subnet_ids.subnet.ids
 

  enable_deletion_protection = false

  tags = {
    Name  = "AWS_LB"
  Environment = "production"
     }

}
  


#Autoscaling Attachment
resource "aws_autoscaling_attachment" "svc_asg_external2" {
  alb_target_group_arn   = "${aws_lb_target_group.t_group.arn}"
  autoscaling_group_name = "${aws_autoscaling_group.bar.id}"
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
    name = "tg-Proyecto-ron"
    port = 8600
    protocol = "HTTP"
    vpc_id=data.aws_vpc.default.id
    
health_check {
  interval = 10
  path = "/"
  protocol = "HTTP"
  timeout = 5
  healthy_threshold = 5
  unhealthy_threshold = 2
}
  
}
