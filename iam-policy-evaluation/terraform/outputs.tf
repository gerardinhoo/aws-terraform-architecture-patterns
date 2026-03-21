output "catpics_bucket_name" {
  value = aws_s3_bucket.catpics.id
}

output "animals_bucket_name" {
  value = aws_s3_bucket.animalpics.id
}

output "sally_user_name" {
  value = aws_iam_user.sally.name
}
