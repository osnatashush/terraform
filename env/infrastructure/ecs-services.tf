module "twingate_idf_service" {
  source  = "delivops/ecs-service/aws"
  version = "0.0.47"

  ecs_cluster_name = aws_ecs_cluster.infrastructure_ecs_cluster.name
  ecs_service_name = "twingate_idf"

  vpc_id             = local.vpc_id
  subnet_ids         = local.private_subnets_ids
  security_group_ids = [aws_security_group.infrastructure_ecs_sg.id]
}

module "twingate_service" {
  source  = "delivops/ecs-service/aws"
  version = "0.0.47"

  ecs_cluster_name = aws_ecs_cluster.infrastructure_ecs_cluster.name
  ecs_service_name = "twingate"

  vpc_id             = local.vpc_id
  subnet_ids         = local.private_subnets_ids
  security_group_ids = [aws_security_group.infrastructure_ecs_sg.id]
}
