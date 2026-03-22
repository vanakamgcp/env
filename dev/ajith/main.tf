terraform {
  backend "gcs" {
    bucket  = "tf-state-gcp-de-feb26"
    prefix  = "dev/ajith"
  }
}

provider "google" {
  project = "gcp-de-feb26"
  region  = "us-central1"
}

resource "google_storage_bucket" "test_bucket" {
  name     = "ajith-test-bucket-1234"
  location = "us-central1"
}
