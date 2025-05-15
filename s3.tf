resource "aws_s3_bucket" "your_bucket" {
  bucket = "your-bucket-name"
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.your_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.your_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.your_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.your_bucket.id

  rule {
    id     = "archive-and-delete"
    status = "Enabled"

    filter {
      prefix = ""
    }

    transition {
      days          = 180
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}

data "aws_iam_policy_document" "public_read_policy" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.your_bucket.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.your_bucket.id
  policy = data.aws_iam_policy_document.public_read_policy.json
}
