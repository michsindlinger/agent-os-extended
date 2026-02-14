# Deployment Plan

> Template for documenting deployment procedures and infrastructure
> Use this template to create comprehensive deployment documentation

## Deployment Overview

**Application**: [Application Name]
**Version**: [Version Number]
**Created By**: devops-specialist
**Date**: [Date]

---

## Environments

### Environment Matrix

| Environment | Purpose | Auto-Deploy | Approval Required | URL |
|-------------|---------|-------------|-------------------|-----|
| Development | Local development | Manual | No | http://localhost:3000 |
| Staging | Pre-production testing | Yes (on main push) | No | https://staging.myapp.com |
| Production | Live users | Manual trigger | Yes | https://myapp.com |

### Development Environment

**Purpose**: Local developer testing

**Infrastructure**:
- Local machine
- Docker Compose for services
- In-memory database (or local PostgreSQL)

**Configuration**:
```bash
# .env.development
DATABASE_URL=postgres://localhost:5432/myapp_dev
API_URL=http://localhost:8080
NODE_ENV=development
```

**Start Command**:
```bash
docker-compose up
# Backend: http://localhost:8080
# Frontend: http://localhost:3000
```

---

### Staging Environment

**Purpose**: Pre-production validation and QA testing

**Infrastructure**:
- **Hosting**: [Platform, e.g., DigitalOcean Droplet, AWS EC2]
- **Server**: [Specs, e.g., 2 vCPU, 4GB RAM]
- **OS**: Ubuntu 22.04 LTS
- **Database**: PostgreSQL 17 (separate instance)
- **Backup**: Daily automated backups
- **Region**: [Region, e.g., US East]

**URL**: https://staging.myapp.com

**Deployment Method**: Automated via GitHub Actions (on push to main)

**Configuration**:
```yaml
# Staging database (separate from production)
DATABASE_URL: [Staging PostgreSQL connection]
REDIS_URL: redis://staging-redis:6379
API_URL: https://staging-api.myapp.com
NODE_ENV: staging
```

**Access**:
- SSH: `ssh ubuntu@staging.myapp.com`
- Application Logs: `docker-compose logs -f`

---

### Production Environment

**Purpose**: Live application serving real users

**Infrastructure**:
- **Hosting**: [Platform, e.g., DigitalOcean Droplet, AWS EC2]
- **Server**: [Specs, e.g., 4 vCPU, 8GB RAM]
- **OS**: Ubuntu 22.04 LTS
- **Database**: PostgreSQL 17 (managed service)
- **Backup**: Daily automated backups + 30-day retention
- **CDN**: CloudFront (for static assets)
- **Region**: [Region, e.g., US East]

**URL**: https://myapp.com

**Deployment Method**: Manual trigger via GitHub Actions (requires approval)

**Configuration**:
```yaml
DATABASE_URL: [Production PostgreSQL connection]
REDIS_URL: redis://production-redis:6379
API_URL: https://api.myapp.com
NODE_ENV: production
```

**Access**:
- SSH: `ssh ubuntu@myapp.com` (restricted to authorized IPs)
- Application Logs: `docker-compose logs -f`

---

## Prerequisites

### GitHub Secrets

**Configure in**: GitHub Repository → Settings → Secrets and variables → Actions

#### Docker Hub Credentials

| Secret Name | Description | How to Obtain |
|-------------|-------------|---------------|
| `DOCKER_USERNAME` | Docker Hub username | Your Docker Hub account name |
| `DOCKER_PASSWORD` | Docker Hub access token | Docker Hub → Account Settings → Security → New Access Token |

#### Staging Environment

| Secret Name | Description | How to Obtain |
|-------------|-------------|---------------|
| `STAGING_HOST` | Staging server hostname | Server IP or domain (e.g., staging.myapp.com) |
| `STAGING_USER` | SSH username | Usually `ubuntu` or `root` |
| `STAGING_SSH_KEY` | SSH private key | Generate with `ssh-keygen`, add public key to server |
| `DATABASE_URL_STAGING` | PostgreSQL connection string | postgres://user:pass@host:5432/dbname |

#### Production Environment

| Secret Name | Description | How to Obtain |
|-------------|-------------|---------------|
| `PRODUCTION_HOST` | Production server hostname | Server IP or domain (e.g., myapp.com) |
| `PRODUCTION_USER` | SSH username | Usually `ubuntu` or `root` |
| `PRODUCTION_SSH_KEY` | SSH private key | Generate with `ssh-keygen`, add public key to server |
| `DATABASE_URL_PRODUCTION` | PostgreSQL connection string | postgres://user:pass@host:5432/dbname |

#### Application Secrets

| Secret Name | Description | How to Obtain |
|-------------|-------------|---------------|
| `JWT_SECRET` | JWT token signing key | Generate random secure string (e.g., `openssl rand -hex 32`) |
| `API_KEY` | External API key (if needed) | From external service provider |

---

### GitHub Environments

**Configure in**: GitHub Repository → Settings → Environments

#### Staging Environment

**Name**: `staging`

**Protection Rules**:
- [ ] Required reviewers: None (auto-deploy)
- [ ] Wait timer: 0 minutes

**Environment Secrets**:
- `DATABASE_URL`: Staging database connection
- `API_URL`: https://staging-api.myapp.com

#### Production Environment

**Name**: `production`

**Protection Rules**:
- [x] Required reviewers: [Team lead, DevOps engineer]
- [x] Wait timer: 0 minutes
- [x] Deployment branches: Only `main`

**Environment Secrets**:
- `DATABASE_URL`: Production database connection
- `API_URL`: https://api.myapp.com

---

### Server Setup

#### Staging Server Setup

**Initial Setup Steps**:

1. **Create Server**:
   ```bash
   # DigitalOcean example
   # Create Droplet: Ubuntu 22.04, 2 vCPU, 4GB RAM
   # Enable firewall: Allow SSH (22), HTTP (80), HTTPS (443)
   ```

2. **Install Docker**:
   ```bash
   ssh ubuntu@staging.myapp.com
   sudo apt update
   sudo apt install -y docker.io docker-compose
   sudo usermod -aG docker ubuntu
   # Log out and back in
   ```

3. **Setup Application Directory**:
   ```bash
   sudo mkdir -p /opt/myapp
   sudo chown ubuntu:ubuntu /opt/myapp
   cd /opt/myapp
   ```

4. **Create docker-compose.yml**:
   ```yaml
   version: '3.9'

   services:
     backend:
       image: ${DOCKER_USERNAME}/myapp-backend:staging
       ports:
         - "8080:8080"
       environment:
         DATABASE_URL: ${DATABASE_URL}
         REDIS_URL: redis://redis:6379
       depends_on:
         - redis

     frontend:
       image: ${DOCKER_USERNAME}/myapp-frontend:staging
       ports:
         - "80:80"
         - "443:443"
       depends_on:
         - backend

     redis:
       image: redis:alpine
       ports:
         - "6379:6379"
   ```

5. **Setup SSL (Let's Encrypt)**:
   ```bash
   sudo apt install -y certbot
   sudo certbot certonly --standalone -d staging.myapp.com
   # Copy certificates to /opt/myapp/certs/
   ```

6. **Configure Firewall**:
   ```bash
   sudo ufw allow 22/tcp  # SSH
   sudo ufw allow 80/tcp  # HTTP
   sudo ufw allow 443/tcp # HTTPS
   sudo ufw enable
   ```

---

#### Production Server Setup

**Same steps as staging**, but with production-specific configuration:
- Larger server (4 vCPU, 8GB RAM)
- Production domain (myapp.com)
- Production database
- Stricter firewall rules (allow SSH only from specific IPs)

---

## Deployment Workflows

### Staging Deployment (Automated)

**Trigger**: Push to `main` branch

**GitHub Actions Workflow**: `.github/workflows/deploy-staging.yml`

**Process**:
1. CI tests pass on main branch
2. GitHub Actions builds Docker images
3. Images tagged with `staging` and commit SHA
4. Images pushed to Docker Hub
5. SSH into staging server
6. Pull latest images: `docker-compose pull`
7. Restart containers: `docker-compose up -d`
8. Smoke tests run (health check endpoints)
9. Deployment complete

**Rollback** (if needed):
```bash
ssh ubuntu@staging.myapp.com
cd /opt/myapp

# View available images
docker images | grep myapp-backend

# Roll back to previous version
docker pull username/myapp-backend:<previous-sha>
docker-compose down
docker-compose up -d
```

**Verify Deployment**:
```bash
# Check health endpoints
curl https://staging.myapp.com/health
curl https://staging-api.myapp.com/health

# Check Docker logs
ssh ubuntu@staging.myapp.com
cd /opt/myapp
docker-compose logs --tail=100
```

---

### Production Deployment (Manual)

**Trigger**: Manual workflow dispatch via GitHub Actions UI

**GitHub Actions Workflow**: `.github/workflows/deploy-production.yml`

**Prerequisites**:
1. All tests passing in CI
2. Staging deployment successful
3. QA team approval
4. Release tag created (e.g., `v1.2.3`)

**Process**:
1. Navigate to GitHub Actions → "Deploy to Production"
2. Click "Run workflow"
3. Enter version tag (e.g., `v1.2.3`)
4. Workflow awaits manual approval (configured in GitHub Environments)
5. Approver reviews staging deployment
6. Approver clicks "Approve deployment"
7. GitHub Actions builds Docker images from tag
8. Images tagged with version + `latest`
9. Images pushed to Docker Hub
10. SSH into production server
11. Pull latest images: `docker-compose pull`
12. Zero-downtime restart: `docker-compose up -d --no-deps --build`
13. Smoke tests run (health check endpoints)
14. Success notification sent

**Rollback Procedure**:
```bash
ssh ubuntu@myapp.com
cd /opt/myapp

# View previous versions
docker images | grep myapp-backend

# Roll back to previous stable version
docker pull username/myapp-backend:v1.2.2
docker-compose down
docker-compose up -d

# Verify rollback
curl https://myapp.com/health
```

**Verify Deployment**:
```bash
# Check health endpoints
curl https://myapp.com/health
curl https://api.myapp.com/health

# Check application logs
ssh ubuntu@myapp.com
cd /opt/myapp
docker-compose logs --tail=100 -f

# Monitor error logs
docker-compose logs backend | grep ERROR
```

---

## Database Migrations

### Migration Strategy

**Principle**: Migrations must be backward-compatible

**Rules**:
1. ✅ Add new columns (with defaults)
2. ✅ Add new tables
3. ✅ Add new indexes
4. ❌ DO NOT delete columns in same release as code removal
5. ❌ DO NOT rename columns (add new, migrate data, remove old in future release)

### Staging Migration Process

**Automated** (runs before deployment):
```yaml
# .github/workflows/deploy-staging.yml
- name: Run database migrations
  run: |
    ssh ubuntu@staging.myapp.com << 'EOF'
      cd /opt/myapp
      docker-compose exec backend mvn flyway:migrate
    EOF
```

**Manual** (if needed):
```bash
ssh ubuntu@staging.myapp.com
cd /opt/myapp
docker-compose exec backend mvn flyway:migrate
# Verify migration success
docker-compose exec backend mvn flyway:info
```

### Production Migration Process

**Manual** (run before deployment):
```bash
# 1. Backup database first
ssh ubuntu@myapp.com
cd /opt/myapp
./backup-db.sh

# 2. Run migrations
docker-compose exec backend mvn flyway:migrate

# 3. Verify migration
docker-compose exec backend mvn flyway:info

# 4. Test with current application version
curl https://api.myapp.com/health/db

# 5. If successful, proceed with deployment
# If failed, rollback migration and investigate
```

**Migration Rollback**:
```bash
# Restore database from backup
./restore-db.sh <backup-file>

# Verify restoration
docker-compose exec backend mvn flyway:info
```

---

## Monitoring & Health Checks

### Health Check Endpoints

**Backend**:
- **URL**: `https://api.myapp.com/health`
- **Expected Response**: `200 OK`
- **Response Body**: `{"status": "UP"}`

**Frontend**:
- **URL**: `https://myapp.com/health`
- **Expected Response**: `200 OK`
- **Response Body**: `OK`

**Database**:
- **URL**: `https://api.myapp.com/health/db`
- **Expected Response**: `200 OK`
- **Response Body**: `{"status": "UP", "database": "PostgreSQL"}`

### Smoke Tests

**Post-Deployment Smoke Tests** (automated in CI/CD):
```bash
# Health checks
curl -f https://myapp.com/health || exit 1
curl -f https://api.myapp.com/health || exit 1

# Critical endpoints
curl -f https://api.myapp.com/api/users || exit 1

# Database connectivity
curl -f https://api.myapp.com/health/db || exit 1
```

### Monitoring Setup (Recommended)

**Uptime Monitoring**:
- Service: UptimeRobot, Pingdom, or StatusCake
- Check health endpoints every 5 minutes
- Alert on downtime (email, Slack)

**Application Monitoring**:
- Service: Sentry, Rollbar, or Datadog
- Track errors and exceptions
- Performance monitoring

**Log Aggregation**:
- Service: Papertrail, Loggly, or CloudWatch
- Centralized log storage
- Search and filter capabilities

**Metrics**:
- Response times
- Error rates
- Database query performance
- CPU/Memory usage

---

## Backup & Recovery

### Database Backups

**Staging**:
- Frequency: Daily at 2 AM UTC
- Retention: 7 days
- Location: Server local storage

**Production**:
- Frequency: Daily at 2 AM UTC
- Retention: 30 days
- Location: S3 bucket (encrypted)

**Backup Script**:
```bash
#!/bin/bash
# backup-db.sh

DATE=$(date +%Y-%m-%d-%H-%M-%S)
BACKUP_FILE="backup-$DATE.sql"

# Backup database
docker-compose exec -T db pg_dump -U postgres myapp > $BACKUP_FILE

# Compress
gzip $BACKUP_FILE

# Upload to S3 (production only)
if [ "$ENV" = "production" ]; then
  aws s3 cp $BACKUP_FILE.gz s3://myapp-backups/
fi

echo "Backup complete: $BACKUP_FILE.gz"
```

**Automated Backups** (cron job):
```bash
# Add to server crontab
0 2 * * * cd /opt/myapp && ./backup-db.sh
```

### Recovery Procedure

**Restore from Backup**:
```bash
# 1. Stop application
docker-compose down

# 2. Download backup (if from S3)
aws s3 cp s3://myapp-backups/backup-2025-01-15.sql.gz .

# 3. Decompress
gunzip backup-2025-01-15.sql.gz

# 4. Restore database
docker-compose up -d db
docker-compose exec -T db psql -U postgres myapp < backup-2025-01-15.sql

# 5. Start application
docker-compose up -d

# 6. Verify
curl https://myapp.com/health
```

---

## Security Checklist

**Secrets Management**:
- [x] All secrets stored in GitHub Secrets (not in code)
- [x] SSH keys rotated every 90 days
- [x] Database credentials unique per environment
- [x] API keys rotated regularly

**Server Security**:
- [x] Firewall configured (UFW)
- [x] SSH key-based authentication (password auth disabled)
- [x] Automatic security updates enabled
- [x] Non-root user for application
- [x] SSL/TLS enabled (HTTPS only)

**Docker Security**:
- [x] Docker images use non-root users
- [x] Images scanned for vulnerabilities (Trivy, Snyk)
- [x] Minimal base images (alpine)
- [x] .dockerignore excludes secrets

**Application Security**:
- [x] Environment variables for configuration (no hardcoded secrets)
- [x] CORS configured properly
- [x] Rate limiting enabled (if applicable)
- [x] Input validation on all endpoints

---

## Troubleshooting

### Deployment Fails

**Symptom**: GitHub Actions deployment workflow fails

**Debugging**:
1. Check GitHub Actions logs
2. Verify secrets are configured correctly
3. SSH into server manually:
   ```bash
   ssh ubuntu@myapp.com
   cd /opt/myapp
   docker-compose logs
   ```

**Common Issues**:
- SSH key invalid: Regenerate and update secret
- Docker image not found: Check Docker Hub, verify image tag
- Port already in use: `docker-compose down` first

### Application Not Responding

**Symptom**: Health check fails, application unreachable

**Debugging**:
```bash
ssh ubuntu@myapp.com
cd /opt/myapp

# Check container status
docker-compose ps

# Check logs
docker-compose logs --tail=100

# Restart application
docker-compose restart

# Full restart (if needed)
docker-compose down
docker-compose up -d
```

### Database Connection Errors

**Symptom**: Application logs show database connection errors

**Debugging**:
```bash
# Check database container
docker-compose ps db

# Check database logs
docker-compose logs db

# Verify connection string
echo $DATABASE_URL

# Test connection
docker-compose exec backend psql $DATABASE_URL
```

---

## Deployment Checklist

### Pre-Deployment

**Staging**:
- [ ] All tests passing in CI
- [ ] Code reviewed and approved
- [ ] Feature tested locally
- [ ] Database migrations reviewed

**Production**:
- [ ] Staging deployment successful
- [ ] QA team approval
- [ ] Release notes prepared
- [ ] Rollback plan documented
- [ ] Database backup completed
- [ ] Team notified of deployment window

### During Deployment

**Staging**:
- [ ] GitHub Actions workflow triggered
- [ ] Docker images built successfully
- [ ] Deployment executed
- [ ] Smoke tests passed

**Production**:
- [ ] Manual approval granted
- [ ] Database migrations executed
- [ ] Application deployed
- [ ] Smoke tests passed
- [ ] Monitoring shows normal metrics

### Post-Deployment

**Staging**:
- [ ] Health checks passing
- [ ] Application logs show no errors
- [ ] QA team notified

**Production**:
- [ ] Health checks passing
- [ ] Monitoring shows normal metrics
- [ ] Error tracking shows no new errors
- [ ] Team notified of successful deployment
- [ ] Release notes published

---

## Rollback Plan

### When to Rollback

Rollback immediately if:
- Critical bug discovered in production
- Application crashes or becomes unresponsive
- Data corruption detected
- Security vulnerability discovered

### Rollback Procedure

**Application Rollback** (keep current database):
```bash
ssh ubuntu@myapp.com
cd /opt/myapp

# Pull previous stable version
docker pull username/myapp-backend:v1.2.2
docker pull username/myapp-frontend:v1.2.2

# Update docker-compose to use previous version
# Edit docker-compose.yml image tags

# Restart with previous version
docker-compose down
docker-compose up -d

# Verify
curl https://myapp.com/health
```

**Full Rollback** (including database):
```bash
# 1. Stop application
docker-compose down

# 2. Restore database from backup
./restore-db.sh backup-before-v1.2.3.sql.gz

# 3. Deploy previous application version
docker pull username/myapp-backend:v1.2.2
docker-compose up -d

# 4. Verify
curl https://myapp.com/health
```

**Rollback Time**: Target < 15 minutes

---

## Contact Information

**DevOps Team**:
- Email: devops@myapp.com
- Slack: #devops-alerts

**On-Call**:
- PagerDuty: [Link]
- Phone: [Number]

**Escalation**:
1. DevOps Engineer
2. Tech Lead
3. CTO

---

**Deployment Plan Complete!** ✅

This plan provides comprehensive deployment procedures for staging and production environments with automated CI/CD pipelines and proper rollback strategies.
