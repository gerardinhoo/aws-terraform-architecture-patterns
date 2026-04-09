# Lambda Task API

A serverless REST API for managing tasks, built with AWS Lambda, API Gateway (HTTP API), and DynamoDB — deployed with Terraform and CI/CD via GitHub Actions.

## Architecture

```
Client → API Gateway (HTTP) → Lambda Functions → DynamoDB
```

- **API Gateway v2** (HTTP API) routes requests to Lambda functions
- **3 Lambda functions** (Node.js 18.x) handle CRUD operations
- **DynamoDB** (on-demand billing) stores tasks
- **Terraform** manages all infrastructure with remote state in S3

## Project Structure

```
lambda-task-api/
├── app/
│   ├── create-task/index.js    # POST /tasks
│   ├── get-tasks/index.js      # GET /tasks
│   └── delete-task/index.js    # DELETE /tasks/{id}
├── terraform/
│   ├── main.tf                 # Resources (Lambda, DynamoDB, API GW, IAM)
│   ├── provider.tf             # AWS provider + S3 backend
│   ├── variables.tf            # Input variables
│   └── outputs.tf              # API URL + table name outputs
└── README.md
```

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| POST | `/tasks` | Create a new task |
| GET | `/tasks` | List all tasks |
| DELETE | `/tasks/{id}` | Delete a task by ID |

### Examples

```bash
# Create a task
curl -X POST https://<api-id>.execute-api.us-east-1.amazonaws.com/tasks \
  -d '{"title": "Buy groceries"}'

# List all tasks
curl https://<api-id>.execute-api.us-east-1.amazonaws.com/tasks

# Delete a task
curl -X DELETE https://<api-id>.execute-api.us-east-1.amazonaws.com/tasks/<task-id>
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5.0
- AWS CLI configured with credentials
- An S3 bucket for Terraform remote state

## Deployment

### Local

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

After apply, get the API URL:

```bash
terraform output api_url
```

### CI/CD

The GitHub Actions workflow (`.github/workflows/deploy-lambda-task-api.yml`) runs automatically:

- **On pull request to `main`**: runs `terraform plan` only
- **On push to `main`**: runs `terraform plan` then `terraform apply`
- **Path-filtered**: only triggers on changes within `lambda-task-api/`

#### Required GitHub Secrets

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

## Terraform State

State is stored remotely in S3 (`s3://gerard-lambda-terraform/lambda-task-api/terraform.tfstate`), enabling consistent state between local development and CI/CD.
