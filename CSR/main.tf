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

module "csr_server" {
  source = "./modules/csr_signing_server/"

  server_certificates = {
    open_vpn = {
      common_name  = "vpn.ujstor.com"
      organization = "ujstor"
    }
  }

  ca_private_key = file("../CA/certs/ca_key.pem")
  ca_cert        = file("../CA/certs/ca.crt")
}

resource "null_resource" "server_key_cert" {
  for_each = module.csr_server.server_certificates

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
  source = "./modules/csr_signing_client"

  client_certificates = {
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

  ca_private_key = file("../CA/certs/ca_key.pem")
  ca_cert        = file("../CA/certs/ca.crt")
}

resource "null_resource" "client_key_cert" {
  for_each = module.csr_client.client_certificates

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
