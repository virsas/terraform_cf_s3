# terraform_cf_s3

Create cloudfront network for s3 bucket

##  Dependencies

- S3 Bucket - <https://github.com/virsas/terraform_s3_bucket>
- ACM - <https://github.com/virsas/terraform_acm>
- Origin Access Identity - <https://github.com/virsas/terraform_cf_oai>
- lambda - <https://github.com/virsas/terraform_lambda_function>

## Files

- None

## Terraform example

``` terraform
##############
# Variable
##############
variable "cf_s3_example_org" {
  default = {
     domain = "example.org"
     domain_aliases = ["www.example.org", "ww2.example.org"]
     enabled = true 
     ipv6 = false 
     index_page = "index.html"
     error_page = "index.html"
     compress = true
     cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
     geo_restriction = "none"
     minimum_tls = "TLSv1"
  }
}

##############
# Module
##############
module "cf_s3_example_org" {
  source = "github.com/virsas/terraform_cf_s3"
  settings = var.cf_s3_example_org
  s3 = module.s3_example_org.bucket_regional_domain_name
  acm = module.acm_cf.arn
  access_identity = module.cf_oai_main.path
  lambda = module.lambda_security_headers.qualified_arn
}
```

## Output

- zone
- endpoint