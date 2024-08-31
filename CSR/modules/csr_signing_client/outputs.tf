output "client_certificates" {
  description = "Map of client certificates with private_key, certificate, csr"
  value = {
    for key, _ in var.client_certificates :
    key => {
      certificate = tls_locally_signed_cert.client[key].cert_pem
      csr         = tls_cert_request.client[key].cert_request_pem
      private_key = tls_private_key.client[key].private_key_pem
    }
  }
}
