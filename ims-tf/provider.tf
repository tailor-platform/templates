terraform {
  required_providers {
    tailor = {
      source  = "tailor-platform/tailor"
      version = ">= 0.0.21"
    }
  }
}

provider "tailor" {
}
