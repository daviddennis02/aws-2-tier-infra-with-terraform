terraform {
  cloud {
    organization = "CloudTrybe"

    workspaces {
      name = "devops-aws-lab"
    }
  }
}