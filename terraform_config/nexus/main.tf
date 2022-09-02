terraform {
  backend "kubernetes" {
    secret_suffix = "nexus-state"
    config_path   = "~/.kube/config"
  }

  required_providers {
    nexus = {
      source  = "datadrivers/nexus"
      version = "1.21.0"
    }

    onepassword = {
      source = "1Password/onepassword"
      version = "1.1.4"
    }
  }
}

provider "onepassword" {
  url = "https://dev-infra-craigmiller160/onepassword"
  token = var.onepassword_token
}

data "onepassword_item" "nexus_admin" {
  vault = "k6xneqw7nf5f2fm4azxhbdrcji"
  uuid = "p7w642mhmlyjf7k2myeik2buey"
}

#provider "nexus" {
#  insecure = true
#  password = var.nexus_admin_password
#  username = "admin"
#  url = join("", ["https://", var.nexus_host])
#}