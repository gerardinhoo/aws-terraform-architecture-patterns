provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "catpics" {
  bucket = "catpics-demo-${random_id.rand.hex}"
}

resource "aws_s3_bucket" "animalpics" {
  bucket = "animalpics-demo-${random_id.rand.hex}"
}

resource "random_id" "rand" {
  byte_length = 4
}

resource "aws_iam_user" "sally" {
  name = "sally"
}

resource "aws_iam_policy" "all_except_cats" {
  name = "AllowAllS3ExceptCats"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      },
      {
        Effect = "Deny"
        Action = "s3:*"
        Resource = [
          aws_s3_bucket.catpics.arn,
          "${aws_s3_bucket.catpics.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.sally.name
  policy_arn = aws_iam_policy.all_except_cats.arn
}
