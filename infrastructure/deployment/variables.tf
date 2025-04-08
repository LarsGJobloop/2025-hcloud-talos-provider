variable "hcloud_token" {
  description = "Hetzner API token"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "The prefix of the cluster"
  type        = string
}

variable "allowed_ip" {
  description = "IP address that is allowed to access the cluster"
  type        = list(string)
}
