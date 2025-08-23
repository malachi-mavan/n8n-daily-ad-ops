# Multi-Client Meta Ads Diagnostics Deployment Guide

## 🎯 Overview

This guide covers the deployment of Meta Ads Diagnostics workflows for multiple clients. Each client gets their own customized workflows with client-specific configurations, thresholds, and Slack channels.

## 📊 Generated Workflows

### Meta Ads Clients (4 total):

| Client | Account ID | Slack Channel | Business Type | CAC Target | ROAS Good |
|--------|------------|---------------|---------------|------------|-----------|
| **38TERA** | 732630268714732 | internal_38tera_reports | E-commerce | $100 | >1.0 |
| **Velocity Global** | 875613839312619 | internal_velocityglobal_reports | B2B | $200 | >1.2 |
| **Franki** | 514315682954036 | internal_franki_reports | E-commerce | $50 | >2.0 |
| **Franki B2B** | 815256732728440 | internal_franki_b2b_reports | B2B | $200 | >1.5 |

### Files Generated:

```
workflows/meta-ads-diagnostics/clients/
├── 38tera/
│   ├── main-workflow.json
│   └── error-handler.json
├── velocity-global/
│   ├── main-workflow.json
│   └── error-handler.json
├── franki/
│   ├── main-workflow.json
│   └── error-handler.json
└── franki-b2b/
    ├── main-workflow.json
    └── error-handler.json
```

## 🚀 Deployment Process

### Quick Deployment:

```bash
# Run the automated deployment script
./scripts/deploy-all-clients.sh
```

### Manual Deployment (if needed):

```bash
# Deploy individual client
curl -X POST "https://mavan.app.n8n.cloud/api/v1/workflows" \
  -H "Content-Type: application/json" \
  -H "X-N8N-API-KEY: [YOUR_API_KEY]" \
  -d @"workflows/meta-ads-diagnostics/clients/[CLIENT]/main-workflow.json"
```

## 🔧 Required Credentials in n8n

Each client needs the following credentials created in n8n:

### GoMarble Credentials (4 required):
- **38TERA GoMarble** (Bearer Auth)
- **Velocity Global GoMarble** (Bearer Auth) 
- **Franki GoMarble** (Bearer Auth)
- **Franki B2B GoMarble** (Bearer Auth)

### Shared Credentials:
- **Slack account** (OAuth2) - Used by all clients
- **Anthropic account** (API Key) - Used by all clients
- **Default SMTP** (SMTP) - Used for error emails

## 📋 Post-Deployment Checklist

### 1. Create GoMarble Credentials
For each client, create a Bearer Auth credential in n8n:
- Name: `[CLIENT_NAME] GoMarble`
- Type: Bearer Auth
- Token: [Client's GoMarble API token]

### 2. Verify Slack Channel Access
Ensure the Slack bot has access to all channels:
- ✅ internal_38tera_reports (C098MCUF6QJ)
- ✅ internal_velocityglobal_reports (C09930US3MX)
- ✅ internal_franki_reports (C098MGGESBC)
- ✅ internal_franki_b2b_reports (C09C1UPJHS5)

### 3. Activate Workflows
In n8n dashboard, activate both workflows for each client:
- Main Workflow (for reports)
- Error Handler (for error notifications)

### 4. Test Each Workflow
Manually trigger each main workflow to verify:
- GoMarble connection works
- Reports generate correctly
- Slack posting works
- Error handling functions

## 🔄 Workflow Configuration Details

### Schedule
All workflows run on the same schedule:
- **Time**: 9:00 AM PST/PDT
- **Days**: Monday and Friday
- **Cron**: `0 9 * * 1,5`

### Client-Specific Configurations

#### 38TERA (E-commerce):
```json
{
  "ACCOUNT_ID": "732630268714732",
  "PRIORITY_EVENTS": "Purchases, Add to Cart, Initiate Checkout",
  "CAC_TARGET": "$100",
  "ROAS_GOOD": ">1.0",
  "HIGH_CAC_THRESHOLD": "$150"
}
```

#### Velocity Global (B2B):
```json
{
  "ACCOUNT_ID": "875613839312619",
  "PRIORITY_EVENTS": "Lead, Demo Request, Contact",
  "CAC_TARGET": "$200",
  "ROAS_GOOD": ">1.2",
  "HIGH_CAC_THRESHOLD": "$300"
}
```

#### Franki (E-commerce):
```json
{
  "ACCOUNT_ID": "514315682954036",
  "PRIORITY_EVENTS": "Purchase, Add to Cart, Initiate Checkout",
  "CAC_TARGET": "$50",
  "ROAS_GOOD": ">2.0",
  "HIGH_CAC_THRESHOLD": "$75"
}
```

#### Franki B2B:
```json
{
  "ACCOUNT_ID": "815256732728440",
  "PRIORITY_EVENTS": "Lead, Demo Request, Contact",
  "CAC_TARGET": "$200",
  "ROAS_GOOD": ">1.5",
  "HIGH_CAC_THRESHOLD": "$300"
}
```

## 🚨 Error Handling

Each client has a dedicated error handler workflow that:

1. **First Failure**: Sends light notification + waits 30 seconds for retry
2. **Retry Failure**: Sends comprehensive alert + email notification
3. **Multiple Channels**: Slack + Email for critical failures
4. **Debug Information**: Execution links and troubleshooting steps

## 📊 Monitoring

### Slack Channels:
- **38TERA**: #internal_38tera_reports
- **Velocity Global**: #internal_velocityglobal_reports  
- **Franki**: #internal_franki_reports
- **Franki B2B**: #internal_franki_b2b_reports

### Email Alerts:
All error notifications sent to: malachi@mavan.com

## 🔧 Troubleshooting

### Common Issues:

1. **GoMarble Connection Errors**:
   - Verify Bearer Auth token is correct
   - Check account access permissions
   - Confirm GoMarble account ID format

2. **Slack Posting Failures**:
   - Verify OAuth2 credentials
   - Check channel permissions
   - Confirm channel IDs are correct

3. **Missing Reports**:
   - Check workflow activation status
   - Verify cron schedule (PST/PDT timezone)
   - Review execution logs in n8n

4. **Anthropic API Limits**:
   - Monitor API usage
   - Consider rate limiting between workflows
   - Verify API key has sufficient credits

### Debug Commands:

```bash
# Check workflow status
curl -H "X-N8N-API-KEY: [KEY]" \
  "https://mavan.app.n8n.cloud/api/v1/workflows/[WORKFLOW_ID]"

# List all executions
curl -H "X-N8N-API-KEY: [KEY]" \
  "https://mavan.app.n8n.cloud/api/v1/executions?workflowId=[WORKFLOW_ID]"
```

## 📈 Future Considerations

### Scaling:
- Add new clients by running the Python generator script
- Consider workflow scheduling to avoid API limits
- Monitor GoMarble API usage across all clients

### Enhancements:
- Real-time alerts for critical performance drops
- Custom thresholds per client industry
- Integration with client dashboards
- Historical performance tracking

---

**Deployment completed:** $(date)  
**Total workflows:** 8 (4 main + 4 error handlers)  
**Clients supported:** 4 Meta Ads accounts  
**Report frequency:** Twice weekly (Mon/Fri 9AM PST)