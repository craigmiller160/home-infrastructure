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
}

#provider "nexus" {
#  insecure = true
#  password = var.nexus_admin_password
#  username = "admin"
#  url = join("", ["https://", var.nexus_host])
#}