provider "aws" {
  region = "us-east-1"
}

resource "random_id" "rand" {
  byte_length = 4
}

# S3 BUCKET
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "ec2-demo-bucket-${random_id.rand.hex}"
}

# IAM ROLE FOR EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy (Allow S3 Access)

resource "aws_iam_policy" "s3_access_policy" {
  name = "ec2_s3_access_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          aws_s3_bucket.demo_bucket.arn,
          "${aws_s3_bucket.demo_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Attach policy to role

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Instance Profile

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_s3_profile"
  role = aws_iam_role.ec2_role.name
}

# EC2 Instance 

resource "aws_instance" "demo_ec2" {
  ami                         = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my_key.key_name

  tags = {
    Name = "EC2-S3-Demo"
  }
}

# SG

resource "aws_security_group" "ec2_sg" {
  name = "ec2_ssh_sg"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # for now (we’ll tighten later)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "ec2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
