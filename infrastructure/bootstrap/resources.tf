provider "minio" {
  minio_server   = "${local.location}.your-objectstorage.com"
  minio_user     = var.access_key
  minio_password = var.secret_key
  minio_region   = local.location
  minio_ssl      = true
}

resource "minio_s3_bucket" "project-state" {
  bucket = local.bucket_name
  acl    = "private"

  object_locking = false
  lifecycle {
    # Setting this to true, adds an additional layer
    # of surity, so no one accidentally deletes it
    prevent_destroy = true
  }
}
