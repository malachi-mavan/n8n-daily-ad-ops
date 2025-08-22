# Enhanced Workflow Deployment Guide

## 🚀 Immediate Testing Steps

### Step 1: Import Enhanced Workflow to n8n

Using the n8n MCP tools (ensure MCP is connected):

```javascript
// Read the enhanced workflow JSON
const enhancedWorkflow = await readFile('workflows/daily-ad-ops-checklist-v3-enhanced.json');

// Import to n8n using MCP
n8n_create_workflow({
  workflow_json: enhancedWorkflow,
  name: "Daily Ad Ops Checklist v3 Enhanced - TEST"
});
```

### Step 2: Pre-Deployment Validation Checklist

#### ✅ Configuration Validation
- [ ] GoMarble MCP credentials are active
- [ ] Anthropic API key is valid (`claude-sonnet-4-20250514`)
- [ ] Slack OAuth2 connection works
- [ ] Slack channel `internal_38tera_reports` is accessible

#### ✅ Data Source Validation
- [ ] GoMarble MCP returns actual campaign names (not placeholders)
- [ ] Meta Ads account ID `732630268714732` is accessible
- [ ] Data covers yesterday's reporting period
- [ ] Timezone is set to PST/PDT

#### ✅ Alert Logic Validation
- [ ] Frequency calculation uses 7-day window
- [ ] CPM spike detection uses 25% threshold
- [ ] CTR drop detection uses 30% threshold
- [ ] Anomaly detection requires $500+ spend

### Step 3: Test Execution

#### Manual Test Run
1. **Trigger workflow manually** (don't wait for 9 AM schedule)
2. **Monitor execution** for each node:
   - Schedule Trigger → Enhanced Report Prompt
   - Enhanced Report Prompt → Enhanced AI Agent
   - Enhanced AI Agent → Slack Post
3. **Check for errors** in GoMarble MCP connection
4. **Verify output** in Slack channel

#### Expected Output Validation
Compare against `docs/examples/meta-ads-daily-report-enhanced-example.md`:

- [ ] **Real campaign names** appear (not "[Campaign A]")
- [ ] **Creative alerts** show multiple conditions
- [ ] **Anomaly section** only appears with significant changes
- [ ] **Momentum indicator** shows trend direction
- [ ] **Action items** include impact estimates
- [ ] **Daily comparison** section is populated
- [ ] **Data timestamps** are included

### Step 4: Performance Comparison

#### Side-by-Side Test
1. **Keep original workflow active** for comparison
2. **Run enhanced workflow** at same time (manual trigger)
3. **Compare outputs** for same data period

#### Quality Metrics
- **Campaign name accuracy**: Enhanced should show 100% real names
- **Alert relevance**: Enhanced should have more specific alerts
- **Actionability**: Enhanced should have dollar impact estimates
- **Data completeness**: Enhanced should handle missing data better

## 🔧 Troubleshooting Common Issues

### Issue: Campaign Names Still Show Placeholders
**Solution**: Check GoMarble MCP data retrieval
```javascript
// Test MCP data access
search_nodes("meta ads campaign");
get_node_essentials("meta_ads_campaign_node");
```

### Issue: Creative Alerts Not Triggering
**Solution**: Verify thresholds in prompt
- Frequency: >3.0 (7-day window)
- CPM: >25% from account average
- CTR: >30% drop from 7-day average

### Issue: Anomaly Section Always Empty
**Solution**: Check spend thresholds
- Minimum: $500 spend for significance
- Changes: >50% improvement/decline
- Data: Requires previous period comparison

### Issue: Data Validation Errors
**Solution**: Check timezone and date handling
- PST/PDT timezone for "yesterday"
- Monday uses Friday as "yesterday"
- Data freshness validation

## 📊 Monitoring Setup

### Daily Monitoring (First Week)
- [ ] **Output quality**: Real names, relevant alerts
- [ ] **Execution time**: Should complete within 5 minutes
- [ ] **Error rate**: Should be <5%
- [ ] **Slack delivery**: Consistent posting to channel

### Weekly Review (First Month)
- [ ] **Alert accuracy**: How many alerts were actionable?
- [ ] **False positives**: Which alerts were not useful?
- [ ] **Missing alerts**: What issues were missed?
- [ ] **Threshold tuning**: Do any thresholds need adjustment?

## 🎯 Success Criteria

### Immediate (First Run)
- ✅ Workflow executes without errors
- ✅ Real campaign names appear in output
- ✅ Enhanced creative alerts function
- ✅ Report posts to Slack successfully

### Short-term (First Week)
- ✅ All reports show real campaign names
- ✅ Creative alerts provide actionable insights
- ✅ Anomaly detection flags significant changes only
- ✅ Action items help prioritize optimizations

### Medium-term (First Month)
- ✅ Time savings: 30+ minutes/day on analysis
- ✅ Issue detection: Catch problems 50% faster
- ✅ Decision making: Clearer optimization priorities
- ✅ Team adoption: Regular use of recommendations

## 🚀 Deployment Decision

### Go/No-Go Criteria
**GO** if:
- ✅ Test execution successful
- ✅ Campaign names are real
- ✅ Enhanced alerts work properly
- ✅ Output quality exceeds original

**NO-GO** if:
- ❌ Frequent execution errors
- ❌ Data quality issues
- ❌ Alert false positives >20%
- ❌ Performance regression

### Deployment Options

#### Option 1: Gradual Rollout
1. **Week 1**: Enhanced workflow runs alongside original
2. **Week 2**: Enhanced becomes primary, original as backup
3. **Week 3**: Deactivate original if enhanced performs well

#### Option 2: Immediate Switch
1. **Backup original workflow**
2. **Replace with enhanced version**
3. **Monitor closely for first 3 days**
4. **Rollback plan ready if needed**

### Rollback Plan
If issues arise:
1. **Immediate**: Reactivate original workflow
2. **Analysis**: Identify specific problem areas
3. **Fix**: Address issues in enhanced version
4. **Retest**: Validate fixes before re-deployment

---

**Next Action**: Run manual test of enhanced workflow to validate all improvements are working correctly.