# Output the name of the source S3 bucket
output "source_bucket_name" {
  description = "The name of the source S3 bucket"
  value       = aws_s3_bucket.source_bucket.bucket
}

# Output the name of the destination S3 bucket
output "destination_bucket_name" {
  description = "The name of the destination S3 bucket"
  value       = aws_s3_bucket.destination_bucket.bucket
}

# Output the ARN of the source S3 bucket
output "source_bucket_arn" {
  description = "The ARN of the source S3 bucket"
  value       = aws_s3_bucket.source_bucket.arn
}

# Output the ARN of the destination S3 bucket
output "destination_bucket_arn" {
  description = "The ARN of the destination S3 bucket"
  value       = aws_s3_bucket.destination_bucket.arn
}

# Output the IAM Role ARN used for replication
output "replication_role_arn" {
  description = "The ARN of the IAM Role used for S3 replication"
  value       = aws_iam_role.replication_role.arn
}

# Output the URL of the uploaded file in the source bucket
output "source_s3_object_url" {
  description = "The URL of the file uploaded to the source S3 bucket"
  value       = aws_s3_object.upload_file_source.url
}

# Output the URL of the uploaded file in the destination bucket
output "destination_s3_object_url" {
  description = "The URL of the file uploaded to the destination S3 bucket"
  value       = aws_s3_object.upload_file_destination.url
}

# Output the replication status between the buckets
output "replication_status" {
  description = "The replication configuration status between the source and destination S3 buckets"
  value       = aws_s3_bucket.source_bucket.replication_configuration[0].rules[0].status
}
