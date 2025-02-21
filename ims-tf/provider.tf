terraform {
  required_providers {
    tailor = {
      source  = "tailor-platform/tailor"
      version = ">= 0.0.24"
    }
  }
}

provider "tailor" {
}
