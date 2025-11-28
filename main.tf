terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "sam-s-tf-state"
    key = "terraform-public.tfstate"
    region = "eu-west-1"
  }
}

provider "github" {}

provider "vault" {
  add_address_to_env = true
}
