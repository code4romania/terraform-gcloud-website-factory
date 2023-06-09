module "web_app" {
  source = "./modules/web_app"

  # Input Variables
  docker_tag        = var.docker_tag
  edition           = var.edition
  hostname          = var.hostname
  env               = var.env
  project_id        = var.project_id
  project_slug      = var.project_slug
  region            = var.region
  debug_mode        = var.debug_mode
  mail_host         = var.mail_host
  mail_port         = var.mail_port
  mail_username     = var.mail_username
  mail_password     = var.mail_password
  mail_encryption   = var.mail_encryption
  mail_from_address = var.mail_from_address
  admin_email       = var.admin_email
  min_scale         = var.min_scale
  max_scale         = var.max_scale
}
