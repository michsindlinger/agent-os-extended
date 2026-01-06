---
name: security-hardener
description: Implements security best practices in infrastructure and deployment
version: 1.0
---

# Security Hardener

Applies security hardening to infrastructure, containers, and deployments following CIS benchmarks and security best practices.

## Trigger Conditions

```yaml
task_mentions:
  - "security|harden|secure"
  - "vulnerability|cve|scan"
  - "ssl|tls|certificate"
  - "firewall|network policy"
file_extension:
  - .tf
  - .yaml
  - .yml
  - Dockerfile
file_contains:
  - "SecurityGroup"
  - "NetworkPolicy"
  - "securityContext"
always_active_for_agents:
  - devops-agent
```

## When to Load

- Security hardening tasks
- Vulnerability remediation
- Compliance requirements
- Security audits

## Core Competencies

### Docker Security

```dockerfile
# Dockerfile - Secure Build
# Use specific version, not latest
FROM node:20.10-alpine3.18 AS builder

# Create non-root user
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser

WORKDIR /app

# Copy only package files first (caching)
COPY package*.json ./
RUN npm ci --only=production

# Copy application code
COPY --chown=appuser:appgroup . .

# Build application
RUN npm run build

# Production image
FROM node:20.10-alpine3.18 AS production

# Security: Don't run as root
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser

# Security: Remove unnecessary packages
RUN apk --no-cache add dumb-init && \
    rm -rf /var/cache/apk/*

WORKDIR /app

# Copy only necessary files
COPY --from=builder --chown=appuser:appgroup /app/dist ./dist
COPY --from=builder --chown=appuser:appgroup /app/node_modules ./node_modules

# Drop all capabilities
USER appuser

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "dist/main.js"]

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

# Security labels
LABEL org.opencontainers.image.source="https://github.com/org/repo"
LABEL org.opencontainers.image.vendor="Company"
```

### Kubernetes Security Context

```yaml
# k8s/deployment-secure.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
spec:
  template:
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1001
        runAsGroup: 1001
        fsGroup: 1001
        seccompProfile:
          type: RuntimeDefault

      containers:
        - name: api-server
          image: myregistry/api-server:v1.0.0@sha256:abc123...
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            capabilities:
              drop:
                - ALL
          resources:
            limits:
              memory: "512Mi"
              cpu: "500m"
            requests:
              memory: "256Mi"
              cpu: "250m"
          volumeMounts:
            - name: tmp
              mountPath: /tmp
            - name: cache
              mountPath: /app/.cache

      volumes:
        - name: tmp
          emptyDir: {}
        - name: cache
          emptyDir: {}

      automountServiceAccountToken: false
---
# Network Policy - Default deny all
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
---
# Allow specific traffic
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-server-policy
spec:
  podSelector:
    matchLabels:
      app: api-server
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: ingress-nginx
      ports:
        - port: 3000
  egress:
    - to:
        - podSelector:
            matchLabels:
              app: postgres
      ports:
        - port: 5432
    - to:
        - namespaceSelector: {}
          podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - port: 53
          protocol: UDP
```

### AWS Security Configuration

```hcl
# terraform/security.tf

# S3 Bucket Security
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "${var.project}-${var.environment}-data"
}

resource "aws_s3_bucket_public_access_block" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.main.arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_versioning" "secure_bucket" {
  bucket = aws_s3_bucket.secure_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Security Group - Minimal Access
resource "aws_security_group" "api" {
  name        = "${var.project}-${var.environment}-api-sg"
  description = "Security group for API servers"
  vpc_id      = var.vpc_id

  # Only allow HTTPS from ALB
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
    description     = "HTTPS from ALB"
  }

  # Only allow necessary egress
  egress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.db.id]
    description     = "PostgreSQL"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS outbound"
  }

  tags = {
    Name = "${var.project}-${var.environment}-api-sg"
  }
}

# RDS Security
resource "aws_db_instance" "main" {
  # ... other config

  storage_encrypted        = true
  kms_key_id              = aws_kms_key.rds.arn
  deletion_protection     = true
  publicly_accessible     = false
  iam_database_authentication_enabled = true

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
}
```

### Security Headers

```typescript
// middleware/security-headers.ts
import helmet from 'helmet';

export const securityHeaders = helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"],
      connectSrc: ["'self'", process.env.API_URL],
      fontSrc: ["'self'", "https://fonts.gstatic.com"],
      objectSrc: ["'none'"],
      mediaSrc: ["'self'"],
      frameSrc: ["'none'"]
    }
  },
  crossOriginEmbedderPolicy: true,
  crossOriginOpenerPolicy: true,
  crossOriginResourcePolicy: { policy: "same-site" },
  dnsPrefetchControl: { allow: false },
  frameguard: { action: "deny" },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  },
  ieNoOpen: true,
  noSniff: true,
  originAgentCluster: true,
  permittedCrossDomainPolicies: { permittedPolicies: "none" },
  referrerPolicy: { policy: "strict-origin-when-cross-origin" },
  xssFilter: true
});
```

## Best Practices

### CIS Benchmark Highlights

| Category | Control | Implementation |
|----------|---------|----------------|
| Container | Run as non-root | USER directive, runAsNonRoot |
| Container | Read-only filesystem | readOnlyRootFilesystem: true |
| Network | Default deny | NetworkPolicy |
| Secrets | No hardcoding | External secrets manager |
| Images | Signed images | Cosign, Notary |

### Vulnerability Scanning

```yaml
# GitHub Action for security scanning
- name: Run Trivy vulnerability scanner
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: '${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}'
    format: 'sarif'
    output: 'trivy-results.sarif'
    severity: 'CRITICAL,HIGH'

- name: Upload Trivy results
  uses: github/codeql-action/upload-sarif@v2
  with:
    sarif_file: 'trivy-results.sarif'
```

## Anti-Patterns

| Anti-Pattern | Risk | Solution |
|--------------|------|----------|
| Running as root | Privilege escalation | Non-root user |
| Latest tag | Unpredictable | Specific version + digest |
| Overly permissive SG | Exposure | Principle of least privilege |
| Unencrypted data | Data breach | Encrypt at rest and transit |
| No network policies | Lateral movement | Default deny policies |

## Checklist

### Container Security
- [ ] Non-root user
- [ ] Read-only filesystem
- [ ] No capabilities
- [ ] Minimal base image
- [ ] Image scanning

### Infrastructure Security
- [ ] Encryption at rest
- [ ] Encryption in transit
- [ ] Least privilege IAM
- [ ] Network segmentation

### Application Security
- [ ] Security headers
- [ ] Input validation
- [ ] Output encoding
- [ ] Dependency scanning

## Integration

### Works With
- architect-security-guardian (app security)
- pipeline-engineer (security gates)
- infrastructure-provisioner (secure infra)

### Output
- Secure Dockerfiles
- Kubernetes security contexts
- Network policies
- Security scan configs
