# IAM Policy Evaluation — Explicit Deny Overrides Allow

![Terraform](https://img.shields.io/badge/IaC-Terraform-blue)
![AWS](https://img.shields.io/badge/Cloud-AWS-orange)
![IAM](https://img.shields.io/badge/Focus-IAM_Security-red)

---

## Overview

Demonstrates how AWS IAM evaluates multiple policy statements within the same policy. An IAM user (`sally`) is granted broad S3 access with a targeted explicit Deny on a specific bucket — proving that **explicit Deny always wins**, regardless of any Allow statements.

This is a core AWS security concept tested on the AWS Solutions Architect exam and used daily in production IAM design.

---

## What This Provisions

**S3 Buckets**
- `catpics-demo-<random>` — The restricted bucket (Deny target)
- `animalpics-demo-<random>` — An unrestricted bucket (Allow applies)

**IAM User**
- `sally` — Test user with a single attached policy

**IAM Policy — `AllowAllS3ExceptCats`**

Contains two statements evaluated together:

| Statement | Effect | Action | Resource |
|-----------|--------|--------|----------|
| 1         | Allow  | `s3:*` | `*` (all buckets) |
| 2         | Deny   | `s3:*` | `catpics` bucket ARN + objects |

---

## IAM Evaluation Logic

AWS evaluates policies in this order:

```
1. Explicit Deny?     → YES → DENY (final, no override)
2. Explicit Allow?    → YES → ALLOW
3. Neither?           → DENY (implicit default)
```

**Result for `sally`:**

- `s3:GetObject` on `animalpics` → **ALLOWED** (Statement 1 matches, no Deny applies)
- `s3:GetObject` on `catpics` → **DENIED** (Statement 2 explicit Deny overrides Statement 1 Allow)
- `s3:GetObject` on any other bucket → **ALLOWED** (Statement 1 matches via `*`)

The key takeaway: **an explicit Deny in any policy always overrides an Allow**, even within the same policy document. Order of statements does not matter — AWS evaluates all statements before making a decision.

---

## Project Structure

```
iam-policy-evaluation/
├── README.md
└── terraform/
    ├── main.tf          # S3 buckets, IAM user, IAM policy
    ├── variables.tf     # Region configuration
    └── outputs.tf       # Bucket names, user name
```

---

## Usage

### Deploy

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Verify the policy behavior

```bash
# Configure CLI as sally
aws configure --profile sally

# This should SUCCEED — animalpics is allowed
aws s3 ls s3://animalpics-demo-<id> --profile sally

# This should FAIL with AccessDenied — catpics is explicitly denied
aws s3 ls s3://catpics-demo-<id> --profile sally
```

### Tear down

```bash
terraform destroy
```

---

## Key Concepts Demonstrated

1. **Explicit Deny overrides Allow** — The most important IAM rule. No Allow statement anywhere (identity policy, resource policy, permissions boundary, or SCP) can override an explicit Deny.

2. **Wildcard Allow + targeted Deny** — A common production pattern for granting broad access with specific exceptions (e.g., allow all S3 except a compliance bucket, allow all EC2 except termination).

3. **Resource-level scoping** — The Deny targets both the bucket ARN (`arn:aws:s3:::catpics-demo-*`) and its objects (`arn:aws:s3:::catpics-demo-*/*`), ensuring both bucket-level and object-level operations are denied.

4. **`jsonencode()` for IAM policies** — Uses Terraform's `jsonencode()` function with HCL maps instead of heredoc JSON strings, enabling Terraform resource references (e.g., `aws_s3_bucket.catpics.arn`) directly in the policy document.

---

## How This Applies in Production

This pattern is used in real-world scenarios such as:

- **Compliance buckets** — Allow teams broad S3 access but deny deletion/modification of audit log buckets
- **Break-glass prevention** — Allow general EC2 access but deny `ec2:TerminateInstances` on production instances
- **Cost control** — Allow resource creation but deny expensive instance types via condition keys
- **SCPs in AWS Organizations** — Deny specific actions across all accounts regardless of individual IAM policies

---

## Technologies

- **Terraform** — Infrastructure as Code
- **AWS IAM** — Identity and Access Management (users, policies, policy evaluation)
- **AWS S3** — Target resources for demonstrating access control

---

**Author:** [Gerard Eklu](https://github.com/gerardinhoo)