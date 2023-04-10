locals {
  namespace_prefix = "wf-"
  namespace_suffix = var.env == "production" ? "" : "-${var.env}"
  namespace        = "${local.namespace_prefix}${var.project_slug}${local.namespace_suffix}"
  app_url          = var.hostname

  container = {
    app_limit_cpu    = "1000m"
    app_limit_memory = "512Mi"
    max_scale        = 3
    docker_image     = "code4romania/website-factory"
  }

  database = {
    name     = "${local.namespace}-db"
    version  = "POSTGRES_14"
    tier     = "db-f1-micro"
    username = "psqladmin"
  }
}
