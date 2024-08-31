output "certificate_authority_private_key" {
  description = "Certificate authority certificate"
  value       = tls_self_signed_cert.ca.private_key_pem
}

output "certificate_authority_certificate" {
  description = "Certificate authority private key"
  value       = tls_self_signed_cert.ca.cert_pem
}
