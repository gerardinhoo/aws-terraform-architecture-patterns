# AWS Terraform Architecture Patterns 🚀

## 📌 Overview
This repository contains a collection of real-world AWS infrastructure patterns built using Terraform.  
The goal of this project is to demonstrate hands-on experience with cloud architecture, DevOps practices, and Infrastructure as Code (IaC).

Each folder represents a different architecture pattern commonly used in production environments.

---

## 🧱 Included Projects

### 🔹 alb-auto-scaling
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- Launch Templates
- Multi-AZ deployment
- High availability + scalability

### 🔹 vpc-public-private-architecture
- Custom VPC (10.0.0.0/16)
- Public & Private Subnets
- Internet Gateway + NAT Gateway
- Secure network design
- EC2 instances (public & private)

### 🔹 ec2-iam-role-s3-access
- IAM Roles for EC2
- Secure S3 access without credentials
- Principle of least privilege

### 🔹 iam-policy-evaluation
- IAM policy testing and evaluation
- Understanding permissions and access control

---

## 🧠 What This Repo Demonstrates

- Infrastructure as Code using Terraform
- Cloud architecture design (AWS)
- High availability and scalability patterns
- Secure networking (public vs private subnets)
- IAM best practices
- Debugging real-world cloud issues

---

## 🛠️ Tech Stack

- AWS (EC2, VPC, ALB, ASG, IAM, S3)
- Terraform
- Amazon Linux 2
- Bash / SSH

---

## 🚀 How to Use

Each project is self-contained.

```bash
cd <project-folder>/terraform
terraform init
terraform apply
```

---

## 📂 Project Structure

```text
aws-terraform-architecture-patterns/
│
├── alb-auto-scaling/
├── vpc-public-private-architecture/
├── ec2-iam-role-s3-access/
├── iam-policy-evaluation/
└── README.md
```

---

## 📌 Key Learnings

- Designing fault-tolerant systems using ALB + ASG
- Building secure VPC architectures with public/private isolation
- Managing access with IAM roles instead of credentials
- Structuring Terraform projects for real-world use
- Troubleshooting networking, scaling, and AWS configuration issues

---

## 💼 Author

Gerard Eklu  
Cloud & DevOps-Focused Software Engineer  

---

## ⭐ Final Note

This repository reflects hands-on, real-world cloud engineering work focused on building scalable, secure, and production-ready infrastructure.

