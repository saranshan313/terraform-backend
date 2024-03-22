locals {
  regions = {
    "use1" = "us-east-1"
  }

  tags = {
    region = local.regions["use1"]
  }

}

provider "aws" {
  region = local.regions["use1"]
}

data "aws_caller_identity" "current" {}
