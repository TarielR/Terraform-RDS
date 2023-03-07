provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket  = "tariel-remote-state"
    key     = "rds/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
