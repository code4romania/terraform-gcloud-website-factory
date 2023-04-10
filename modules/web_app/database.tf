resource "google_sql_database_instance" "instance" {
  name             = local.database.name
  database_version = local.database.version

  settings {
    user_labels = {
      app = var.project_slug
      env = var.env
    }
    tier = local.database.tier
    backup_configuration {
      enabled = true
    }
    ip_configuration {
      private_network                               = data.google_compute_network.default.id
      ipv4_enabled                                  = false
      enable_private_path_for_google_cloud_services = true
    }
  }

  deletion_protection = "true"

  depends_on = [google_service_networking_connection.private_vpc_connection]
}


resource "google_sql_database" "db" {
  name     = local.database.name
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "local_user" {
  instance = google_sql_database_instance.instance.name
  name     = local.database.username
  password = random_password.db_pass.result
}
