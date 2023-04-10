resource "random_password" "db_pass" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?" # The database password can include any printable ASCII character except "/", """, or "@".

  lifecycle {
    ignore_changes = [
      length,
      special,
      override_special
    ]
  }
}

resource "random_password" "app_key" {
  length  = 32
  special = true

  lifecycle {
    ignore_changes = [
      length,
      special
    ]
  }
}

resource "random_password" "admin_password" {
  length  = 16
  special = true

  lifecycle {
    ignore_changes = [
      length,
      special
    ]
  }
}
