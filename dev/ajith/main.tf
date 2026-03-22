terraform {
  backend "gcs" {
    bucket  = "tf-state-gcp-de-feb26"
    prefix  = "dev/ajith"
  }
}
