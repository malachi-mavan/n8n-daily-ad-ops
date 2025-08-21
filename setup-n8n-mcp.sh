#!/bin/bash

# n8n MCP Setup Script
# This script helps configure the n8n MCP connection for Claude Code

echo "========================================="
echo "n8n MCP Setup for Claude Code"
echo "========================================="
echo ""

# Check if n8n instance details are needed
read -p "Do you have an n8n instance running? (y/n): " has_instance

if [[ "$has_instance" == "y" || "$has_instance" == "Y" ]]; then
    echo ""
    echo "Please provide your n8n instance details:"
    echo ""
    
    # Get n8n URL
    read -p "Enter your n8n instance URL (e.g., http://localhost:5678): " n8n_url
    
    # Get n8n API Key
    echo ""
    echo "To get your API key:"
    echo "1. Open your n8n instance"
    echo "2. Go to Settings → API"
    echo "3. Generate an API key"
    echo ""
    read -p "Enter your n8n API key: " n8n_api_key
    
    # Update the config file
    cat > config/mcp-config.json << EOF
{
  "mcpServers": {
    "n8n-mcp": {
      "command": "npx",
      "args": ["n8n-mcp"],
      "env": {
        "MCP_MODE": "stdio",
        "LOG_LEVEL": "error",
        "DISABLE_CONSOLE_OUTPUT": "true",
        "N8N_API_URL": "$n8n_url",
        "N8N_API_KEY": "$n8n_api_key"
      }
    }
  }
}
EOF
    
    echo ""
    echo "✅ Configuration saved to config/mcp-config.json"
    
    # Create .env file for local reference
    cat > .env << EOF
N8N_API_URL=$n8n_url
N8N_API_KEY=$n8n_api_key
EOF
    
    echo "✅ Environment variables saved to .env"
    
else
    echo ""
    echo "No problem! The MCP will work in documentation-only mode."
    echo "You can still access node documentation and create workflows locally."
    
    # Create config without API credentials
    cat > config/mcp-config.json << EOF
{
  "mcpServers": {
    "n8n-mcp": {
      "command": "npx",
      "args": ["n8n-mcp"],
      "env": {
        "MCP_MODE": "stdio",
        "LOG_LEVEL": "error",
        "DISABLE_CONSOLE_OUTPUT": "true"
      }
    }
  }
}
EOF
    
    echo ""
    echo "✅ Configuration saved to config/mcp-config.json (documentation mode)"
fi

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "To add this MCP to Claude Code:"
echo "1. Copy the contents of config/mcp-config.json"
echo "2. Use the 'add mcp server' command in Claude Code"
echo "3. Paste the configuration when prompted"
echo ""
echo "The MCP will be available in this folder: $(pwd)"
echo ""