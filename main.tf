// Config

terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.33.2"
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
  version = "1.0.1"

  hcloud_token              = var.hcloud_token
  public_key                = "~/.ssh/id_ed25519.pub"
  private_key               = null
  load_balancer_type        = "lb11"
  load_balancer_location    = "hel1"
  network_region            = "eu-central"
  allow_scheduling_on_control_plane = true
  control_plane_nodepools = [
    {
      name        = "control",
      server_type = "cx21",
      location    = "hel1",
      labels      = [],
      taints      = [],
      count       = 1
    }
  ]
  agent_nodepools = [
    {
      name        = "worker",
      server_type = "cx21",
      location    = "hel1",
      labels      = [],
      taints      = [],
      count       = 0
    }
  ]
  traefik_acme_tls                  = true
  traefik_acme_email                = var.traefik_acme_email
  automatically_upgrade_k3s         = false
  cluster_name                      = "k3s"
}
