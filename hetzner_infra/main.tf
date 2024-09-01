module "ssh_key" {
  source = "github.com/Ujstor/self-hosting-infrastructure-cluster//modules/modules/ssh_key?ref=v0.0.2"

  ssh_key_name = "openvpn.pem"
  ssh_key_path = "~/.ssh"
}

module "openvpn_server" {
  source = "github.com/Ujstor/self-hosting-infrastructure-cluster//modules/modules/worker?ref=v0.0.2"

  hcloud_ssh_key_id = [module.ssh_key.hcloud_ssh_key_id]
  os_type           = "debian-12"

  worker_config = {
    master-1 = {
      location     = "fsn1"
      server_type  = "cx22"
      labels       = "openvpn"
      ipv4_enabled = true
      ipv6_enabled = false
    }
  }

  depends_on = [module.ssh_key]
}

module "cloudflare_record" {
  source = "github.com/Ujstor/self-hosting-infrastructure-cluster//modules/modules/network/cloudflare_record?ref=v0.0.2"

  cloudflare_record = {
    vpn = {
      zone_id = var.cloudflare_zone_id
      name    = "vpn"
      value   = module.openvpn_server.worker_info.master-1.ip
      type    = "A"
      ttl     = 1
      proxied = true
    }

    depends_on = [module.openvpn_server]
  }
}
