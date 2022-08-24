output "aws_cloudfront_oai" {
    value = resource.aws_cloudfront_origin_access_identity.oai.iam_arn
}
