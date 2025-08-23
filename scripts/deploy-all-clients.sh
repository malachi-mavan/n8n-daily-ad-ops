#!/bin/bash

# Deploy Meta Ads Diagnostics workflows for all clients
# Run from: /Users/malachirose/Projects/n8n-builder

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# n8n API configuration
N8N_API_URL="https://mavan.app.n8n.cloud"
N8N_API_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwZWU3NmNmNS01MDY2LTRmNGYtYWRiNC1kNzU0NzZlOGQ4ZWIiLCJpc3MiOiJuOG4iLCJhdWQiOiJwdWJsaWMtYXBpIiwiaWF0IjoxNzU0MDAzNDUxfQ.3BwkukbNmJYpqyE1tRlgcuPbtb4gOH003G487oIoMq8"

# Function to deploy workflow
deploy_workflow() {
    local workflow_file=$1
    local workflow_type=$2
    local client_name=$3
    
    echo -e "${BLUE}Deploying ${workflow_type} for ${client_name}...${NC}"
    
    response=$(curl -s -X POST "${N8N_API_URL}/api/v1/workflows" \
        -H "Content-Type: application/json" \
        -H "X-N8N-API-KEY: ${N8N_API_KEY}" \
        -d @"${workflow_file}")
    
    # Extract workflow ID from response
    workflow_id=$(echo "$response" | python3 -c "import sys, json; print(json.load(sys.stdin).get('id', 'ERROR'))")
    
    if [[ "$workflow_id" == "ERROR" ]]; then
        echo -e "${RED}❌ Failed to deploy ${workflow_type} for ${client_name}${NC}"
        echo "Response: $response"
        return 1
    else
        echo -e "${GREEN}✅ Deployed ${workflow_type} for ${client_name}${NC}"
        echo "   Workflow ID: ${workflow_id}"
        echo "   URL: ${N8N_API_URL}/workflow/${workflow_id}"
        echo "$workflow_id"
        return 0
    fi
}

# Function to update error handler with main workflow ID
update_error_handler() {
    local error_handler_file=$1
    local main_workflow_id=$2
    local client_name=$3
    
    echo -e "${YELLOW}Updating error handler for ${client_name} with main workflow ID...${NC}"
    
    # Update the JSON file with the main workflow ID
    python3 -c "
import json
with open('${error_handler_file}', 'r') as f:
    workflow = json.load(f)

# Find and update the error configuration
for node in workflow['nodes']:
    if node['name'] == 'Extract Error Details':
        node['parameters']['assignments']['assignments'][0]['value']['MAIN_WORKFLOW_ID'] = '${main_workflow_id}'
        break

with open('${error_handler_file}', 'w') as f:
    json.dump(workflow, f, indent=2)
"
    echo -e "${GREEN}✅ Updated error handler configuration${NC}"
}

# Function to deploy client workflows
deploy_client() {
    local client_dir=$1
    local client_name=$2
    
    echo -e "\n${BLUE}🚀 DEPLOYING WORKFLOWS FOR ${client_name}${NC}"
    echo "=================================================="
    
    # Deploy main workflow
    local main_workflow_file="${client_dir}/main-workflow.json"
    local error_handler_file="${client_dir}/error-handler.json"
    
    if [[ ! -f "$main_workflow_file" ]]; then
        echo -e "${RED}❌ Main workflow file not found: ${main_workflow_file}${NC}"
        return 1
    fi
    
    if [[ ! -f "$error_handler_file" ]]; then
        echo -e "${RED}❌ Error handler file not found: ${error_handler_file}${NC}"
        return 1
    fi
    
    # Deploy main workflow
    main_workflow_id=$(deploy_workflow "$main_workflow_file" "Main Workflow" "$client_name")
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    
    # Update error handler with main workflow ID
    update_error_handler "$error_handler_file" "$main_workflow_id" "$client_name"
    
    # Deploy error handler
    error_handler_id=$(deploy_workflow "$error_handler_file" "Error Handler" "$client_name")
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    
    echo -e "${GREEN}✅ Successfully deployed both workflows for ${client_name}${NC}"
    echo "   Main Workflow ID: ${main_workflow_id}"
    echo "   Error Handler ID: ${error_handler_id}"
    
    # Store deployment info
    echo "${client_name}|${main_workflow_id}|${error_handler_id}" >> deployment-log.txt
    
    return 0
}

# Main deployment process
echo -e "${BLUE}🎯 META ADS DIAGNOSTICS DEPLOYMENT${NC}"
echo "===================================="
echo "Deploying workflows for all Meta Ads clients..."
echo

# Initialize deployment log
echo "# Deployment Log - $(date)" > deployment-log.txt
echo "Client|Main_Workflow_ID|Error_Handler_ID" >> deployment-log.txt

# Client directories
clients=("38tera" "velocity-global" "franki" "franki-b2b")
client_names=("38TERA" "Velocity Global" "Franki" "Franki B2B")

total_clients=${#clients[@]}
successful_deployments=0

for i in "${!clients[@]}"; do
    client_dir="workflows/meta-ads-diagnostics/clients/${clients[i]}"
    client_name="${client_names[i]}"
    
    if deploy_client "$client_dir" "$client_name"; then
        ((successful_deployments++))
    else
        echo -e "${RED}❌ Failed to deploy workflows for ${client_name}${NC}"
    fi
    
    # Add delay between deployments to avoid rate limiting
    if [[ $i -lt $((total_clients - 1)) ]]; then
        echo -e "${YELLOW}Waiting 3 seconds before next deployment...${NC}"
        sleep 3
    fi
done

echo
echo "===================================="
echo -e "${BLUE}🎉 DEPLOYMENT SUMMARY${NC}"
echo "===================================="
echo -e "Successfully deployed: ${GREEN}${successful_deployments}/${total_clients}${NC} clients"

if [[ $successful_deployments -eq $total_clients ]]; then
    echo -e "${GREEN}✅ All client workflows deployed successfully!${NC}"
    echo
    echo -e "${YELLOW}📋 NEXT STEPS:${NC}"
    echo "1. Create GoMarble credentials in n8n for each client:"
    for i in "${!client_names[@]}"; do
        echo "   - ${client_names[i]} GoMarble"
    done
    echo
    echo "2. Activate all workflows in n8n dashboard"
    echo "3. Test each workflow manually"
    echo "4. Monitor Slack channels for automated reports"
    echo
    echo -e "${BLUE}📊 Deployment details saved to: deployment-log.txt${NC}"
else
    echo -e "${RED}❌ Some deployments failed. Check the output above for details.${NC}"
    exit 1
fi

echo
echo "🎯 Deployment complete!"