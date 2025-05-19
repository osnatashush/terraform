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
    bucket         = "flycomm-terraform-tfstate"
    encrypt        = true
    key            = "staging/terraform.tfstate"
    region         = "eu-west-1"  
    dynamodb_table = "flycomm-terraform-tfstate-lock"
  }
}


