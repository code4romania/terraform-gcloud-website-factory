output "web_app_hostname" {
  value = local.app_url
}

output "cloud_run_generated_url" {
  value = google_cloud_run_v2_service.web_app_backend.uri
}

output "cloud_run_message" {
  value = google_cloud_run_v2_service.web_app_backend.terminal_condition.*.message
}

output "cloud_run_domain_records" {
  value = google_cloud_run_domain_mapping.default[*].status.*.resource_records
}

output "admin_password" {
  value     = random_password.admin_password.result
  sensitive = true
}
