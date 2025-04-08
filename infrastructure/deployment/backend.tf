terraform {

  backend "local" {
    path = "terraform.tfstate"
  }
  # backend "s3" {
  #   endpoints = {
  #     s3 = "https://hel1.your-objectstorage.com"
  #   }

  #   # Skip AWS configuration, not required by MinIO
  #   region                      = "hel1"
  #   skip_credentials_validation = true
  #   skip_requesting_account_id  = true
  #   skip_metadata_api_check     = true
  #   skip_region_validation      = true
  #   use_path_style              = true
  #   skip_s3_checksum            = true
  # }
}
