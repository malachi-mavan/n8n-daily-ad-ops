# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an n8n workflow builder project with MCP (Model Context Protocol) integration focused on **Meta Ads performance reporting automation**. The project contains the "Daily Ad Ops Checklist v3" workflow and its enhanced version, which generates automated daily diagnostics reports for 38TERA's Meta Ads account (732630268714732).

### Key Components
- **Original Workflow**: `daily-ad-ops-checklist-v3.json` - Production workflow with basic functionality
- **Enhanced Workflow**: `daily-ad-ops-checklist-v3-enhanced.json` - Improved version with real campaign names, multi-factor creative alerts, and statistical anomaly detection
- **GoMarble MCP Integration**: Provides access to Meta Ads data for account analysis
- **n8n MCP Server**: 535+ n8n nodes with comprehensive documentation for workflow management

### Recent Enhancements (2025-08-21)
The workflow has been enhanced to address key issues:
1. **Real Campaign Names**: Fixed placeholder issue, now shows actual campaign names
2. **Enhanced Creative Alerts**: Multi-factor detection (frequency >3.0, CPM >25%, CTR drops >30%)
3. **Statistical Anomaly Detection**: $500+ spend threshold for breakthrough/failure alerts
4. **Better Data Validation**: Timezone context, completeness checks, error handling

## n8n MCP Integration

### Available MCP Tools

**Documentation & Discovery:**
- `search_nodes()` - Search nodes by keywords
- `list_nodes()` - Browse available n8n nodes with filters
- `list_ai_tools()` - List AI-capable nodes
- `get_node_essentials()` - Get key node properties and examples
- `get_node_for_task()` - Get pre-configured node settings for common tasks

**Validation Tools:**
- `validate_node_minimal()` - Quick validation for required fields
- `validate_node_operation()` - Comprehensive node configuration validation
- `validate_workflow()` - Full workflow validation

**Workflow Management (requires n8n API):**
- `n8n_create_workflow()` - Create new workflows
- `n8n_update_partial_workflow()` - Update workflows using diff operations
- `n8n_get_workflow()` - Retrieve workflow details
- `n8n_list_workflows()` - List all workflows
- `n8n_trigger_webhook_workflow()` - Trigger webhook workflows
- `n8n_health_check()` - Verify connection to n8n instance

## Multi-Phase Workflow Development Process

### IMPORTANT: Follow this structured approach for complex workflows

### Phase 1: Planning
- Create `docs/usecase.md` documenting the workflow requirements
- DO NOT specify particular nodes or services yet
- Let the system brainstorm which tools and services are needed
- Focus on the business logic and desired outcomes

### Phase 2: Research
- Clear context with `/cle` command before starting
- Read `docs/usecase.md` to guide research
- Use MCP tools to research relevant nodes:
  - `search_nodes()` for specific functionality
  - `list_nodes()` to browse categories
  - `get_node_essentials()` for configuration details
- Save all findings to `docs/node_research.md`

### Phase 3: Build
- Clear context with `/cle` command
- Read both `docs/usecase.md` and `docs/node_research.md`
- Create `workflows/workflow.json` using researched nodes
- Use `n8n_create_workflow()` to push to n8n platform
- Focus only on nodes identified during research phase

### Phase 4: Validate
- Start a fresh session with `/cle`
- Read the `workflows/workflow.json` file
- Use validation tools to check every node configuration
- Verify no hallucinated fields exist
- Fix any configuration mismatches

## Critical Workflow Rules

### Delete and Recreate Strategy
- ALWAYS delete existing workflow before creating a new version
- DO NOT use `apply_diff` - it often fails
- Use `n8n_delete_workflow()` then `n8n_create_workflow()`

### OAuth First Policy
- ALWAYS prefer OAuth connections over API keys
- For Google services: use OAuth integration in n8n
- For other services: check OAuth availability first
- Only fall back to API keys when OAuth is unavailable

### Version Management
- ALWAYS ensure n8n instance is updated to latest version
- Check version compatibility before starting work
- Run `n8n_health_check()` to verify connection

## Debugging Strategy

### Isolate Problematic Nodes
When a node isn't working:
1. DO NOT rebuild the entire workflow
2. Create a new workflow in `workflows/debug/` with ONLY the problematic node
3. Test the isolated node configuration
4. Once fixed, apply the solution to the main workflow
5. This prevents context overflow and speeds up debugging

### Common Issues and Solutions
- **Node field hallucination**: Always validate against documentation
- **Version mismatches**: Update n8n instance to latest
- **OAuth errors**: Ensure OAuth is properly configured in n8n settings
- **API connection failures**: Verify API URL and key are correct

## Project Structure

```
/n8n-builder/
├── CLAUDE.md               # This file - AI assistant instructions
├── workflows/              # Workflow JSON files
│   ├── workflow.json      # Main workflow
│   └── debug/             # Isolated node tests
├── docs/
│   ├── usecase.md         # Workflow planning documentation
│   └── node_research.md   # Node research findings
├── config/
│   └── mcp-config.json    # MCP server configuration
└── .env                   # n8n API credentials (local only)
```

## Common Development Commands

### MCP Server
```bash
# Test MCP connection
npx n8n-mcp --version

# Run setup script for n8n connection
./setup-n8n-mcp.sh
```

### n8n Workflow Management
```bash
# These are handled via MCP tools, not CLI commands
# Use the MCP tools listed above instead
```

## File Management

### Important Files to Track
- `docs/usecase.md` - Always create for new workflows
- `docs/node_research.md` - Document all node research
- `workflows/workflow.json` - Main workflow file
- `workflows/debug/*.json` - Debugging workflows

### Files to Read on Startup
When starting a new session, check for:
1. `docs/usecase.md` - To understand the current task
2. `docs/node_research.md` - To see completed research
3. `workflows/daily-ad-ops-checklist-v3.json` - Original workflow (production)
4. `workflows/daily-ad-ops-checklist-v3-enhanced.json` - Enhanced workflow (testing/new features)
5. `docs/prompt-improvements-final.md` - Latest enhancement documentation
6. `docs/examples/meta-ads-daily-report-enhanced-example.md` - Expected output format

## Best Practices

1. **Always validate before pushing** - Use validation tools extensively
2. **Keep context manageable** - Use `/cle` between phases
3. **Document everything** - Update usecase.md and node_research.md
4. **Test incrementally** - Build and test small sections
5. **Use OAuth** - Avoid manual API key management
6. **Isolate problems** - Debug nodes individually
7. **Version control** - Save workflow versions before major changes

## Important Notes

- The MCP server has access to documentation for 535+ nodes
- Always work in the `/Users/malachirose/Projects/n8n-builder` directory
- MCP connection is folder-specific - won't work if you change directories
- Use environment variables for sensitive configuration
- Never commit API keys or credentials to version control

## Workflow-Specific Context

### Daily Ad Ops Checklist v3
- **Account ID**: 732630268714732 (38TERA Meta Ads account)
- **Schedule**: 9 AM PST/PDT, Monday-Friday
- **Data Source**: GoMarble MCP (https://apps.gomarble.ai/mcp-api/sse)
- **Output**: Slack channel `internal_38tera_reports`
- **Key Metrics**: ROAS, CAC, CPM, CTR, Conversions, Frequency
- **Status Thresholds**: ROAS >1.0 = 🟢, 0.8-1.0 = 🟡, <0.8 = 🔴

### Enhancement History
- **v3 Original**: Basic daily report with placeholder campaign names
- **v3 Enhanced**: Real campaign names, multi-factor alerts, anomaly detection
- **Key Improvements**: Frequency monitoring (7-day >3.0), CPM spikes (>25%), statistical significance ($500+ spend)

### Future Considerations
- **BigQuery Migration**: Planned alternative to GoMarble MCP for direct data access
- **Multi-Account Support**: Potential expansion beyond single account
- **Real-time Alerts**: Consider immediate notifications for critical issues