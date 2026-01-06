---
name: infrastructure-provisioner
description: Provisions and manages cloud infrastructure using IaC
version: 1.0
---

# Infrastructure Provisioner

Designs and implements cloud infrastructure using Infrastructure as Code (Terraform, Pulumi, CloudFormation), following best practices for scalability and security.

## Trigger Conditions

```yaml
task_mentions:
  - "infrastructure|provision|deploy"
  - "terraform|pulumi|cloudformation"
  - "aws|gcp|azure|digitalocean"
  - "kubernetes|k8s|docker"
file_extension:
  - .tf
  - .yaml
  - .yml
file_contains:
  - "resource \""
  - "provider \""
  - "apiVersion:"
always_active_for_agents:
  - devops-agent
```

## When to Load

- Setting up new infrastructure
- Infrastructure changes
- Environment provisioning
- Resource optimization

## Core Competencies

### Terraform Project Structure

```
infrastructure/
├── environments/
│   ├── production/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   └── development/
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── database/
│   ├── compute/
│   └── storage/
├── shared/
│   └── backend.tf
└── README.md
```

### Module Pattern

```hcl
# modules/database/main.tf
resource "aws_db_instance" "main" {
  identifier     = "${var.project}-${var.environment}-db"
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = true
  kms_key_id           = var.kms_key_arn

  db_name  = var.database_name
  username = var.master_username
  password = var.master_password

  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  backup_retention_period = var.backup_retention_days
  backup_window          = "03:00-04:00"
  maintenance_window     = "Mon:04:00-Mon:05:00"

  multi_az               = var.environment == "production"
  deletion_protection    = var.environment == "production"
  skip_final_snapshot    = var.environment != "production"

  performance_insights_enabled = true

  tags = merge(var.tags, {
    Name        = "${var.project}-${var.environment}-db"
    Environment = var.environment
  })
}

# modules/database/variables.tf
variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment (production, staging, development)"
  type        = string
  validation {
    condition     = contains(["production", "staging", "development"], var.environment)
    error_message = "Environment must be production, staging, or development."
  }
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.medium"
}

# modules/database/outputs.tf
output "endpoint" {
  description = "Database endpoint"
  value       = aws_db_instance.main.endpoint
}

output "port" {
  description = "Database port"
  value       = aws_db_instance.main.port
}
```

### Environment Configuration

```hcl
# environments/production/main.tf
terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "myproject-terraform-state"
    key            = "production/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project
      Environment = "production"
      ManagedBy   = "terraform"
    }
  }
}

module "networking" {
  source = "../../modules/networking"

  project     = var.project
  environment = "production"
  vpc_cidr    = "10.0.0.0/16"

  availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

module "database" {
  source = "../../modules/database"

  project        = var.project
  environment    = "production"
  instance_class = "db.r6g.large"

  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.private_subnet_ids
}
```

### Kubernetes Deployment

```yaml
# k8s/base/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
  labels:
    app: api-server
spec:
  replicas: 3
  selector:
    matchLabels:
      app: api-server
  template:
    metadata:
      labels:
        app: api-server
    spec:
      containers:
        - name: api-server
          image: myregistry/api-server:latest
          ports:
            - containerPort: 3000
          resources:
            requests:
              memory: "256Mi"
              cpu: "250m"
            limits:
              memory: "512Mi"
              cpu: "500m"
          env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: api-secrets
                  key: database-url
          livenessProbe:
            httpGet:
              path: /health
              port: 3000
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /ready
              port: 3000
            initialDelaySeconds: 5
            periodSeconds: 5
---
apiVersion: v1
kind: Service
metadata:
  name: api-server
spec:
  selector:
    app: api-server
  ports:
    - port: 80
      targetPort: 3000
  type: ClusterIP
```

## Best Practices

### State Management

```hcl
# Remote state with locking
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "project/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

# State data source for cross-project references
data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "terraform-state-bucket"
    key    = "networking/terraform.tfstate"
    region = "eu-central-1"
  }
}
```

### Security Practices

```hcl
# Never hardcode secrets
variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

# Use data sources for sensitive values
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "production/database/password"
}

# Encrypt everything
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.main.arn
    }
  }
}
```

### Naming Convention

| Resource | Pattern | Example |
|----------|---------|---------|
| VPC | `{project}-{env}-vpc` | myapp-prod-vpc |
| Subnet | `{project}-{env}-{type}-{az}` | myapp-prod-private-a |
| Security Group | `{project}-{env}-{service}-sg` | myapp-prod-api-sg |
| Database | `{project}-{env}-db` | myapp-prod-db |
| S3 Bucket | `{project}-{env}-{purpose}` | myapp-prod-uploads |

## Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Hardcoded values | Not reusable | Use variables |
| No state locking | Conflicts | Use DynamoDB/GCS lock |
| Secrets in code | Security risk | Use secrets manager |
| Manual changes | Drift | All changes via IaC |
| Monolithic config | Hard to manage | Use modules |

## Checklist

### Infrastructure Design
- [ ] Modules for reusable components
- [ ] Environment separation
- [ ] Remote state configured
- [ ] State locking enabled

### Security
- [ ] Encryption at rest
- [ ] Encryption in transit
- [ ] Least privilege IAM
- [ ] Secrets in secret manager

### Operations
- [ ] Tagging strategy
- [ ] Naming convention
- [ ] Backup configured
- [ ] Monitoring setup

## Integration

### Works With
- pipeline-engineer (CI/CD)
- security-hardener (security baseline)
- observability-expert (monitoring)

### Output
- Terraform modules
- Kubernetes manifests
- Environment configs
- Infrastructure diagrams
