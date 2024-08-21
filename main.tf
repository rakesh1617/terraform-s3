provider "aws" {
  region = "ap-south-1" # Specify your AWS region
}

# S3 Bucket in Source Region
resource "aws_s3_bucket" "source_bucket" {
  bucket = "terraform-rs031s"

  versioning {
    enabled = true
  }

  replication_configuration {
    role = aws_iam_role.replication_role.arn

    rules {
      id     = "replication-rule"
      status = "Enabled"

      filter {
        prefix = ""
      }

      destination {
        bucket        = aws_s3_bucket.destination_bucket.arn
        storage_class = "STANDARD"
      }
    }
  }

  tags = {
    Name        = "Source_bucket"
    Environment = "Production"
  }
}

# S3 Bucket in Destination Region
resource "aws_s3_bucket" "destination_bucket" {
  bucket = "terraform-rs031d"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "Destination_bucket"
    Environment = "Production"
  }
}

# IAM Role for S3 Replication
resource "aws_iam_role" "replication_role" {
  name = "s3-replication-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "s3.amazonaws.com"
      }
    }]
  })
}

# IAM Policy for Replication Role
resource "aws_iam_role_policy" "replication_policy" {
  name = "replication-policy"
  role = aws_iam_role.replication_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
        "s3:GetObjectVersionTagging",
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags",
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
      Effect = "Allow"
      Resource = [
        "${aws_s3_bucket.source_bucket.arn}/*",
        "${aws_s3_bucket.destination_bucket.arn}/*"
      ]
    }]
  })
}

# S3 Bucket Policy for Encryption and Security
resource "aws_s3_bucket_policy" "source_bucket_policy" {
  bucket = aws_s3_bucket.source_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "EnforceEncryption"
      Effect    = "Deny"
      Principal = "*"
      Action    = "s3:PutObject"
      Resource  = "${aws_s3_bucket.source_bucket.arn}/*"
      Condition = {
        StringNotEquals = {
          "s3:x-amz-server-side-encryption" = "AES256"
        }
      }
    }]
  })
}

resource "aws_s3_bucket_policy" "destination_bucket_policy" {
  bucket = aws_s3_bucket.destination_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "EnforceEncryption"
      Effect    = "Deny"
      Principal = "*"
      Action    = "s3:PutObject"
      Resource  = "${aws_s3_bucket.destination_bucket.arn}/*"
      Condition = {
        StringNotEquals = {
          "s3:x-amz-server-side-encryption" = "AES256"
        }
      }
    }]
  })
}

# Upload file to S3 bucket
resource "aws_s3_object" "upload_file" {
  bucket = aws_s3_bucket.source_bucket.bucket
  key    = "tf.txt"  # S3 object key (path within the bucket)
  source = "C:/Users/Admin/Desktop/terraform/tf.txt"    # Local file path
  acl    = "private"
  
  server_side_encryption = "AES256"
}

resource "aws_s3_object" "upload_file" {
  bucket = aws_s3_bucket.destination_bucket.bucket
  key    = "uploaded-folder/your-file.txt"  # S3 object key (path within the bucket)
  source = "path/to/your/local/file.txt"    # Local file path
  acl    = "private"
  
  server_side_encryption = "AES256"
}