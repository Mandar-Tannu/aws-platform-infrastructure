#########################################################
# Amazon S3 Outputs
#########################################################

output "bucket_name" {
  description = "Bucket Name"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "Regional Bucket Domain Name"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

