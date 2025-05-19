terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 3.9.0"
    }
    aws = {
      version = ">= 4.67.0"
    }
  }
  required_version = ">=1.9.8"

  backend "s3" {
    bucket       = "<company-name>-terraform-tfstate"
    encrypt      = true
    key          = "staging/terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}


