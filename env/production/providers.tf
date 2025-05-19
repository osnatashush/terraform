provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "Environment" = "production"
      "Terraform"   = "true"
      "Region"      = var.aws_region
    }
  }
}
