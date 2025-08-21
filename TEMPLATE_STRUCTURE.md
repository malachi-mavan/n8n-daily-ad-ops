# Project Template Structure

## Overview
This template provides the optimized structure and best practices derived from the MAVAN agents project. Use this as a foundation for new projects to inherit proven patterns.

## Directory Structure

```
project-name/
├── README.md                    # Project overview and quick start
├── CLAUDE.md                    # Claude code context (session tracking)
├── PRD.md                       # Product Requirements Document
├── ROADMAP.md                   # Implementation tracking and phases
├── SETUP.md                     # Setup instructions and dependencies
├── SECURITY.md                  # Security guidelines and best practices
├── docs/                        # Comprehensive documentation
│   ├── claude.md               # Documentation directory guide
│   ├── architecture/           # System architecture documents
│   ├── phases/                 # Phase-specific implementation plans
│   └── archive/                # Historical and completed docs
├── config/                      # Configuration management
│   ├── claude.md               # Configuration directory guide
│   ├── client-manager.js       # Multi-client configuration system
│   ├── clients/                # Client configurations
│   │   └── client-template.json
│   └── environments/           # Environment-specific settings
├── src/                        # Core application code
│   ├── claude.md               # Source code directory guide
│   ├── agents/                 # AI agents and modules
│   ├── orchestrators/          # Higher-level coordinators
│   └── shared/                 # Common utilities and interfaces
├── agents/                      # Specialized agent modules
│   ├── claude.md               # Agents directory guide
│   ├── [agent-name]/           # Individual agent
│   │   ├── src/                # Agent source code
│   │   ├── package.json        # Dependencies
│   │   ├── claude.md           # Agent-specific guide
│   │   └── tests/              # Agent test files
│   └── output/                 # Agent outputs (gitignored)
├── orchestrators/               # Orchestration layer
│   ├── claude.md               # Orchestrators directory guide
│   └── [orchestrator-name]/    # Individual orchestrator
├── shared/                      # Shared utilities
│   ├── claude.md               # Shared directory guide
│   ├── config/                 # Shared configuration
│   ├── interfaces/             # Common interfaces
│   └── utils/                  # Utility functions
├── knowledge-base/              # Business knowledge and context
│   ├── claude.md               # Knowledge base guide
│   ├── clients/                # Client-specific context
│   │   └── client-context-template.md
│   ├── frameworks/             # Business frameworks
│   └── templates/              # Reusable templates
├── prompts/                     # LLM system prompts
│   ├── claude.md               # Prompts directory guide
│   ├── orchestrators/          # Orchestration prompts
│   └── sub-agents/             # Agent-specific prompts
├── workflows/                   # Workflow definitions
├── tests/                       # Test suite
│   ├── claude.md               # Testing guide
│   ├── runners/                # Test runners
│   ├── phases/                 # Phase-specific tests
│   └── state/                  # Test state management
├── scripts/                     # Utility scripts
│   ├── claude.md               # Scripts guide
│   ├── setup/                  # Setup scripts
│   └── maintenance/            # Maintenance scripts
├── outputs/                     # Generated outputs (gitignored)
├── cache/                       # Cache files (gitignored)
├── .gitignore                   # Git ignore patterns
├── package.json                 # Dependencies and scripts
└── railway.json                 # Deployment configuration
```

## Key Template Files

### 1. **CLAUDE.md** - Session Context
```markdown
# Claude Code Context for [Project Name]

## Project Overview
[Brief project description]

## Current Status ([Date] - Session [X])
- ✅ **Completed**: [What's done]
- 🚧 **In Progress**: [Current work]
- 🔜 **Next**: [Upcoming tasks]

## Key Files & Structure
[Quick reference to important files]

## Development Principles
[Core development philosophy]

## Quick Commands
[Common development commands]
```

### 2. **Directory claude.md** - Purpose Documentation
```markdown
# [Directory Name] Directory

## Purpose
[What this directory contains and why]

## Structure
[Key files and subdirectories]

## Usage
[How to use this directory]

## Integration Points
[How it connects to other parts]

## Important Notes
[Critical information and warnings]
```

### 3. **Configuration Template**
```json
{
  "id": "client-name",
  "name": "Client Display Name",
  "description": "Client description",
  "config": {
    "key1": "value1",
    "key2": "value2"
  }
}
```

## Best Practices to Inherit

### 1. **Documentation-First Development**
- Create `claude.md` files before implementing features
- Document purpose, structure, and usage patterns
- Maintain living documentation that updates with code

### 2. **Consistent File Organization**
- Each major component gets its own directory
- Standard subdirectory structure (`src/`, `tests/`, `config/`)
- Clear separation of concerns

### 3. **Configuration Management**
- Centralized configuration with client/environment separation
- Template-based setup for new clients
- Environment-specific configurations

### 4. **Testing Strategy**
- Comprehensive test coverage
- Phase-based testing approach
- State management for complex tests

### 5. **Security Practices**
- Credential management in config/
- .gitignore patterns for sensitive files
- Security documentation and guidelines

### 6. **Development Workflow**
- LLM-first approach for complex logic
- Clear phase-based development
- Automated documentation updates

## Setup Commands

```bash
# Create new project from template
mkdir new-project
cd new-project
cp -r ../template-structure/* .

# Initialize git
git init
git add .
git commit -m "Initial project structure"

# Install dependencies
npm install

# Create first claude.md
touch CLAUDE.md
```

## Customization Guidelines

1. **Adapt to Project Type**: Modify structure based on project needs
2. **Maintain Consistency**: Keep the same patterns across similar components
3. **Document Changes**: Update template when adding new patterns
4. **Version Control**: Track template evolution in separate repository

## Quick Start for n8n-builder

1. Copy this template structure to your n8n-builder project
2. Customize for n8n-specific needs (workflows, nodes, etc.)
3. Create initial claude.md files for each directory
4. Set up configuration management for different n8n instances
5. Implement testing strategy for workflow validation
