output "server_client_certificates" {
  description = "Map of certificates with private_key, certificate, csr"
  value = {
    for key, _ in var.server_client_certificates :
    key => {
      certificate = tls_locally_signed_cert.server_client[key].cert_pem
      csr         = tls_cert_request.server_client[key].cert_request_pem
      private_key = tls_private_key.server_client[key].private_key_pem
    }
  }
}
