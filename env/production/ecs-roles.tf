module "ecs_task_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.0"
 
  create_role = true
  role_name   = "${local.env}-ecs-execution-role"

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWriteAccess"
  ]
 
  role_requires_mfa = false

  inline_policy_statements = [
    {
      effect    = "Allow"
      actions   = [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds",
        "secretsmanager:ListSecrets"
      ]
      resources = ["*"]
    },
    {
      effect    = "Allow"
      actions   = [
        "sqs:*"
      ]
      resources = ["*"]
    },
    {
      effect    = "Allow"
      actions   = [
        "s3:ListBucket"
      ]
      resources = ["*"]
    },
    {
      effect    = "Allow"
      actions   = [
        "s3:*Object"
      ]
      resources = ["*"]
    }
  ]

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]
}