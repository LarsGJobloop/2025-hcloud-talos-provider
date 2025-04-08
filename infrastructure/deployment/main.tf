module "talos" {
  source  = "hcloud-talos/talos/hcloud"
  version = "2.15.0"
  # Security
  hcloud_token              = var.hcloud_token
  firewall_kube_api_source  = var.allowed_ip
  firewall_talos_api_source = var.allowed_ip

  # Meta information
  cluster_name       = var.cluster_name
  datacenter_name    = "hel1-dc2"

  # Versioning
  talos_version      = "v1.9.5"
  kubernetes_version = "1.30.3"
  cilium_version     = "1.16.2"

  # Configuration
  control_plane_count       = 1
  control_plane_server_type = "cax21"
  worker_count              = 2
  worker_server_type        = "cax21"
  enable_ipv6 = false
}