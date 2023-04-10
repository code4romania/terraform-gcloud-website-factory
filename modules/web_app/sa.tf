resource "google_service_account" "cloud_run_service_account" {
  account_id   = "${local.namespace}-sa"
  display_name = "Cloud Run Service Account"
  description  = "Service Account for Cloud Run web app"
}
