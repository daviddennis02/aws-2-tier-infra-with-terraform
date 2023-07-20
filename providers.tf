terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.2.0"
}

# provider "aws" {
#   shared_config_files = ["/Users/ddennis/.aws/config"]
#   shared_credentials_files = ["/Users/ddennis/.aws/credentials"]
#   region = "us-east-1"
#   profile = "admin01"
# }

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}