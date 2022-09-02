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
  # TODO need to support prod
  url = "https://dev-infra-craigmiller160.ddns.net/onepassword"
  token = var.onepassword_token
}

provider "nexus" {
  password = data.onepassword_item.nexus_admin.password
  username = data.onepassword_item.nexus_admin.username
  # TODO need to support prod
  url = "https://dev-nexus-craigmiller160.ddns.net"
}