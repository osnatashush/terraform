resource "aws_security_group" "production_ecs_sg" {
  name        = "production-ecs-default-sg"
  description = "production security group"
  vpc_id      = local.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.vpc_cidr]
  } 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}