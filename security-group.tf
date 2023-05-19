resource "aws_security_group" "alb_sg" {
  name        = "application-load-balancer-sg"
  description = "application-load-balancer-sg"
  vpc_id      = aws_vpc.new_vpc.id 

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ecs_alb_sg"
  }
}

resource "aws_security_group" "ecs_tasks" {
  name        = "ecs-tasks-sg"
  description = "ecs-tasks-sg"
  vpc_id      = aws_vpc.new_vpc.id 

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
    }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ecs_tasks_sg"
  }
}
