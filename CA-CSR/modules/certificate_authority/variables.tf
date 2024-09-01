variable "certificate_authority" {
  description = "Object containing var for certificate authority."
  type = object({
    common_name  = string
    country      = string
    locality     = string
    organization = string
    unit         = string
    validity     = number
  })
}

variable "allowed_uses" {
  description = "List of key usages allowed for the issued certificate. Values are defined in RFC 5280"
  type        = list(string)
}
