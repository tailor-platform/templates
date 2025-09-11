variable "client_id" {
  type = string
}

variable "provider_url" {
  type = string
}

variable "workspace_id" {
  type        = string
  description = "The workspace ID to use for all resources"
  default     = "ims"
}
