# n8n Builder with MCP Integration

This project provides an AI-assisted n8n workflow development environment using Claude Code and the n8n MCP (Model Context Protocol) server.

## Features

- **535+ n8n Nodes**: Full access to n8n node documentation
- **AI-Powered Workflow Creation**: Build workflows using natural language
- **Validation Tools**: Comprehensive validation for nodes and workflows
- **Workflow Management**: Create, update, and manage workflows programmatically
- **Debugging Support**: Isolate and test individual nodes

## Quick Start

### 1. Setup n8n Connection (Optional)

If you have an n8n instance running, configure the connection:

```bash
./setup-n8n-mcp.sh
```

This will prompt you for:
- Your n8n instance URL (e.g., `http://localhost:5678`)
- Your n8n API key (generate from n8n Settings → API)

### 2. Add MCP to Claude Code

1. Copy the configuration from `config/mcp-config.json`
2. In Claude Code, use the command: `add mcp server`
3. Paste the configuration when prompted
4. The MCP will be available in this folder only

### 3. Verify Connection

After adding the MCP, you can verify it's working:
- Check the MCP section in Claude Code
- Look for "n8n-mcp" in the connected servers list

## Examples and Test Data

Reference examples and test outputs in the `docs/examples/` folder:

- **Meta Ads Daily Report**: See `docs/examples/meta-ads-daily-report-example.md` for expected output format
- **Test Data**: Use examples to validate workflow functionality and understand data structures

## Working with Existing Workflows

To import and debug an existing workflow from your n8n instance:

1. **Get Workflow ID**: Find the workflow ID in your n8n instance URL
2. **Import Workflow**: Use the MCP tool `n8n_get_workflow()` with the ID
3. **Save Locally**: Save the workflow to `workflows/existing-workflow.json`
4. **Debug**: Create isolated test workflows in `workflows/debug/` for problematic nodes

## Multi-Phase Workflow Development

For complex workflows, follow the structured approach:

1. **Planning Phase**: Document requirements in `docs/usecase.md`
2. **Research Phase**: Research nodes and save to `docs/node_research.md`
3. **Build Phase**: Create workflow in `workflows/workflow.json`
4. **Validate Phase**: Validate all node configurations

See `CLAUDE.md` for detailed phase instructions.

## Project Structure

```
n8n-builder/
├── workflows/          # Workflow JSON files
│   └── debug/         # Isolated node tests
├── docs/              # Documentation
│   └── examples/      # Example outputs and test data
├── config/            # Configuration files
└── CLAUDE.md          # AI assistant instructions
```

## Important Notes

- **Always update n8n** to the latest version before starting
- **Use OAuth** instead of API keys when possible
- **Work in this directory** - MCP connection is folder-specific
- **Never commit** API keys or credentials

## Troubleshooting

### MCP Not Connected
- Ensure you're in the `/Users/malachirose/Projects/n8n-builder` directory
- Re-add the MCP server configuration
- Check that npx is installed and working

### Workflow Errors
- Update n8n to the latest version
- Use validation tools before pushing workflows
- Debug problematic nodes in isolation

### API Connection Issues
- Verify n8n instance is running
- Check API URL and key are correct
- Ensure n8n API is enabled in settings

## Resources

- **GitHub Repository**: https://github.com/malachi-mavan/n8n-daily-ad-ops
- [n8n Documentation](https://docs.n8n.io/)
- [n8n MCP GitHub](https://github.com/czlonkowski/n8n-mcp)
- [Claude Code Documentation](https://claude.ai/code)