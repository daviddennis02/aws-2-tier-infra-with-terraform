# create loadbalancer
resource "aws_lb" "lab_lb" {
  name               = "lab-app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
  security_groups    = [aws_security_group.app_lb_sg.id]
}
# create lb target group resource
resource "aws_lb_target_group" "tg" {
  name     = "lab-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id


  depends_on = [aws_vpc.main]
}

# attach ec2 instance to elasic lb tg for both web_tier ec2 instances
resource "aws_lb_target_group_attachment" "tg_attach1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web_tier1.id
  port             = 80

  depends_on = [aws_instance.web_tier1]
}

resource "aws_lb_target_group_attachment" "tg_attach2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web_tier2.id
  port             = 80

  depends_on = [aws_instance.web_tier2]
}

# create ELB listener on LB with port 80
resource "aws_lb_listener" "listener_lb" {
  load_balancer_arn = aws_lb.lab_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
