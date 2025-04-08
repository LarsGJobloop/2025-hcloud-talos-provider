# Input Variables
variable "access_key" {
  description = "S3 access key"
  sensitive   = true
}

variable "secret_key" {
  description = "S3 secret key"
  sensitive   = true
}

# Needed by the backend configuration and not anywhere else.
variable "key" {
  description = "S3 bucket key (/path) for state file."
  default     = ""
}
# Known after local initialization
variable "bucket" {
  description = "S3 bucket identifier, generated. Found in <local.bucket_name>/output.bucket_name"
  default     = ""
}

locals {
  name     = "undervisning-gitops"
  location = "hel1"

  # Use a custom Hash based ID generator for persistent
  # identifiers, and decreases the likely hood of
  # someone being "smart" and couples their app
  # to the path.
  hash_input  = "${local.name}:${local.location}"
  hash_digest = sha256(local.hash_input)
  bucket_name = substr(local.hash_digest, 0, 16)
}
