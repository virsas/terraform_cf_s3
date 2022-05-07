provider "aws" {
  region = var.region
}

resource "aws_cloudfront_distribution" "www_s3" {
  origin {
    domain_name = var.s3
    origin_id   = var.settings.domain

    s3_origin_config {
      origin_access_identity = var.access_identity
    }
  }

  enabled             = var.settings.enabled
  is_ipv6_enabled     = var.settings.ipv6
  default_root_object = var.settings.index_page

  custom_error_response {
    error_code = 404
    response_code = 200
    response_page_path = "/${var.settings.error_page}"
  }

  custom_error_response {
    error_code = 403
    response_code = 200
    response_page_path = "/${var.settings.error_page}"
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = var.settings.compress
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.settings.domain
    cache_policy_id        = var.settings.cache_policy_id

    lambda_function_association {
      event_type   = "origin-response"   
      lambda_arn   = var.lambda
    }
  }

  aliases = var.settings.domain_aliases

  restrictions {
    geo_restriction {
      restriction_type = var.settings.geo_restriction
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm
    ssl_support_method  = "sni-only"
    minimum_protocol_version = var.settings.minimum_tls
  }
}