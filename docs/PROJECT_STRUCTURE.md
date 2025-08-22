# N8N Builder - Project Structure

## Overview

This project contains n8n workflows for automated advertising performance reporting with MCP (Model Context Protocol) integration. Each workflow type is organized by platform and version for clear progression tracking and easy deployment.

## Directory Structure

```
/n8n-builder/
├── workflows/                          # All workflow definitions
│   ├── meta-ads-diagnostics/           # Meta Ads reporting workflows
│   │   ├── v7/                         # Version 7 files
│   │   │   ├── meta-ads-diagnostics-v7.json
│   │   │   ├── meta-ads-diagnostics-v7-clean.json
│   │   │   ├── meta-ads-v7-minimal.json
│   │   │   └── v7-enhanced-prompt.txt
│   │   ├── v8/                         # Version 8 files (current)
│   │   │   ├── meta-ads-diagnostics-v8.json
│   │   │   └── v8-enhanced-prompt.txt
│   │   └── clients/                    # Client-specific configurations
│   ├── google-ads-diagnostics/         # Google Ads workflows (future)
│   ├── tiktok-ads-diagnostics/         # TikTok Ads workflows (future)
│   └── debug/                          # Isolated node testing
│       ├── test-anthropic-model.json
│       ├── test-gomarble-mcp-client.json
│       └── test-slack-integration.json
├── docs/                               # Documentation by workflow type
│   ├── meta-ads-diagnostics/
│   │   ├── DEVELOPMENT_LOG.md          # Detailed development history
│   │   ├── VERSION_HISTORY.md          # Version comparison and features
│   │   └── CLIENT_SETUP_GUIDE.md       # Setup instructions
│   ├── examples/                       # Example outputs and formats
│   │   ├── meta-ads-daily-report-example.md
│   │   └── meta-ads-daily-report-enhanced-example.md
│   └── PROJECT_STRUCTURE.md            # This file
├── config/                             # MCP and system configuration
│   └── mcp-config.json                 # MCP server configuration
└── [ROOT DOCUMENTATION]                # Project-wide guides and setup
    ├── README.md                       # Main project overview
    ├── CLAUDE.md                       # AI assistant instructions
    ├── GITHUB_SETUP.md                 # Git repository setup
    └── [Other root-level guides]
```

## Workflow Organization Principles

### By Platform
Each advertising platform gets its own directory:
- **meta-ads-diagnostics/**: Facebook/Instagram Meta Ads
- **google-ads-diagnostics/**: Google Ads (planned)
- **tiktok-ads-diagnostics/**: TikTok Ads (planned)

### By Version
Within each platform, versions are clearly separated:
- **v7/**: Previous stable version with known issues
- **v8/**: Current production version with all fixes
- **clients/**: Multi-client deployment configurations

### File Naming Convention
- **Workflow JSON**: `[platform]-diagnostics-v[N].json`
- **Prompt Files**: `v[N]-enhanced-prompt.txt`
- **Client Configs**: `[client-name]-[platform]-v[N].json`

## Current Status

### Production Workflows

#### Meta Ads Diagnostics v8 ✅
- **Location**: `workflows/meta-ads-diagnostics/v8/`
- **n8n ID**: `gY7MTV11ZqRLtywG`
- **Status**: Active production workflow
- **Client**: 38TERA (Account ID: 732630268714732)
- **Schedule**: Monday/Friday 9AM PST
- **Features**: Real campaign names, L7D vs P7D comparison, DoD% calculation

#### Meta Ads Diagnostics v7 ⚠️
- **Location**: `workflows/meta-ads-diagnostics/v7/`
- **n8n ID**: `2huY1h4BJqlkeBgZ`
- **Status**: Backup/rollback option
- **Issues**: Title truncation, DoD% missing, unfair week comparisons

### Legacy Workflows
- **Original v3**: `workflows/daily-ad-ops-checklist-v3*.json` (preserved for reference)
- **Development versions**: v4, v5, v6 (moved to version-specific folders)

## Development Workflow

### Adding New Versions
1. Create new version directory: `workflows/[platform]/v[N]/`
2. Copy previous version as starting point
3. Make improvements and test
4. Document changes in `DEVELOPMENT_LOG.md`
5. Update `VERSION_HISTORY.md` with features and breaking changes
6. Upload to n8n and record workflow ID

### Adding New Platforms
1. Create platform directory: `workflows/[platform]-diagnostics/`
2. Create version subdirectory: `v1/`
3. Adapt existing workflow for new platform
4. Create platform-specific documentation
5. Update this PROJECT_STRUCTURE.md

### Multi-Client Deployment
1. Create client configurations in `clients/` directory
2. Generate workflow variants using client-specific parameters
3. Batch upload using n8n API
4. Document client-specific configurations

## Integration Points

### MCP (Model Context Protocol)
- **Config**: `config/mcp-config.json`
- **Server**: n8n-mcp (535+ nodes with documentation)
- **Usage**: Available in Claude Desktop, not Claude Code
- **Workaround**: Direct n8n API calls for workflow management

### n8n API
- **Base URL**: `https://mavan.app.n8n.cloud/api/v1/`
- **Authentication**: Bearer token (stored in config)
- **Endpoints**: workflows, executions, credentials
- **Rate Limits**: Standard n8n cloud limits

### GoMarble MCP
- **Purpose**: Meta Ads data retrieval
- **Endpoint**: `https://apps.gomarble.ai/mcp-api/sse`
- **Authentication**: Bearer Auth credentials in n8n
- **Data**: Campaign performance, creative metrics, conversion events

## File Conventions

### Workflow JSON Files
- **Complete**: Full n8n workflow definition with metadata
- **Clean**: API-ready version without read-only fields
- **Minimal**: Streamlined for upload with only essential fields

### Prompt Files
- **Purpose**: Store complete AI agent prompts for reference
- **Format**: Plain text with configuration sections
- **Usage**: Copy into n8n workflow Set node parameters

### Documentation
- **DEVELOPMENT_LOG.md**: Chronological development history
- **VERSION_HISTORY.md**: Feature comparison and upgrade paths
- **CLIENT_SETUP_GUIDE.md**: Instructions for new client setup

## Security Considerations

### Credential Management
- **API Keys**: Never stored in workflow JSON files
- **References**: Use n8n credential names only
- **GoMarble Tokens**: Stored as Bearer Auth credentials in n8n
- **Slack OAuth**: OAuth2 credentials for channel posting

### Data Handling
- **Account IDs**: Included in prompts as they're not sensitive
- **Client Names**: Used for workflow identification
- **Performance Data**: Retrieved live, not cached
- **Reports**: Posted to client-specific Slack channels

## Future Expansion

### Planned Features
- **Error Handling**: Workflow failure detection and recovery
- **Multi-Client System**: Batch generation and deployment
- **Cross-Platform Reports**: Unified reporting across ad platforms
- **Advanced Analytics**: Statistical significance and trend analysis

### Technical Debt
- **Root Level Cleanup**: Many guides should be organized by topic
- **Legacy File Removal**: Old workflow versions in root workflows/
- **Documentation Consolidation**: Multiple overlapping guides
- **Testing Framework**: Automated workflow validation

## Contributing Guidelines

### Before Making Changes
1. Read relevant DEVELOPMENT_LOG.md
2. Check VERSION_HISTORY.md for breaking changes
3. Test in debug/ directory first
4. Document all changes

### Code Organization
1. Use the established directory structure
2. Follow file naming conventions
3. Update documentation with every change
4. Commit frequently with descriptive messages

### Testing Protocol
1. Create isolated test workflows in debug/
2. Validate with actual data before production
3. Test Slack output formatting
4. Verify credential references work

This structure ensures clear organization, version tracking, and easy expansion as the project grows to support multiple platforms and clients.