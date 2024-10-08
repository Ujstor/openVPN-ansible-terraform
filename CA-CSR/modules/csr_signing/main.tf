resource "tls_private_key" "server_client" {
  for_each  = var.server_client_certificates
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "tls_cert_request" "server_client" {
  for_each        = var.server_client_certificates
  private_key_pem = tls_private_key.server_client[each.key].private_key_pem

  subject {
    common_name         = each.value.common_name
    country             = each.value.country
    locality            = each.value.locality
    organization        = each.value.organization
    organizational_unit = each.value.unit
  }
}
resource "tls_locally_signed_cert" "server_client" {
  for_each = var.server_client_certificates

  cert_request_pem   = tls_cert_request.server_client[each.key].cert_request_pem
  ca_private_key_pem = var.ca_private_key
  ca_cert_pem        = var.ca_cert

  validity_period_hours = coalesce(each.value.validity, 8760)

  allowed_uses = var.allowed_uses
}
