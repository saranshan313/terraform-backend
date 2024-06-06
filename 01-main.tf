locals {
  regions = {
    "use1"  = "us-east-1"
    "apse2" = "ap-southeast-2"
  }

  tags = {
    region = local.regions["use1"]
    #region = local.regions["apse2"]
  }

}

provider "aws" {
  region = local.regions["use1"]
  #region = local.regions["apse2"]
}

data "aws_caller_identity" "current" {}
