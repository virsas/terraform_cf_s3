output "endpoint" {
  value = aws_cloudfront_distribution.cf.domain_name
}
output "zone" {
  value = aws_cloudfront_distribution.cf.hosted_zone_id
}