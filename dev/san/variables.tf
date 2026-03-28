variable "project_id" {
  description = "GCP project id where buckets will be created"
  type        = string
}

variable "region" {
  description = "GCP location/region for buckets (multiregional bucket location is recommended)"
  type        = string
  default     = "US"
}

variable "bucket_suffix" {
  description = "Suffix used in bucket naming (e.g., vj for Vijay)"
  type        = string
  default     = "vj"
}
