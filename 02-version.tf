terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  # backend "s3" {
  #   bucket         = "tf-remote-state-234-343-555"
  #   key            = "backend/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-remote-state-dynamo"
  #   encrypt        = true
  # }
}
