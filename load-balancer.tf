resource "aws_lb" "xenon_lb" {
  name               = "xenon-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id] 
  subnets            = [
                        aws_subnet.public_subnet.id ,
                        aws_subnet.public_subnet_2b.id
                       ]

  tags = {
    Environment = "xenon-alb"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "xenon-alb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.new_vpc.id 
}

# resource "aws_lb_listener" "alb_listener" {
#   load_balancer_arn = aws_lb.xenon_lb.id 
#   port = "80"
#   protocol = "HTTP"

#   default_action {
#     ty
#   }
# }
