resource "google_cloud_run_v2_service" "web_app_backend" {
  name     = local.namespace
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  labels = {
    app = var.project_slug
    env = var.env
  }

  template {
    execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
    service_account       = google_service_account.cloud_run_service_account.email
    labels = {
      app = var.project_slug
      env = var.env
    }

    scaling {
      max_instance_count = local.container.max_scale
      min_instance_count = local.container.min_scale
    }

    vpc_access {
      connector = google_vpc_access_connector.cloudrun_vpc_serverless.id
      egress    = "PRIVATE_RANGES_ONLY"
    }

    containers {
      image = "${local.container.docker_image}:${var.docker_tag}"
      ports {
        container_port = 80
      }
      resources {
        limits = {
          cpu    = local.container.app_limit_cpu
          memory = local.container.app_limit_memory
        }
      }
      startup_probe {
        period_seconds        = 30
        initial_delay_seconds = 30
        tcp_socket {
          port = 80
        }
      }
      liveness_probe {
        http_get {
          path = "/health"
        }
      }
      env {
        name  = "APP_URL"
        value = local.app_url
      }
      env {
        name  = "APP_DEBUG"
        value = var.debug_mode
      }
      env {
        name  = "APP_ENV"
        value = var.env
      }
      env {
        name = "APP_KEY"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.app_key.secret_id
            version = "latest"
          }
        }
      }
      env {
        name  = "WEBSITE_FACTORY_EDITION"
        value = var.edition
      }
      env {
        name  = "DB_CONNECTION"
        value = "pgsql"
      }
      env {
        name  = "DB_HOST"
        value = google_sql_database_instance.instance.private_ip_address
      }
      env {
        name  = "DB_PORT"
        value = "5432"
      }
      env {
        name  = "DB_DATABASE"
        value = local.database.name
      }
      env {
        name  = "DB_USERNAME"
        value = google_sql_user.local_user.name
      }
      env {
        name = "DB_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.db_password.secret_id
            version = "latest"
          }
        }
      }
      env {
        name  = "MAIL_MAILER"
        value = "smtp"
      }
      env {
        name  = "MAIL_HOST"
        value = var.mail_host
      }
      env {
        name  = "MAIL_PORT"
        value = var.mail_port
      }
      env {
        name  = "MAIL_USERNAME"
        value = var.mail_username
      }
      env {
        name = "MAIL_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.mail_password.secret_id
            version = "latest"
          }
        }
      }
      env {
        name  = "MAIL_ENCRYPTION"
        value = var.mail_encryption
      }
      env {
        name  = "MAIL_FROM_ADDRESS"
        value = var.mail_from_address
      }
      env {
        name  = "FILESYSTEM_DRIVER"
        value = "gcs"
      }
      env {
        name  = "FILESYSTEM_CLOUD"
        value = "gcs"
      }
      env {
        name  = "GOOGLE_CLOUD_STORAGE_BUCKET"
        value = google_storage_bucket.assets.name
      }
      env {
        name  = "ADMIN_EMAIL"
        value = var.admin_email
      }
      env {
        name = "ADMIN_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.admin_password.secret_id
            version = "latest"
          }
        }
      }
    }
  }

  depends_on = [google_secret_manager_secret_version.db_password_data, google_secret_manager_secret_version.app_key_data, google_secret_manager_secret_version.admin_password_data]
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_v2_service.web_app_backend.location
  project  = google_cloud_run_v2_service.web_app_backend.project
  service  = google_cloud_run_v2_service.web_app_backend.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_domain_mapping" "default" {
  location = google_cloud_run_v2_service.web_app_backend.location
  name     = var.hostname
  count    = var.hostname != null ? 1 : 0
  metadata {
    namespace = var.project_id
  }

  spec {
    route_name = google_cloud_run_v2_service.web_app_backend.name
  }
}
