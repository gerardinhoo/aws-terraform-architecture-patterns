# EC2 with IAM Role for S3 Access

This Terraform project provisions an AWS EC2 instance with an IAM role that grants scoped access to an S3 bucket. It demonstrates the recommended pattern of using IAM instance profiles (rather than hardcoded credentials) to securely allow EC2 instances to interact with S3.

## Architecture

```
┌──────────────┐       ┌──────────────────┐       ┌──────────────┐
│  EC2 Instance│──────▶│ IAM Instance     │──────▶│   S3 Bucket  │
│  (t2.micro)  │       │ Profile / Role   │       │              │
└──────────────┘       └──────────────────┘       └──────────────┘
        │                    │
        │                    ├── s3:ListBucket
   SSH (port 22)             ├── s3:GetObject
                             └── s3:PutObject
```

## Resources Created

| Resource | Description |
|---|---|
| `aws_s3_bucket` | S3 bucket with a random hex suffix for uniqueness |
| `aws_iam_role` | IAM role with an EC2 assume-role trust policy |
| `aws_iam_policy` | Policy granting `s3:ListBucket`, `s3:GetObject`, and `s3:PutObject` scoped to the bucket |
| `aws_iam_role_policy_attachment` | Attaches the S3 policy to the IAM role |
| `aws_iam_instance_profile` | Instance profile that links the role to the EC2 instance |
| `aws_instance` | Amazon Linux 2 EC2 instance (`t2.micro`) with the instance profile attached |
| `aws_security_group` | Allows inbound SSH (port 22) and all outbound traffic |
| `aws_key_pair` | SSH key pair sourced from `~/.ssh/id_rsa.pub` |

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- AWS CLI configured with valid credentials
- An SSH public key at `~/.ssh/id_rsa.pub`

## Usage

```bash
cd terraform

# Initialize Terraform
terraform init

# Preview the changes
terraform plan

# Apply the infrastructure
terraform apply
```

## Outputs

| Output | Description |
|---|---|
| `ec2_public_ip` | Public IP address of the EC2 instance |
| `ec2_instance_id` | Instance ID of the EC2 instance |
| `s3_bucket_name` | Name of the created S3 bucket |

## Verifying S3 Access from EC2

SSH into the instance and use the AWS CLI (pre-installed on Amazon Linux 2) to test:

```bash
# SSH into the instance
ssh -i ~/.ssh/id_rsa ec2-user@<ec2_public_ip>

# List the bucket
aws s3 ls s3://<s3_bucket_name>

# Upload a file
echo "Hello from ec2" > test.txt
aws s3 cp test.txt s3://<s3_bucket_name>/test.txt

# Download a file
aws s3 cp s3://<s3_bucket_name>/test.txt downloaded.txt
```

## Cleanup

```bash
terraform destroy
```

## Security Notes

- The security group currently allows SSH from `0.0.0.0/0`. For production use, restrict this to your IP address.
- The IAM policy follows least-privilege by scoping permissions to the specific S3 bucket only.
