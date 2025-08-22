# Enhanced Workflow Test Script

## Step 1: Import Enhanced Workflow

Run this command to import the enhanced workflow into your n8n instance:

```bash
# First, let's check the current n8n connection
n8n_health_check()
```

If the health check passes, proceed with importing:

```bash
# Import the enhanced workflow
# Note: This will create a new workflow alongside the existing one
n8n_create_workflow({
  "name": "Daily Ad Ops Checklist v3 Enhanced - TEST",
  "workflow": <contents_of_enhanced_workflow_json>
})
```

## Step 2: Validate Configuration

Check these key configurations in the imported workflow:

### ✅ Node Configurations to Verify

1. **Schedule Trigger**: `0 9 * * 1-5` (9 AM, Monday-Friday)
2. **Enhanced Report Prompt**: Contains all new instructions
3. **Enhanced AI Agent**: 
   - Max iterations: 25
   - Max tries: 3 (increased from 2)
   - System message includes data validation instructions
4. **GoMarble MCP Client**: Same endpoint and credentials
5. **Anthropic Chat Model**: `claude-sonnet-4-20250514`
6. **Slack Post**: Same channel and credentials

### ✅ Key Enhancements to Verify

1. **Data Retrieval Instructions**:
   - "Use GoMarble MCP tools to retrieve actual campaign names"
   - "Verify data covers the full reporting period for yesterday"
   - "Use PST/PDT timezone for 'yesterday' calculations"

2. **Campaign Naming Instructions**:
   - "Always use actual campaign names from the data, never placeholders like 'Campaign A'"
   - "Use actual creative names from the data"

3. **Enhanced Creative Alerts**:
   - Frequency >3.0 in last 7 days
   - CPM spike >25% from account avg
   - CTR drop >30% from 7-day average
   - Conv. rate drop >40% with >$100 spend

4. **Anomaly Detection**:
   - Minimum $500 spend for significance
   - >50% improvement for breakthroughs
   - >50% decline for critical failures

## Step 3: Manual Test Execution

### Execute Test Run

1. **Disable the original workflow** temporarily to avoid duplicate reports
2. **Manually trigger the enhanced workflow**
3. **Monitor execution** in n8n interface
4. **Check Slack channel** for output

### Execution Monitoring Checklist

Monitor each node execution:

- [ ] **Schedule Trigger**: ✅ Fires correctly
- [ ] **Enhanced Report Prompt**: ✅ Sets enhanced prompt
- [ ] **Enhanced AI Agent**: 
  - [ ] ✅ Connects to GoMarble MCP
  - [ ] ✅ Connects to Anthropic model
  - [ ] ✅ Executes analysis
  - [ ] ✅ Generates report within 25 iterations
- [ ] **Slack Post**: ✅ Posts to `internal_38tera_reports`

### Expected Output Validation

Compare the test output against these criteria:

#### ✅ Campaign Names
- [ ] **Real campaign names** appear (not "[Campaign A]", "[Campaign B]")
- [ ] **Campaign names** are descriptive and actual
- [ ] **Truncation** works for long names (>40 chars with "...")

#### ✅ Enhanced Creative Alerts
- [ ] **Multiple alert types** shown (not just spend changes)
- [ ] **Frequency alerts** use 7-day window
- [ ] **CPM alerts** use 25% threshold
- [ ] **CTR alerts** use 30% threshold
- [ ] **Conversion rate alerts** include spend minimum

#### ✅ Performance Anomalies
- [ ] **Section appears only** if significant changes detected
- [ ] **$500 minimum spend** enforced
- [ ] **Breakthrough criteria** >50% improvement
- [ ] **Failure criteria** >50% decline or 0 conversions

#### ✅ Enhanced Features
- [ ] **Momentum indicator** shows trend direction
- [ ] **Efficiency Score** appears (A/B/C/D/F grade)
- [ ] **Impact estimates** in action items ($XXX/day format)
- [ ] **Daily comparison** section populated
- [ ] **Data timestamps** included
- [ ] **Performance thresholds** documented

## Step 4: Quality Comparison

### Side-by-Side Comparison

If possible, compare with a recent output from the original workflow:

#### Campaign Names Quality
- **Original**: Shows placeholders like "[Campaign E]"
- **Enhanced**: Should show real names like "Brand Awareness - Q3 Launch"

#### Alert Sophistication
- **Original**: Only spend changes >20%
- **Enhanced**: Multiple factors (frequency, CPM, CTR, conversion rate)

#### Actionability
- **Original**: Generic action items
- **Enhanced**: Impact-quantified recommendations with dollar amounts

#### Data Handling
- **Original**: May show placeholder values
- **Enhanced**: Should handle missing data gracefully with context

## Step 5: Issue Troubleshooting

### Common Issues & Solutions

#### Issue: Still Shows Campaign Placeholders
**Diagnosis**: GoMarble MCP may not be returning campaign names
**Solution**: 
```bash
# Test MCP data access directly
search_nodes("meta ads campaign")
```

#### Issue: Creative Alerts Not Appearing
**Diagnosis**: Thresholds may be too strict or data insufficient
**Solution**: Check if account has enough historical data for comparisons

#### Issue: Anomaly Section Always Empty
**Diagnosis**: $500 spend threshold or 50% change threshold too high
**Solution**: Review actual account spend levels and typical changes

#### Issue: Execution Timeout
**Diagnosis**: GoMarble MCP taking too long or AI Agent iterations exceeded
**Solution**: Check MCP response times and consider reducing max iterations

## Step 6: Deployment Decision

### Go/No-Go Checklist

#### ✅ GO Criteria (All Must Pass)
- [ ] Workflow executes without errors
- [ ] Real campaign names appear consistently
- [ ] Enhanced alerts provide more insights than original
- [ ] Output quality exceeds original workflow
- [ ] Execution time <5 minutes
- [ ] No critical data missing

#### ❌ NO-GO Criteria (Any Triggers Hold)
- [ ] Frequent execution failures
- [ ] Campaign names still show placeholders
- [ ] Enhanced alerts show >20% false positives
- [ ] Data quality regression vs original
- [ ] Execution time >10 minutes

### Deployment Actions

#### If GO:
1. **Backup original workflow** configuration
2. **Deactivate original** workflow
3. **Activate enhanced** workflow
4. **Monitor closely** for first week
5. **Gather feedback** from team

#### If NO-GO:
1. **Document specific issues** encountered
2. **Keep original active** for production
3. **Fix issues** in enhanced version
4. **Retest** after fixes
5. **Schedule retry** for next week

---

**Next Action**: Run manual test execution and complete validation checklist before making deployment decision.