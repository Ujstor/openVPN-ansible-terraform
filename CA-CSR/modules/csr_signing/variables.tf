variable "server_client_certificates" {
  description = "Map containing var for client certificates."
  type = map(object({
    common_name  = optional(string)
    country      = optional(string)
    locality     = optional(string)
    organization = optional(string)
    unit         = optional(string)
    validity     = optional(number)
  }))
}

variable "ca_private_key" {
  type = string
}

variable "ca_cert" {
  type = string
}

variable "allowed_uses" {
  description = "List of key usages allowed for the issued certificate. Values are defined in RFC 5280"
  type        = list(string)
}
