# This is the bootstrap module for requesting a backing
# bucket to store the main state file in. Colocated
# to ease managment of resources. Protected by a
# separate set of keys for security.

terraform {
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "3.3.0"
    }
  }

  # We need to start of with a local state
  # before the bucket is created and we can migrate
  # to the referenced bucket.
  # DO NOT FLIP THIS AFTER THE MAIN MODULE HAVE BEEN DEPLOYED!
  # Manual coordiation is required, and loss of data
  # is very possible!

  # backend "local" {
  #   path = "terraform.tfstate"
  # }

  backend "s3" {
    endpoints = {
      s3 = "https://hel1.your-objectstorage.com"
    }

    # Skip AWS configuration, not required by MinIO
    region                      = "hel1"
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true

    # Fixes
    use_path_style = true
    # Needs to be true until adopted by Hetzner
    # AWS adopted extra integrity checks (2025/01/15)
    # and others have not done/plan to do so.
    # https://docs.hetzner.com/storage/object-storage/getting-started/using-libraries/
    skip_s3_checksum = true
  }
}
