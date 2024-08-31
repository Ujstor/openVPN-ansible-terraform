output "server_certificates" {
  description = "Map of server certificates with private_key, certificate, csr"
  value = {
    for key, _ in var.server_certificates :
    key => {
      certificate = tls_locally_signed_cert.server[key].cert_pem
      csr         = tls_cert_request.server[key].cert_request_pem
      private_key = tls_private_key.server[key].private_key_pem
    }
  }
}
