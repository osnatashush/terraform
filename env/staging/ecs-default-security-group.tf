resource "aws_security_group" "staging_ecs_sg" {
  name        = "staging-ecs-default-sg"
  description = "staging security group"
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