# Define the AWS region
variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "ap-south-1"
}

# Define the S3 bucket name for the source bucket
variable "source_bucket_name" {
  description = "The name of the source S3 bucket"
  type        = string
  default     = "terraform-rs031s"
}

# Define the S3 bucket name for the destination bucket
variable "destination_bucket_name" {
  description = "The name of the destination S3 bucket"
  type        = string
  default     = "terraform-rs031d"
}

# Define the environment tag
variable "environment" {
  description = "The environment tag (e.g., Production, Development)"
  type        = string
  default     = "Production"
}

# Define the IAM role name for replication
variable "replication_role_name" {
  description = "The name of the IAM role for S3 replication"
  type        = string
  default     = "s3-replication-role"
}

# Define the local file path to be uploaded to the source bucket
variable "source_file_path" {
  description = "The local file path of the file to be uploaded to the source S3 bucket"
  type        = string
  default     = "C:/Users/Admin/Desktop/terraform/tf.txt"
}

# Define the local file path to be uploaded to the destination bucket
variable "destination_file_path" {
  description = "The local file path of the file to be uploaded to the destination S3 bucket"
  type        = string
  default     = "path/to/your/local/file.txt"
}

# Define the S3 object key (path within the bucket) for the source bucket
variable "source_s3_key" {
  description = "The S3 object key for the file in the source bucket"
  type        = string
  default     = "tf.txt"
}

# Define the S3 object key (path within the bucket) for the destination bucket
variable "destination_s3_key" {
  description = "The S3 object key for the file in the destination bucket"
  type        = string
  default     = "uploaded-folder/your-file.txt"
}

# Define the storage class for replication
variable "replication_storage_class" {
  description = "The storage class to use for replicated objects"
  type        = string
  default     = "STANDARD"
}
