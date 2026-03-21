output "ec2_public_ip" {
  value = aws_instance.demo_ec2.public_ip
}

output "ec2_instance_id" {
  value = aws_instance.demo_ec2.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.demo_bucket.id
}
