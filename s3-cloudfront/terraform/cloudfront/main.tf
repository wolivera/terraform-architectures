
# data source to fetch hosted zone info from domain name:
data "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

# creating A record for domain:
resource "aws_route53_record" "websiteurl" {
  name    = var.website_domain
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf_dist.domain_name
    zone_id                = aws_cloudfront_distribution.cf_dist.hosted_zone_id
    evaluate_target_health = true
  }
}

#creating Cloudfront Origin Access Identity (OAI) :
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${var.application_name}"
}

# cloudfront terraform - creating AWS Cloudfront distribution :
resource "aws_cloudfront_distribution" "cf_dist" {
  enabled             = true
  aliases             = [var.website_domain]
  default_root_object = "website/index.html"

  origin {
    domain_name = var.s3_bucket_regional_domain_name
    origin_id   = var.s3_bucket_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = var.s3_bucket_id
    viewer_protocol_policy = "redirect-to-https" # other options - https only, http

    forwarded_values {
      headers      = []
      query_string = true

      cookies {
        forward = "all"
      }
    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN", "US", "CA"]
    }
  }

  tags = {
    APP_TAGS = var.app_tags
  }

  viewer_certificate {
    acm_certificate_arn      = var.aws_acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }
}
