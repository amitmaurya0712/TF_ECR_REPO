resource "aws_ecs_service" "ecs_task_service" {
  name = "ecs-task-service"
  cluster = aws_ecs_cluster.xenon_cluster.id 
  task_definition = aws_ecs_task_definition.xenon_image_task.id
  launch_type = "FARGATE"
  desired_count = 1

  network_configuration {
    subnets = [aws_subnet.public_subnet.id,
               aws_subnet.public_subnet_2b.id]
    assign_public_ip = true
    security_groups = [aws_security_group.alb_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg.arn 
    container_name = "xenon_image_task"
    container_port = 80

  }
}
