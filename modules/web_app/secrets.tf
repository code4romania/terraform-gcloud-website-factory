// db password
resource "google_secret_manager_secret" "db_password" {
  secret_id = "db_password"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "db_password_data" {
  secret      = google_secret_manager_secret.db_password.name
  secret_data = random_password.db_pass.result
}

resource "google_secret_manager_secret_iam_member" "db_secret_access" {
  secret_id  = google_secret_manager_secret.db_password.id
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
  depends_on = [google_secret_manager_secret.db_password]
}

resource "google_secret_manager_secret" "admin_password" {
  secret_id = "admin_password"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "admin_password_data" {
  secret      = google_secret_manager_secret.admin_password.name
  secret_data = random_password.admin_password.result
}

resource "google_secret_manager_secret_iam_member" "admin_secret_access" {
  secret_id  = google_secret_manager_secret.admin_password.id
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
  depends_on = [google_secret_manager_secret.admin_password]
}

// app key
resource "google_secret_manager_secret" "app_key" {
  secret_id = "app_key"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "app_key_data" {
  secret      = google_secret_manager_secret.app_key.name
  secret_data = random_password.app_key.result
}

resource "google_secret_manager_secret_iam_member" "app_key_access" {
  secret_id  = google_secret_manager_secret.app_key.id
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
  depends_on = [google_secret_manager_secret.app_key]
}

// mail password
resource "google_secret_manager_secret" "mail_password" {
  secret_id = "mail_password"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "mail_password_data" {
  secret      = google_secret_manager_secret.mail_password.name
  secret_data = var.mail_password
}

resource "google_secret_manager_secret_iam_member" "mail_password_access" {
  secret_id  = google_secret_manager_secret.mail_password.id
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
  depends_on = [google_secret_manager_secret.mail_password]
}
