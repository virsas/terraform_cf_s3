output "endpoint" {
  value = aws_cloudfront_distribution.www_s3.domain_name
}
output "zone" {
  value = aws_cloudfront_distribution.www_s3.hosted_zone_id
}