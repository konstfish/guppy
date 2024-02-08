// Cloudflare

// create with permissions specified in https://github.com/STRRL/cloudflare-tunnel-ingress-controller
variable "cloudflare_api_token" {
  description = "The API Token for Cloudflare."
  type        = string
  sensitive   = true
}

variable "cloudflare_acount_id" {
  description = "The Cloudflare Account ID."
  type        = string
}

variable "cloudflare_tunnel_name" {
  description = "The name for the Cloudflare Tunnel (will be created by helm chart)."
  type        = string
  default     = "shoal"
}

// nfs
variable "nfs_server" {
  description = "The NFS server to use for persistent storage."
  type        = string
  default     = "10.0.1.1"
}

variable "nfs_path" {
  description = "The NFS path to use for persistent storage."
  type        = string
  default     = "/mnt/md0/stor"
}

variable "nfs_mount_options" {
  description = "The mount options to use for the NFS volume."
  type        = string
  default     = "rw,rsize=32768,wsize=32768,timeo=600"
}