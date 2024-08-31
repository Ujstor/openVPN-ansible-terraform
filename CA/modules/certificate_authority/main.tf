resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem = tls_private_key.ca.private_key_pem

  subject {
    common_name         = var.certificate_authority.common_name
    country             = var.certificate_authority.country
    locality            = var.certificate_authority.locality
    organization        = var.certificate_authority.organization
    organizational_unit = var.certificate_authority.unit
  }

  validity_period_hours = var.certificate_authority.validity
  is_ca_certificate     = true

  allowed_uses = ["cert_signing", "crl_signing"]
}
