locals {
    vpc_id = "vpc-0ce6a3a5cd0a49dbd"
    private_subnets_ids = ["subnet-0cb599ffbdd82bd4d", "subnet-0e61f6ae671bfed80", "subnet-081a90cefbb3d6c8d"]
    public_subnets_ids = ["subnet-06867f1d689911e64", "subnet-0e0933d0ba64b035b", "subnet-09053e5ff2ec8ed7d" ]
    default_security_grpup_id = "sg-0566af31f218d8262"
    vpc_cidr = "10.0.0.0/16"
    env = "staging"
    listener_arn_internal = "arn:aws:elasticloadbalancing:eu-west-1:887063810123:listener/app/staging-internal-alb/533967b812f86ff5/a5cc67fad490cf35"
    listener_arn_external = "arn:aws:elasticloadbalancing:eu-west-1:887063810123:listener/app/staging-external-alb/ea0f86dc5beab3aa/4ee85fbdcb82bac6"
    cluster_name = "staging"
}