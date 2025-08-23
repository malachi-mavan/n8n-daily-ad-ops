# Client Onboarding Template

Use this template to add new clients to the Meta Ads Diagnostics system.

## 📋 New Client Information

### Client Details:
- **Client Name**: ____________________
- **Business Type**: [ ] E-commerce [ ] B2B [ ] SaaS [ ] Other: __________
- **Meta Ads Account ID**: ____________________
- **GoMarble Account ID**: act_____________________

### Slack Configuration:
- **Reports Channel**: ____________________
- **Channel ID**: ____________________
- **Error Channel**: ____________________  (can be same as reports)

### Contact Information:
- **Primary Email**: ____________________
- **Error Notification Email**: ____________________

### Performance Targets:
- **CAC Target**: $____________________
- **ROAS Good Threshold**: >____________________
- **High CAC Alert Threshold**: $____________________
- **Priority Conversion Events**: ____________________

## 🔧 Technical Setup

### 1. Update Client Configuration

Add to `config/client-configurations.json`:

```json
{
  "client_name": "[CLIENT_NAME]",
  "account_type": "meta",
  "account_id": "[ACCOUNT_ID]",
  "gomarble_account_id": "act_[ACCOUNT_ID]",
  "slack_channel": "[SLACK_CHANNEL_NAME]",
  "slack_channel_id": "[SLACK_CHANNEL_ID]",
  "error_email": "[ERROR_EMAIL]",
  "priority_events": "[PRIORITY_EVENTS]",
  "business_type": "[BUSINESS_TYPE]",
  "thresholds": {
    "ROAS_GOOD": ">[ROAS_THRESHOLD]",
    "ROAS_OK": "0.8-[ROAS_THRESHOLD]",
    "CAC_TARGET": "$[CAC_TARGET]",
    "FREQUENCY_MAX": "3.0",
    "NO_CONV_SPEND_MIN": "$250",
    "HIGH_CAC_THRESHOLD": "$[HIGH_CAC_THRESHOLD]",
    "CTR_DROP_THRESHOLD": "30%",
    "CPM_SPIKE_THRESHOLD": "25%"
  }
}
```

### 2. Generate Workflows

```bash
# Run the workflow generator
python3 scripts/generate-client-workflows.py
```

### 3. Deploy to n8n

```bash
# Deploy using automated script
./scripts/deploy-all-clients.sh

# Or deploy individual client
curl -X POST "https://mavan.app.n8n.cloud/api/v1/workflows" \
  -H "Content-Type: application/json" \
  -H "X-N8N-API-KEY: [API_KEY]" \
  -d @"workflows/meta-ads-diagnostics/clients/[client-name]/main-workflow.json"
```

### 4. Create n8n Credentials

Create in n8n dashboard:
- **Name**: `[CLIENT_NAME] GoMarble`
- **Type**: Bearer Auth  
- **Token**: [Client's GoMarble API token]

### 5. Configure Slack Access

Ensure Slack bot has access to client channels:
- Add bot to `#[CLIENT_CHANNEL]`
- Test message posting permissions
- Verify channel ID is correct

## ✅ Testing Checklist

### Pre-Activation Testing:
- [ ] GoMarble credential works
- [ ] Account ID retrieves data
- [ ] Slack channel accessible
- [ ] Error email deliverable
- [ ] Workflow syntax valid

### Post-Activation Testing:
- [ ] Manual workflow execution succeeds
- [ ] Report generates with real data
- [ ] Slack posting works correctly
- [ ] Error handler triggers properly
- [ ] Email notifications send

### Production Validation:
- [ ] Automated schedule triggers
- [ ] Report format looks good
- [ ] Client stakeholders receive reports
- [ ] No error alerts triggered
- [ ] Performance meets expectations

## 📊 Default Configurations by Business Type

### E-commerce:
```json
{
  "PRIORITY_EVENTS": "Purchase, Add to Cart, Initiate Checkout",
  "CAC_TARGET": "$75",
  "ROAS_GOOD": ">1.5",
  "HIGH_CAC_THRESHOLD": "$125"
}
```

### B2B:
```json
{
  "PRIORITY_EVENTS": "Lead, Demo Request, Contact",
  "CAC_TARGET": "$200",
  "ROAS_GOOD": ">1.2",
  "HIGH_CAC_THRESHOLD": "$300"
}
```

### SaaS:
```json
{
  "PRIORITY_EVENTS": "Trial Sign Up, Demo Request, Contact",
  "CAC_TARGET": "$150",
  "ROAS_GOOD": ">1.3",
  "HIGH_CAC_THRESHOLD": "$225"
}
```

## 🚨 Common Issues

### GoMarble Connection:
- **Issue**: "Unauthorized" error
- **Fix**: Verify API token has correct permissions
- **Check**: Token format should start with "Bearer "

### Slack Posting:
- **Issue**: Channel not found
- **Fix**: Verify channel ID (starts with C0...)
- **Check**: Bot must be member of channel

### Data Availability:
- **Issue**: No campaigns found
- **Fix**: Confirm account has active ads
- **Check**: Account ID format (numbers only)

### Workflow Errors:
- **Issue**: Template variables not resolving
- **Fix**: Check configuration object structure
- **Check**: All required fields present

## 📝 Documentation Updates

After adding a new client:

1. Update `multi-client-deployment-guide.md`
2. Add to monitoring dashboard
3. Include in backup procedures
4. Update credential rotation schedule
5. Add to client list in README

---

**Template Version**: 1.0  
**Last Updated**: $(date)  
**Contact**: malachi@mavan.com