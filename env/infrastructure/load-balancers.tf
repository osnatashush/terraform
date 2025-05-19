locals {
  certificate_arn = "arn:aws:acm:eu-west-1:887063810123:certificate/6b3a3ff2-4b61-4a9b-a8b1-9f04dc2fc278"
}

module "infrastructure_internal_alb" {
  source   = "terraform-aws-modules/alb/aws"
  name     = "infrastructure-internal-alb"
  vpc_id   = local.vpc_id
  subnets  = local.private_subnets_ids
  internal = true
  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  listeners = {
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    ex-https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = local.certificate_arn
      fixed_response = {
        content_type = "text/plain"
        status_code  = "503"
      }
    }
  }
}