# Client Setup Guide - Meta Ads Diagnostics v7

## 🚀 Quick Setup (2 Minutes)

### Step 1: Import Workflow

1. Go to your n8n instance
2. Click "Import workflow"
3. Upload `workflows/meta-ads-diagnostics-v7.json`
4. **Important**: Rename the workflow to: `[CLIENT_NAME] - Meta Ads Diagnostics v7`

### Step 2: Update Client Configuration

Edit the prompt in the "v7 Production Prompt" node:

```
=== CLIENT CONFIGURATION ===
CLIENT_NAME: [CLIENT_NAME]                    # Change this
PLATFORM: Meta Ads                           # Keep as-is for Meta
ACCOUNT_ID: [CLIENT_ACCOUNT_ID]               # Change this
GOMARBLE_CREDENTIAL: Bearer Auth account     # Update credential name
SLACK_CHANNEL: [CLIENT_SLACK_CHANNEL]        # Change this
PRIORITY_EVENTS: Purchases, Add to Cart, Initiate Checkout  # Customize
REPORT_SCHEDULE: 0 9 * * 1,5 (Monday/Friday 9AM PST)       # Adjust if needed
===========================
```

### Step 3: Update Credentials

**GoMarble Credential:**
1. Go to n8n Credentials
2. Create new "Bearer Auth" credential
3. Add client's GoMarble token
4. Name it descriptively (e.g., "[CLIENT_NAME] GoMarble")
5. Update the workflow's GoMarble MCP Client node to use this credential

**Slack Credential:**
1. Create/use appropriate Slack OAuth2 credential
2. Update Slack Post node with client's channel ID
3. Test connection

**Anthropic Credential:**
1. Use existing Anthropic credential or create new one
2. Ensure sufficient usage limits

### Step 4: Test & Activate

1. **Manual Test**: Click "Test workflow" and verify output
2. **Check Output**: Ensure client name and account ID appear correctly
3. **Slack Check**: Verify report posts to correct channel
4. **Activate**: Turn on the workflow schedule

## 📊 Customization Options

### Performance Thresholds

Adjust these in the prompt configuration section:

```
=== PERFORMANCE THRESHOLDS ===
ROAS_GOOD: >1.0        # Client's profitability target
ROAS_OK: 0.8-1.0       # Acceptable range
CAC_TARGET: $100       # Client's target CAC
FREQUENCY_MAX: 3.0     # Ad fatigue threshold
NO_CONV_SPEND_MIN: $250  # Minimum spend for alerts
HIGH_CAC_THRESHOLD: $150 # CAC alert threshold
CTR_DROP_THRESHOLD: 30%  # CTR decline alert
CPM_SPIKE_THRESHOLD: 25% # CPM increase alert
===========================
```

### Schedule Options

Common schedule patterns:
- **Daily**: `0 9 * * 1-5` (Mon-Fri 9AM)
- **Bi-weekly**: `0 9 * * 1,5` (Mon/Fri 9AM)
- **Weekly**: `0 9 * * 1` (Monday 9AM)
- **Custom timezone**: Adjust hour for client timezone

### Conversion Events

Update based on client's tracking:
```
PRIORITY_EVENTS: Purchase, Lead, Sign Up
PRIORITY_EVENTS: Add to Cart, Initiate Checkout, Purchase
PRIORITY_EVENTS: Contact, Demo Request, Trial Sign Up
```

## 🔧 Platform Variations

### For Google Ads Clients

Update configuration section:
```
PLATFORM: Google Ads
ACCOUNT_ID: [GOOGLE_ADS_ACCOUNT_ID]
# Remove frequency-related thresholds
# Add Quality Score thresholds if needed
```

Update prompt output format:
- Change title to: `` `GOOGLE ADS DIAGNOSTICS REPORT` ``
- Replace Meta-specific metrics (Frequency) with Google-specific ones
- Update conversion event names as needed

### For Multi-Platform Clients

Create separate workflows:
- `[CLIENT] - Meta Ads Diagnostics v7`
- `[CLIENT] - Google Ads Diagnostics v7`
- `[CLIENT] - TikTok Ads Diagnostics v7`

## ✅ Validation Checklist

Before going live:

- [ ] **Workflow name** includes client name
- [ ] **Client configuration** all updated
- [ ] **Account ID** is correct
- [ ] **GoMarble credential** configured and tested
- [ ] **Slack channel** is correct
- [ ] **Priority events** match client's setup
- [ ] **Thresholds** align with client expectations
- [ ] **Manual test** runs successfully
- [ ] **Output format** looks correct
- [ ] **Schedule** is appropriate
- [ ] **Team notification** about new reports

## 📞 Support

If issues arise:

1. **Check logs** in n8n execution history
2. **Test credentials** individually
3. **Verify GoMarble** data access
4. **Check Slack permissions** for bot
5. **Review account ID** format and access

## 🎯 Common Customizations

### E-commerce Clients
```
PRIORITY_EVENTS: Purchase, Add to Cart, Initiate Checkout
CAC_TARGET: $50
ROAS_GOOD: >2.0
```

### Lead Generation Clients
```
PRIORITY_EVENTS: Lead, Contact, Demo Request
CAC_TARGET: $200
ROAS_GOOD: >1.5
```

### SaaS Clients
```
PRIORITY_EVENTS: Trial Sign Up, Demo Request, Contact
CAC_TARGET: $150
ROAS_GOOD: >1.2
```

---

**Total Setup Time**: ~2 minutes per client  
**Maintenance**: Update thresholds quarterly based on performance