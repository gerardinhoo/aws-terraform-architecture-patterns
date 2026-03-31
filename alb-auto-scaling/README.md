# AWS ALB + Auto Scaling Architecture (Terraform)

## 🚀 Overview
This project demonstrates a production-style AWS architecture using Terraform, featuring an Application Load Balancer (ALB) and Auto Scaling Group (ASG) deployed across multiple Availability Zones for high availability and scalability.

## 🧱 Architecture
- Application Load Balancer (ALB)
- Target Group with health checks
- Auto Scaling Group (ASG)
- Launch Template (EC2 + Apache setup)
- Multi-AZ deployment
- Security Groups for HTTP access

## 🔁 Traffic Flow
Client → ALB → Target Group → Auto Scaling Group → EC2 Instances → Apache Web Server

## ⚙️ Features
- Load balancing across multiple EC2 instances
- Auto scaling (min, desired, max capacity)
- Health checks with automatic instance replacement
- Multi-AZ fault tolerance
- Infrastructure as Code (Terraform)

## 🛠️ Tech Stack
- AWS (EC2, ALB, Auto Scaling, VPC)
- Terraform
- Amazon Linux 2
- Apache (httpd)

## 🚀 How to Deploy

```bash
terraform init
terraform apply
```

## 🌐 Access Application

After deployment:

```bash
terraform output alb_dns_name
```

Then open in browser:

http://<ALB-DNS>

## 🧪 Testing

### Load Balancing
```bash
for i in {1..10}; do curl http://<ALB-DNS>; done
```

### Auto-Healing
- Terminate an EC2 instance manually
- ASG will automatically replace it

### Scaling
- Update desired capacity in Terraform
- Re-apply configuration

## 📌 Key Learnings
- Difference between ALB and target groups
- Importance of health checks
- Auto Scaling Group lifecycle
- Multi-AZ high availability design
- Debugging real-world AWS issues (subnets, regions, etc.)

