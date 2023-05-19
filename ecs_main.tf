resource "aws_ecs_cluster" "xenon_cluster" {
    name = "xenon_cluster"
}


# resource "aws_ecs_task_definition" "xenon_image_task" {
#   family                   = "xenon_image_task"
  # requires_compatibilities = ["FARGATE"]
  # network_mode             = "awsvpc"
  # cpu                      = 1024
  # memory                   = 2048
  # execution_role_arn = aws_iam_role.ecsTaskExecutionRolenew.arn 
  # task_role_arn = aws_iam_role.ecsTaskExecutionRolenew.arn 
#   container_definitions    = <<TASK_DEFINITION
# [
#   {
#     "name": "xenon_image_task",
#     "image": "public.ecr.aws/l3d6n7r2/ecr_push_bitbucket_pipeline:1",
#     "cpu": 1024,
#     "memory": 2048,
#     "essential": true
#   }
# ]
# TASK_DEFINITION
# }

resource "aws_ecs_task_definition" "xenon_image_task" {
  family = "xenon_image_task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn = aws_iam_role.ecsTaskExecutionRolenew.arn 
  task_role_arn = aws_iam_role.ecsTaskExecutionRolenew.arn 
  container_definitions = jsonencode([
    # {
    #   name      = "first"
    #   image     = "service-first"
    #   cpu       = 500
    #   memory    = 512
    #   essential = true
    #   portMappings = [
    #     {
    #       containerPort = 80
    #       hostPort      = 80
    #     }
    #   ]
    # },
    {
      name      = "xenon_image_task"
      image     = "public.ecr.aws/l3d6n7r2/ecr_push_bitbucket_pipeline:1"
      cpu       = 500
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}


resource "aws_iam_role" "ecsTaskExecutionRolenew" {
  name               = "ecsTaskExecutionRolenew"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRolenew.name 
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
