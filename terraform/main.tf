provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "trainee_cluster" {
  name = "trainee-cluster"
}

resource "aws_ecs_task_definition" "trainee_task" {
  family                   = "trainee-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = <<DEFINITION
  [
    {
      "name": "trainee-api",
      "image": "your-dockerhub-user/trainee-api:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 5000,
          "hostPort": 5000
        }
      ]
    }
  ]
  DEFINITION
}