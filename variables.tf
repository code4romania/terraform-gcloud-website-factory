variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "docker_tag" {
  description = "Docker image tag"
  type        = string
  default     = "1.3.14"
}

variable "project_slug" {
  description = "Project slug"
  type        = string
}

variable "edition" {
  description = "Website Factory edition to deploy"
  type        = string
  default     = "ong"
}

variable "hostname" {
  description = "Domain for website factory web app"
  type        = string
  default     = null
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "production"
}

variable "debug_mode" {
  description = "Enable debug mode"
  type        = bool
  default     = false
}

variable "region" {
  description = "Region where to deploy resources"
  type        = string
  default     = "europe-west1"
}

variable "mail_host" {
  description = "SMTP host"
  type        = string
  default     = "smtp.sendgrid.net"
}

variable "mail_port" {
  description = "SMTP port"
  type        = string
  default     = 587
}

variable "mail_username" {
  description = "SMTP username"
  type        = string
  default     = "apikey"
}

variable "mail_password" {
  description = "SMTP password"
  type        = string
  sensitive   = true
}

variable "mail_encryption" {
  description = "SMTP encryption"
  type        = string
  default     = "tls"
}

variable "mail_from_address" {
  description = "Mail from address"
  type        = string
}

variable "admin_email" {
  description = "Email address of initial admin account"
  type        = string
}

variable "min_scale" {
  description = "Min number of instances to scale (supports 0)"
  type        = number
  default     = 0
}

variable "max_scale" {
  description = "Max number of instances to scale"
  type        = number
  default     = 3
}
