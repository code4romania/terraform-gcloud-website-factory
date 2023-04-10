output "web_app_hostname" {
  value = module.web_app.web_app_hostname
}

output "cloud_run_generated_url" {
  value = module.web_app.cloud_run_generated_url
}

output "cloud_run_domain_records" {
  value = module.web_app.cloud_run_domain_records
}

output "admin_password" {
  value     = module.web_app.admin_password
  sensitive = true
}
