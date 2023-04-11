terraform {
  cloud {
    organization = "onghub"

    workspaces {
      tags = [
        "website-factory",
        "gcloud"
      ]
    }
  }
}
