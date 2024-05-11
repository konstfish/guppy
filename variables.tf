// Setup
variable "github_usernames" {
  description = "List of GitHub usernames"
  type        = list(string)
}

// Cluster Settings
/// General
variable "cluster_name" {
  description = "The name of the cluster."
  type        = string
  default     = "tetra"
}

variable "cluster_k3s_version" {
  description = "Cluster version"
  type        = string
  default     = "v1.27.6+k3s1"
}

// REPLACE WITH YOUR OWN TOKEN
variable "cluster_token" {
  description = "Cluster token"
  type        = string
  default     = "asdf"
}

// Cloudflare
variable "cloudflare_api_token" {
  description = "The API Token for Cloudflare."
  type        = string
  sensitive   = true
}

variable "cloudflare_acount_id" {
  description = "The Cloudflare Account ID."
  type        = string
}

// longhorn
variable "longhorn_s3_access_key" {
  description = "The Access Key ID for the Longhorn S3 backup."
  type        = string
  sensitive   = true
}

variable "longhorn_s3_secret_key" {
  description = "The Secret Key for the Longhorn S3 backup."
  type        = string
  sensitive   = true
}

variable "longhorn_s3_endpoint" {
  description = "The S3 endpoint to use for Longhorn backups."
  type        = string
}

variable "longhorn_s3_bucket" {
  description = "The S3 bucket to use for Longhorn backups."
  type        = string
}