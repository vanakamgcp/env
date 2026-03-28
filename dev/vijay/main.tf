terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

locals {
  bucket_types = ["src", "landing", "archive", "error"]
}

resource "google_storage_bucket" "gcs_buckets" {
  for_each = { for t in local.bucket_types : t => "gcs_mar26_${t}_${var.bucket_suffix}" }

  name          = each.value
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }

  labels = {
    environment = "dev"
    owner       = var.bucket_suffix
  }
}
