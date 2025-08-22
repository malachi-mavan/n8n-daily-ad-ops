# Daily Ad Ops Checklist v3 - Debug Guide

## ✅ Import Complete

Successfully imported **Daily Ad Ops Checklist v3** workflow:
- **Workflow ID**: `MEqMXD2wxJmkQEo4`
- **Status**: Inactive (needs debugging before activation)
- **Files Created**: 
  - `workflows/daily-ad-ops-checklist-v3.json` (original)
  - `workflows/daily-ad-ops-checklist-v3-formatted.json` (readable)
  - `docs/workflow-analysis-daily-ad-ops-v3.md` (analysis)

## 🔍 Issues Identified

### 🔴 High Priority Issues

1. **Outdated Claude Model**
   - Current: `claude-sonnet-4-20250514`
   - Problem: May be deprecated
   - **Fix**: Update to `claude-3-5-sonnet-20241022`

2. **External MCP Dependency**
   - Endpoint: `https://apps.gomarble.ai/mcp-api/sse`
   - Problem: External service reliability unknown
   - **Fix**: Test connection and have fallback plan

### 🟡 Medium Priority Issues

3. **Multiple Credential Dependencies**
   - Bearer Auth, Anthropic API, Slack OAuth2
   - Problem: May expire or become invalid
   - **Fix**: Verify all credentials are current

4. **Complex Prompt Structure**
   - Very detailed formatting requirements
   - Problem: Fragile if data changes
   - **Fix**: Test with various scenarios

## 🧪 Debug Workflows Created

### 1. Test GoMarble MCP Client
**File**: `workflows/debug/test-gomarble-mcp-client.json`
**Purpose**: Isolate and test the MCP client connection
**What it tests**:
- GoMarble API connectivity
- MCP tool availability
- Authentication validity

### 2. Test Anthropic Model
**File**: `workflows/debug/test-anthropic-model.json`
**Purpose**: Test Claude model without MCP complexity
**What it tests**:
- Anthropic API connection
- Model response quality
- Updated model version (`claude-3-5-sonnet-20241022`)

### 3. Test Slack Integration
**File**: `workflows/debug/test-slack-integration.json`
**Purpose**: Verify Slack posting works independently
**What it tests**:
- Slack OAuth2 authentication
- Channel posting permissions
- Message formatting

## 🚀 Debugging Process

### Step 1: Test Individual Components

1. **Import Debug Workflows**:
   ```bash
   # Use n8n MCP tools to create these test workflows
   n8n_create_workflow(workflow_json_from_debug_files)
   ```

2. **Run Tests in Order**:
   - Start with Slack integration (simplest)
   - Test Anthropic model (medium complexity)
   - Test GoMarble MCP (most complex)

### Step 2: Fix Identified Issues

1. **Update Claude Model**:
   - Change from `claude-sonnet-4-20250514`
   - To: `claude-3-5-sonnet-20241022`

2. **Verify Credentials**:
   - Check Anthropic API key validity
   - Verify Slack OAuth2 token
   - Test GoMarble bearer token

3. **Test GoMarble Endpoint**:
   ```bash
   curl -H "Authorization: Bearer YOUR_TOKEN" https://apps.gomarble.ai/mcp-api/sse
   ```

### Step 3: Integration Testing

1. **Modify Main Workflow**:
   - Apply fixes from successful debug tests
   - Update model version
   - Add error handling

2. **Test Full Workflow**:
   - Run end-to-end test
   - Monitor for errors
   - Verify Slack output

## 📝 Recommended Improvements

### Error Handling
- Add try/catch blocks around MCP calls
- Implement fallback messaging if MCP fails
- Add notification for credential expiration

### Monitoring
- Add health checks before main execution
- Log execution times and success rates
- Alert on consecutive failures

### Maintenance
- Schedule credential refresh reminders
- Version control workflow changes
- Document any custom configurations

## 🔧 Quick Fixes to Apply

1. **Update model reference**:
   ```json
   "model": {
     "__rl": true,
     "value": "claude-3-5-sonnet-20241022",
     "mode": "id"
   }
   ```

2. **Add error handling to AI Agent**:
   ```json
   "onError": "continueRegularOutput",
   "retryOnFail": true,
   "maxTries": 3
   ```

3. **Add health check before main execution**:
   - Test MCP connectivity
   - Verify credentials
   - Validate data sources

## 🎯 Success Metrics

After debugging, the workflow should:
- ✅ Execute without errors
- ✅ Generate properly formatted reports
- ✅ Post successfully to Slack
- ✅ Handle credential/API issues gracefully
- ✅ Complete within reasonable time limits

## 📞 Support Resources

- **n8n MCP Tools**: Available for workflow management
- **GoMarble Documentation**: Check their API docs
- **Anthropic API Status**: Monitor for service issues
- **Slack API**: Verify app permissions

---

**Next Steps**: Run the debug workflows to isolate issues, then apply fixes to the main workflow.