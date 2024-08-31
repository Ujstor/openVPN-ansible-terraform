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

}

resource "null_resource" "ca_key_cert" {
  provisioner "local-exec" {
    command = <<-EOT
	mkdir -p certs 
	echo "${module.ca.certificate_authority_private_key}" > certs/ca_key.pem &&
	echo "${module.ca.certificate_authority_certificate}" > certs/ca.crt &&
	chmod 600 certs/ca_key.pem &&
	chmod 600 certs/ca.crt
   EOT
  }
}
