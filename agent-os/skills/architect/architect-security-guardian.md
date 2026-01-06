---
name: architect-security-guardian
description: Ensures security best practices in architecture and design
version: 1.0
---

# Architect Security Guardian

Reviews designs for security vulnerabilities, defines authentication/authorization requirements, and ensures OWASP compliance.

## Trigger Conditions

```yaml
task_mentions:
  - "security|auth|authentication|authorization"
  - "oauth|jwt|rbac|permission"
  - "encrypt|password|token|secret"
  - "owasp|vulnerability|injection"
always_active_for_agents:
  - architecture-agent
```

## When to Load

- Final design review before "Ready for Dev"
- Authentication/authorization features
- API security design
- Data protection requirements

## Core Competencies

### Authentication Patterns

#### JWT (JSON Web Tokens)
```typescript
// Token structure
{
  header: { alg: "RS256", typ: "JWT" },
  payload: {
    sub: "user-id",
    email: "user@example.com",
    roles: ["user", "admin"],
    iat: 1234567890,
    exp: 1234571490  // 1 hour
  },
  signature: "..."
}

// Best practices
- Use RS256 (asymmetric) not HS256
- Short expiry (15min-1hr) + refresh tokens
- Store in httpOnly cookies, not localStorage
- Include minimal claims
```

#### OAuth 2.0 Flows
| Flow | Use Case | Security Level |
|------|----------|----------------|
| Authorization Code + PKCE | Web/Mobile apps | High |
| Client Credentials | Server-to-server | High |
| Device Code | TV/IoT devices | Medium |
| ~~Implicit~~ | Deprecated | Low |
| ~~Password~~ | Deprecated | Low |

### Authorization Patterns

#### Role-Based Access Control (RBAC)
```typescript
// Roles
const roles = {
  admin: ['read', 'write', 'delete', 'manage_users'],
  editor: ['read', 'write'],
  viewer: ['read']
};

// Permission check
function canAccess(user: User, permission: string): boolean {
  return roles[user.role]?.includes(permission) ?? false;
}
```

#### Attribute-Based Access Control (ABAC)
```typescript
// Policy: User can edit own resources
const policy = {
  effect: 'allow',
  action: 'edit',
  resource: 'document',
  condition: (user, resource) => resource.ownerId === user.id
};
```

### OWASP Top 10 Prevention

| Vulnerability | Prevention |
|---------------|------------|
| Injection (SQL, NoSQL, LDAP) | Parameterized queries, ORMs |
| Broken Authentication | MFA, secure session management |
| Sensitive Data Exposure | Encryption at rest and in transit |
| XXE | Disable external entity processing |
| Broken Access Control | Check permissions server-side |
| Security Misconfiguration | Hardened defaults, security headers |
| XSS | Output encoding, CSP headers |
| Insecure Deserialization | Validate/sanitize input, use safe libraries |
| Vulnerable Components | Regular dependency updates |
| Insufficient Logging | Log security events, monitor anomalies |

## Best Practices

### API Security
```typescript
// Security headers
app.use(helmet());  // Sets security headers
app.use(cors({
  origin: ['https://app.example.com'],
  credentials: true
}));

// Rate limiting
app.use(rateLimit({
  windowMs: 15 * 60 * 1000,  // 15 minutes
  max: 100  // limit each IP
}));

// Input validation
const createUserSchema = z.object({
  email: z.string().email().max(255),
  password: z.string().min(8).max(72),
  name: z.string().min(1).max(100).trim()
});
```

### Password Security
```typescript
// Hashing (use bcrypt or Argon2)
const hash = await bcrypt.hash(password, 12);  // cost factor 12

// Validation
const isValid = await bcrypt.compare(input, hash);

// Requirements
- Minimum 8 characters
- Check against breached passwords (HaveIBeenPwned)
- No maximum length (but limit to 72 for bcrypt)
- Allow all characters
```

### Secret Management
```yaml
# DO NOT store secrets in:
- Source code
- Environment variables in CI logs
- Unencrypted config files

# DO use:
- Vault (HashiCorp)
- AWS Secrets Manager
- Azure Key Vault
- Encrypted environment files (SOPS)
```

## Anti-Patterns

| Anti-Pattern | Risk | Solution |
|--------------|------|----------|
| Secrets in code | Exposure | Use secret management |
| Rolling own crypto | Weak encryption | Use standard libraries |
| Client-side auth only | Bypass possible | Server-side validation |
| Overly permissive CORS | CSRF attacks | Specific origins only |
| Logging sensitive data | Data leak | Sanitize logs |
| Default credentials | Easy compromise | Force password change |

## Checklist

### Design Security Review
- [ ] Authentication method defined (JWT, OAuth, Session)
- [ ] Authorization model defined (RBAC, ABAC)
- [ ] All endpoints require authentication (except public)
- [ ] Rate limiting configured
- [ ] Input validation on all inputs
- [ ] Output encoding for XSS prevention
- [ ] HTTPS enforced
- [ ] Security headers configured
- [ ] Secrets managed properly

### Data Protection
- [ ] PII identified and protected
- [ ] Encryption at rest for sensitive data
- [ ] TLS for data in transit
- [ ] Audit logging for access
- [ ] Data retention policy

## Integration

### Works With
- architect-api-designer (secure endpoints)
- security-hardener (DevOps)
- security-best-practices (base skill)

### Output
- Security requirements document
- Auth flow diagrams
- Required middleware list
- Security header configuration
