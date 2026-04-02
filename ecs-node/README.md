# 🚀 ECS Fargate Node.js Deployment

This project demonstrates how to containerize a Node.js application using Docker, push it to Amazon ECR, and deploy it on AWS ECS using Fargate.

---

## 🧱 Architecture Overview

* Node.js App → Containerized with Docker
* Amazon ECR → Stores Docker image
* Amazon ECS (Fargate) → Runs containers serverlessly
* IAM Role → Allows ECS to pull images from ECR
* CloudWatch Logs → for monitoring

---

## ⚙️ Tech Stack

* Node.js / Express
* Docker
* AWS ECS (Fargate)
* Amazon ECR
* AWS CLI

---

## 📁 Project Structure

```
ecs-node/
│
├── app/
│   ├── server.js
│   ├── package.json
│   ├── package-lock.json
│   ├── Dockerfile
│   └── .dockerignore
│
├── task-definition.json
├── .gitignore
└── README.md
```

---

## 🐳 Step 1: Build Docker Image

```bash
cd app
docker build -t ecs-node .
```

---

## 📦 Step 2: Create ECR Repository

```bash
aws ecr create-repository \
  --repository-name ecs-node \
  --region us-east-1
```

---

## 🔐 Step 3: Authenticate Docker to ECR

```bash
aws ecr get-login-password --region us-east-1 \
| docker login --username AWS \
--password-stdin <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com
```

---

## 📤 Step 4: Tag & Push Image

```bash
docker tag ecs-node:latest <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/ecs-node:latest

docker push <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/ecs-node:latest
```

---

## 🧠 Step 5: Register Task Definition

```bash
aws ecs register-task-definition \
  --cli-input-json file://task-definition.json
```

---

## ☁️ Step 6: Create ECS Cluster

```bash
aws ecs create-cluster \
  --cluster-name ecs-node-cluster
```

---

## 🚀 Step 7: Run ECS Service (Fargate)

* Launch type: FARGATE
* Network mode: awsvpc
* Subnet: public subnet
* Security group: allow port 3000

---

## 🌐 Step 8: Access Application

```
http://<PUBLIC_IP>:3000
```

---

## 🐛 Troubleshooting

### ❌ Image not found in ECR

Fix:

```bash
docker push
```

### ❌ Platform mismatch

Fix:

```bash
docker buildx build --platform linux/amd64 -t ecs-node .
```

### ❌ Running count = 0

```bash
aws ecs describe-services
```

---

## 💸 Cost Awareness

⚠️ AWS resources can incur costs quickly:

* Fargate tasks
* NAT Gateway
* Load Balancers

👉 Always destroy resources after testing.

---

## 🧹 Cleanup

```bash
aws ecs update-service --desired-count 0 ...
aws ecs delete-service ...
aws ecs delete-cluster ...
aws ecr delete-repository --force ...
```

---

## 📈 Key Learnings

* Docker containerization
* ECR usage
* ECS Fargate deployment
* Debugging AWS issues
* IAM + networking basics

---

## 👨‍💻 Author

Gerard Eklu
Cloud & DevOps Engineer | Software Engineer
