# AWS VPC Public & Private Subnet Architecture (Terraform)

## 🚀 Overview
This project demonstrates a foundational AWS networking architecture using Terraform. It includes a custom VPC with both public and private subnets, enabling secure and scalable infrastructure design.

## 🧱 Architecture Components
- VPC (10.0.0.0/16)
- Internet Gateway (IGW)
- Public Subnet (Internet accessible)
- Private Subnet (isolated)
- NAT Gateway (for outbound internet from private subnet)
- Route Tables (public + private)
- EC2 Instances (public + private)
- Security Group (SSH, HTTP, ICMP)

## 🔁 Traffic Flow

### Public EC2
Client → Internet → Internet Gateway → Public Subnet → EC2

### Private EC2
Private EC2 → NAT Gateway → Internet Gateway → Internet  
(No inbound internet access allowed)

## ⚙️ Features
- Public and private subnet separation
- Secure private instance (no public IP)
- NAT Gateway for outbound internet access
- Route tables controlling traffic flow
- Infrastructure as Code using Terraform

## 🛠️ Tech Stack
- AWS (VPC, EC2, IGW, NAT Gateway)
- Terraform
- Amazon Linux 2

## 🚀 How to Deploy

```bash
terraform init
terraform apply
```

## 🌐 Testing

### Test Public EC2 Access
```bash
ssh ec2-user@<public-ip>
```

### Test Private EC2 (via Public EC2)
```bash
ssh ec2-user@<private-ip>
```

### Test Internet Access from Private EC2
```bash
ping google.com
```

## 🔐 Security Design
- Public EC2 accessible via SSH (port 22)
- Private EC2 has NO public IP
- ICMP allowed only within VPC
- Outbound internet via NAT Gateway only

## 📌 Key Learnings
- Difference between public and private subnets
- Role of Internet Gateway vs NAT Gateway
- Route table configuration
- Secure architecture design in AWS
- Terraform-based infrastructure provisioning

## 🧠 Architecture Summary
VPC → Subnets (Public & Private) → IGW (Public Access) → NAT Gateway (Private Outbound) → EC2 Instances
