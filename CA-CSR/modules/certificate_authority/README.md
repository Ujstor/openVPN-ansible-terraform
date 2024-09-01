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
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_uses"></a> [allowed\_uses](#input\_allowed\_uses) | List of key usages allowed for the issued certificate. Values are defined in RFC 5280 | `list(string)` | n/a | yes |
| <a name="input_certificate_authority"></a> [certificate\_authority](#input\_certificate\_authority) | Object containing var for certificate authority. | <pre>object({<br>    common_name  = string<br>    country      = string<br>    locality     = string<br>    organization = string<br>    unit         = string<br>    validity     = number<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_authority_certificate"></a> [certificate\_authority\_certificate](#output\_certificate\_authority\_certificate) | Certificate authority private key |
| <a name="output_certificate_authority_private_key"></a> [certificate\_authority\_private\_key](#output\_certificate\_authority\_private\_key) | Certificate authority certificate |
