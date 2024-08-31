variable "server_certificates" {
  description = "Map containing var for server certificates."
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
