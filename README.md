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

### 🔹 lambda-task-api
- Serverless REST API (Lambda + API Gateway + DynamoDB)
- Node.js 18.x with AWS SDK v3
- CRUD operations (create, list, delete tasks)
- CI/CD with GitHub Actions (plan on PR, apply on merge)
- Remote Terraform state in S3

---

## 🧠 What This Repo Demonstrates

- Infrastructure as Code using Terraform
- Cloud architecture design (AWS)
- High availability and scalability patterns
- Secure networking (public vs private subnets)
- Serverless architecture (Lambda, API Gateway, DynamoDB)
- CI/CD pipelines with GitHub Actions
- IAM best practices
- Debugging real-world cloud issues

---

## 🛠️ Tech Stack

- AWS (EC2, VPC, ALB, ASG, IAM, S3, Lambda, API Gateway, DynamoDB)
- Terraform
- Node.js 18.x
- GitHub Actions
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
├── lambda-task-api/
└── README.md
```

---

## 📌 Key Learnings

- Designing fault-tolerant systems using ALB + ASG
- Building secure VPC architectures with public/private isolation
- Managing access with IAM roles instead of credentials
- Building serverless APIs with Lambda and API Gateway
- Setting up CI/CD pipelines with Terraform and GitHub Actions
- Managing remote Terraform state with S3
- Structuring Terraform projects for real-world use
- Troubleshooting networking, scaling, and AWS configuration issues

---

## 💼 Author

Gerard Eklu  
Cloud & DevOps-Focused Software Engineer  

---

## ⭐ Final Note

This repository reflects hands-on, real-world cloud engineering work focused on building scalable, secure, and production-ready infrastructure.

