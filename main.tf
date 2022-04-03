// Config

terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.33.1"
    }
  }
}


variable "hcloud_token" {
  type      = string
  sensitive = true
}


variable "traefik_acme_email" {
  type      = string
  sensitive = true
}


module "kube-hetzner" {
  source  = "kube-hetzner/kube-hetzner/hcloud"
  version = "0.1.3"

  hcloud_token              = var.hcloud_token
  public_key                = "/home/andrey/.ssh/id_ed25519.pub"
  private_key               = null
  location                  = "hel1"
  network_region            = "eu-central"
  control_plane_count       = 1
  control_plane_server_type = "cpx11"
  agent_nodepools = [
    {
      name        = "worker",
      server_type = "cx21",
      count       = 1
    }
  ]
  load_balancer_type                = "lb11"
  traefik_acme_tls                  = true
  traefik_acme_email                = var.traefik_acme_email
  allow_scheduling_on_control_plane = true
  automatically_upgrade_k3s         = false
  cluster_name                      = "k3s"
}
