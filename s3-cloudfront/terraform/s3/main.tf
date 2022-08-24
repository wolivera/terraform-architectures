
# create S3 Bucket:
resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "${var.application_name}-${var.environment}"

  tags = {
    APP_NAME = var.app_tags
  }

  force_destroy = true
}

# create bucket ACL :
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

# block public access :
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

# encrypt bucket using SSE-S3:
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# create S3 website hosting:
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# add bucket policy to let the CloudFront OAI get objects:
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_document.json
}

#upload website files to s3:
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id

  for_each     = fileset("../website/", "*")
  key          = "website/${each.value}"
  source       = "../website/${each.value}"
  etag         = filemd5("../website/${each.value}")
  content_type = "text/html"

  depends_on = [
    aws_s3_bucket.bucket
  ]
}

# data source to generate bucket policy to let CloudFront get objects:
data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    actions = ["s3:GetObject"]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [var.aws_cloudfront_oai]
    }
  }
}
