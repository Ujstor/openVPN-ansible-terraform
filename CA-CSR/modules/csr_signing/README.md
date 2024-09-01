## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tls_cert_request.server_client](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.server_client](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.server_client](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_uses"></a> [allowed\_uses](#input\_allowed\_uses) | List of key usages allowed for the issued certificate. Values are defined in RFC 5280 | `list(string)` | n/a | yes |
| <a name="input_ca_cert"></a> [ca\_cert](#input\_ca\_cert) | n/a | `string` | n/a | yes |
| <a name="input_ca_private_key"></a> [ca\_private\_key](#input\_ca\_private\_key) | n/a | `string` | n/a | yes |
| <a name="input_server_client_certificates"></a> [server\_client\_certificates](#input\_server\_client\_certificates) | Map containing var for client certificates. | <pre>map(object({<br>    common_name  = optional(string)<br>    country      = optional(string)<br>    locality     = optional(string)<br>    organization = optional(string)<br>    unit         = optional(string)<br>    validity     = optional(number)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_server_client_certificates"></a> [server\_client\_certificates](#output\_server\_client\_certificates) | Map of certificates with private\_key, certificate, csr |
