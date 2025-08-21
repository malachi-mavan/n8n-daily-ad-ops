# Importing Existing n8n Workflows

## Prerequisites

1. Ensure your n8n MCP is connected with API credentials
2. Have your workflow ID ready (visible in n8n URL)

## Steps to Import

### 1. Get Workflow ID

In your n8n instance:
- Open the workflow you want to import
- Look at the URL: `https://your-n8n.com/workflow/WORKFLOW_ID`
- Copy the WORKFLOW_ID

### 2. Use MCP to Retrieve Workflow

In Claude Code, use the following MCP tool:

```
n8n_get_workflow(workflow_id="YOUR_WORKFLOW_ID")
```

### 3. Save Workflow Locally

Save the retrieved workflow JSON to:
```
workflows/imported-workflow.json
```

### 4. Validate the Workflow

Use validation tools to check the workflow:
```
validate_workflow(workflow_json)
```

## Debugging Imported Workflows

If you encounter issues with specific nodes:

1. **Identify Problem Node**: Note which node is failing
2. **Create Debug Workflow**: 
   ```
   workflows/debug/node-name-test.json
   ```
3. **Isolate Node**: Create a minimal workflow with just that node
4. **Test Configuration**: Verify all parameters are correct
5. **Apply Fix**: Once working, update the main workflow

## Common Import Issues

### OAuth vs API Keys
- Imported workflows may use API key authentication
- Consider switching to OAuth for better security
- Update credentials in n8n Settings → Credentials

### Version Compatibility
- Ensure your n8n instance is up-to-date
- Some nodes may have changed between versions
- Use `validate_node_operation()` to check compatibility

### Missing Credentials
- Credentials don't export with workflows
- You'll need to reconfigure them in your instance
- Check n8n Settings → Credentials

## Example Workflow Structure

```json
{
  "id": "workflow-id",
  "name": "My Workflow",
  "nodes": [
    {
      "parameters": {},
      "name": "Start",
      "type": "n8n-nodes-base.start",
      "position": [250, 300]
    }
  ],
  "connections": {},
  "settings": {
    "executionOrder": "v1"
  }
}
```

## Next Steps

After importing:
1. Validate all nodes
2. Update credentials
3. Test in isolation
4. Run full workflow test
5. Document any modifications in `docs/`