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

# BigQuery dataset and table for March test
resource "google_bigquery_dataset" "ds_mar26_test" {
  dataset_id                  = var.bq_dataset_id
  project                     = var.project_id
  location                    = var.region
  default_table_expiration_ms = 86400000  # 1 day expiration (optional)
  labels = {
    environment = "dev"
    owner       = var.bucket_suffix
  }
}

resource "google_bigquery_table" "tbl_march_test_tbl" {
  dataset_id = google_bigquery_dataset.ds_mar26_test.dataset_id
  table_id   = var.bq_table_id
  project    = var.project_id

  schema = <<EOF
[
  {
    "name": "id",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "created_at",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  }
]
EOF

  expiration_time = null
}
