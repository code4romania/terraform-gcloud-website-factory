resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

resource "google_storage_bucket" "assets" {
  name                        = "${local.namespace}-${random_string.bucket_suffix.result}"
  location                    = "EU"
  force_destroy               = true
  storage_class               = "MULTI_REGIONAL"
  uniform_bucket_level_access = true

  labels = {
    app = var.project_slug
    env = var.env
  }
}

resource "google_storage_bucket_iam_member" "cloud_run_member" {
  bucket = google_storage_bucket.assets.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
}
