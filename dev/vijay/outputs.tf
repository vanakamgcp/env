output "bucket_names" {
  description = "Created GCS bucket names"
  value       = values(google_storage_bucket.gcs_buckets)[*].name
}
