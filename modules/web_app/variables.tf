variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "docker_tag" {
  description = "Docker image tag"
  type        = string
}

variable "edition" {
  description = "Website Factory edition to deploy"
  type        = string
}

variable "project_slug" {
  description = "Project slug"
  type        = string
}

variable "hostname" {
  description = "Domain for website factory web app"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "debug_mode" {
  description = "Is debug mode enabled"
  type        = bool
}

variable "region" {
  description = "Region where to deploy resources"
  type        = string
}

variable "mail_host" {
  description = "SMTP host"
  type        = string
}

variable "mail_port" {
  description = "SMTP port"
  type        = string
}

variable "mail_username" {
  description = "SMTP username"
  type        = string
}

variable "mail_password" {
  description = "SMTP password"
  type        = string
}

variable "mail_encryption" {
  description = "SMTP encryption"
  type        = string
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
}

variable "max_scale" {
  description = "Max number of instances to scale"
  type        = number
}

variable "activate_services" {
  type = list(any)
  default = [
    "compute.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "vpcaccess.googleapis.com",
    "sqladmin.googleapis.com",
    "servicenetworking.googleapis.com",
    "run.googleapis.com"
  ]
}
