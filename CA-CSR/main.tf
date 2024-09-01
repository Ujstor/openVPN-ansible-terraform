terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
  required_version = ">= 1.0.0, < 2.0.0"
}

module "ca" {
  source = "./modules/certificate_authority/"

  certificate_authority = {
    common_name  = "ujstor.com"
    country      = "HR"
    locality     = "Zagreb"
    organization = "ujstor"
    unit         = "openvpn"
    validity     = 87600
  }

  allowed_uses = ["cert_signing", "crl_signing"]
}

resource "null_resource" "ca_key_cert" {
  provisioner "local-exec" {
    command = <<-EOT
	mkdir -p certs/ca
	echo "${module.ca.certificate_authority_private_key}" > certs/ca/ca_key.pem &&
	echo "${module.ca.certificate_authority_certificate}" > certs/ca/ca.crt &&
	chmod 600 certs/ca/ca_key.pem &&
	chmod 600 certs/ca/ca.crt
   EOT
  }
}

module "csr_server" {
  source = "./modules/csr_signing/"

  server_client_certificates = {
    open_vpn = {
      common_name  = "vpn.ujstor.com"
      organization = "ujstor"
    }
  }

  allowed_uses = ["server_auth", "digital_signature", "key_encipherment"]

  ca_private_key = module.ca.certificate_authority_private_key
  ca_cert        = module.ca.certificate_authority_certificate
}

resource "null_resource" "server_key_cert" {
  for_each = module.csr_server.server_client_certificates

  provisioner "local-exec" {
    command = <<-EOT
      mkdir -p certs/server_certs/${each.key}	
      echo "${each.value.private_key}" > certs/server_certs/${each.key}/${each.key}_key.pem
      echo "${each.value.certificate}" > certs/server_certs/${each.key}/${each.key}.crt
      chmod 600 certs/server_certs/${each.key}/${each.key}_key.pem
      chmod 600 certs/server_certs/${each.key}/${each.key}.crt
    EOT
  }
}

module "csr_client" {
  source = "./modules/csr_signing"

  server_client_certificates = {
    phone_1 = {
      common_name  = "vpn.ujstor.com"
      organization = "ujstor"
      unit         = "phone-1"
    }
    phone_2 = {
      common_name  = "vpn.ujstor.com"
      organization = "ujstor"
      unit         = "phone-2"
    }
    pc_1 = {
      common_name  = "vpn.ujstor.com"
      organization = "ujstor"
      unit         = "pc-1"
    }
  }

  allowed_uses = ["client_auth", "digital_signature", "key_encipherment"]

  ca_private_key = module.ca.certificate_authority_private_key
  ca_cert        = module.ca.certificate_authority_certificate
}

resource "null_resource" "client_key_cert" {
  for_each = module.csr_client.server_client_certificates

  provisioner "local-exec" {
    command = <<-EOT
      mkdir -p certs/client_certs/${each.key}	
      echo "${each.value.private_key}" > certs/client_certs/${each.key}/${each.key}_key.pem
      echo "${each.value.certificate}" > certs/client_certs/${each.key}/${each.key}.crt
      chmod 600 certs/client_certs/${each.key}/${each.key}_key.pem
      chmod 600 certs/client_certs/${each.key}/${each.key}.crt
    EOT
  }
}
