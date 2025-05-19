module "sites_propagation_service" {
  source                     = "delivops/ecs-service/aws"
  version                    = "0.1.16"
  ecs_cluster_name           = "staging"
  ecs_service_name           = "sites_propagation"
  capacity_provider_strategy = "FARGATE_SPOT"
  vpc_id                     = local.vpc_id
  subnet_ids                 = local.private_subnets_ids
  security_group_ids         = [aws_security_group.staging_ecs_sg.id]
  sqs_auto_scaling = {
    enabled             = true
    min_replicas        = 0
    max_replicas        = 20
    scale_in_cooldown   = 60
    scale_out_cooldown  = 60
    scale_in_step       = 20
    scale_out_step      = 20
    scale_in_threshold  = 1
    scale_out_threshold = 0
    queue_name          = "stage-create-sites-propagation"
  }
  schedule_auto_scaling = {
    enabled = true
    schedules = [
      {
        schedule_name       = "scale-up-morning"
        min_replicas        = 0
        max_replicas        = 20
        schedule_expression = "cron(0 9 ? * SUN-THU *)"
      },
      {
        schedule_name       = "scale-down-night"
        min_replicas        = 0
        max_replicas        = 0
        schedule_expression = "cron(0 20 * * ? *)"
      }
    ]
  }
  ecr = {
    create_repo        = true
    tagged_ttl_days    = 30
    versioned_prefixes = ["sha"]
  }
}
