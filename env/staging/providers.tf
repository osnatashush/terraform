provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "Environment" = "staging"
      "Terraform"   = "true"
      "Region"      = var.aws_region
    }
  }
}
