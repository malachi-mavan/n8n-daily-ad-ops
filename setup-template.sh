#!/bin/bash

# Project Template Setup Script
# Based on MAVAN agents project optimizations

set -e

PROJECT_NAME=${1:-"new-project"}
TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Setting up new project: $PROJECT_NAME"
echo "📁 Template directory: $TEMPLATE_DIR"

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

echo "📂 Creating directory structure..."

# Create main directories
mkdir -p {docs/{architecture,phases,archive},config/{clients,environments},src/{agents,orchestrators,shared},agents,orchestrators,shared/{config,interfaces,utils},knowledge-base/{clients,frameworks,templates},prompts/{orchestrators,sub-agents},workflows,tests/{runners,phases,state},scripts/{setup,maintenance},outputs,cache}

# Create essential files
touch {README.md,CLAUDE.md,PRD.md,ROADMAP.md,SETUP.md,SECURITY.md}

# Create claude.md files for each directory
for dir in docs config src agents orchestrators shared knowledge-base prompts tests scripts; do
    touch "$dir/claude.md"
done

# Copy template files
echo "📋 Copying template files..."

# Copy .gitignore template
cp "$TEMPLATE_DIR/.gitignore.template" .gitignore

# Copy package.json template
cp "$TEMPLATE_DIR/package.json.template" package.json

# Copy TEMPLATE_STRUCTURE.md
cp "$TEMPLATE_DIR/TEMPLATE_STRUCTURE.md" TEMPLATE_STRUCTURE.md

# Create example configuration
cat > config/clients/client-template.json << 'EOF'
{
  "id": "client-name",
  "name": "Client Display Name",
  "description": "Client description",
  "config": {
    "key1": "value1",
    "key2": "value2"
  }
}
EOF

# Create initial CLAUDE.md
cat > CLAUDE.md << EOF
# Claude Code Context for $PROJECT_NAME

## Project Overview
[Brief project description]

## Current Status ($(date +"%B %d, %Y") - Session 1)
- 🚧 **In Progress**: Initial project setup
- 🔜 **Next**: [Upcoming tasks]

## Key Files & Structure
- \`src/\` - Core application code
- \`agents/\` - Specialized modules
- \`config/\` - Configuration management
- \`docs/\` - Documentation

## Development Principles
- Documentation-first development
- Consistent file organization
- Configuration management
- Comprehensive testing

## Quick Commands
\`\`\`bash
npm run dev          # Development mode
npm test             # Run tests
npm run setup        # Setup project
npm run update-docs  # Update documentation
\`\`\`
EOF

# Create initial README.md
cat > README.md << EOF
# $PROJECT_NAME

## Overview
[Project description]

## Quick Start
\`\`\`bash
npm install
npm run setup
npm run dev
\`\`\`

## Project Structure
See \`TEMPLATE_STRUCTURE.md\` for detailed structure information.

## Development
- \`npm run dev\` - Start development server
- \`npm test\` - Run test suite
- \`npm run update-docs\` - Update documentation

## Documentation
- \`CLAUDE.md\` - Current development context
- \`docs/\` - Comprehensive documentation
- \`ROADMAP.md\` - Implementation tracking
EOF

# Initialize git
echo "🔧 Initializing git repository..."
git init
git add .
git commit -m "Initial project structure from template"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

echo "✅ Project setup complete!"
echo ""
echo "Next steps:"
echo "1. Customize project name and description in package.json"
echo "2. Update CLAUDE.md with project-specific context"
echo "3. Create initial claude.md files for each directory"
echo "4. Start implementing your project!"
echo ""
echo "Project created at: $(pwd)"
echo ""
echo "Quick commands:"
echo "  npm run dev          # Start development"
echo "  npm test             # Run tests"
echo "  npm run setup        # Additional setup"
echo "  npm run update-docs  # Update documentation"
