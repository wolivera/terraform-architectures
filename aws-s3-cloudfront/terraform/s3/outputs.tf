output "s3_bucket_id" {
    value = resource.aws_s3_bucket.bucket.id
}

output "s3_bucket_regional_domain_name" {
    value = resource.aws_s3_bucket.bucket.bucket_regional_domain_name
}
