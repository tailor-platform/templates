terraform {
  required_providers {
    tailor = {
      source  = "tailor-platform/tailor"
      version = ">= 0.0.17"
    }
  }
}

provider "tailor" {
  pat = var.pat
}
