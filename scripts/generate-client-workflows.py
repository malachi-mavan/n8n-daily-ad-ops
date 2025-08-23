#!/usr/bin/env python3
"""
Generate Meta Ads Diagnostics workflows for all clients
"""

import json
import os
from pathlib import Path

# Load client configurations
with open('/Users/malachirose/Projects/n8n-builder/config/client-configurations.json', 'r') as f:
    config = json.load(f)

# Load template workflow
with open('/Users/malachirose/Projects/n8n-builder/workflows/meta-ads-diagnostics/v9/meta-ads-diagnostics-v9.json', 'r') as f:
    template_main = json.load(f)

# Load template error handler
with open('/Users/malachirose/Projects/n8n-builder/workflows/meta-ads-diagnostics/v9/meta-ads-error-handler-v9.json', 'r') as f:
    template_error = json.load(f)

def generate_main_workflow(client_config):
    """Generate main workflow for a client"""
    workflow = json.loads(json.dumps(template_main))  # Deep copy
    
    # Update workflow name
    workflow['name'] = f"{client_config['client_name']} - Meta Ads Diagnostics v9"
    
    # Find and update client configuration
    for node in workflow['nodes']:
        if node['name'] == 'v9 Client Configuration':
            # Update client config
            client_assignment = node['parameters']['assignments']['assignments'][0]
            client_assignment['value'].update({
                'CLIENT_NAME': client_config['client_name'],
                'ACCOUNT_ID': client_config['account_id'],
                'GOMARBLE_CREDENTIAL': "Bearer Auth account",
                'SLACK_CHANNEL': client_config['slack_channel'],
                'ERROR_SLACK_CHANNEL': client_config['slack_channel'],
                'PRIORITY_EVENTS': client_config['priority_events']
            })
            
            # Update thresholds
            thresholds_assignment = node['parameters']['assignments']['assignments'][1]
            thresholds_assignment['value'].update(client_config['thresholds'])
            
            # Update prompt template with new CAC threshold
            prompt_assignment = node['parameters']['assignments']['assignments'][2]
            prompt_content = prompt_assignment['value']
            # Update the CAC threshold reference in the creative alerts section
            old_cac_ref = "🟡 High CAC (>$150): X creatives averaging $XXX CAC"
            new_cac_ref = f"🟡 High CAC (>{client_config['thresholds']['CAC_TARGET']}): X creatives averaging $XXX CAC"
            prompt_content = prompt_content.replace(old_cac_ref, new_cac_ref)
            
            # Update ROAS thresholds in prompt
            old_roas_threshold = "- ROAS: >1.0 = 🟢, 0.8-1.0 = 🟡, <0.8 = 🔴"
            new_roas_threshold = f"- ROAS: {client_config['thresholds']['ROAS_GOOD']} = 🟢, {client_config['thresholds']['ROAS_OK']} = 🟡, <0.8 = 🔴"
            prompt_content = prompt_content.replace(old_roas_threshold, new_roas_threshold)
            
            prompt_assignment['value'] = prompt_content
        
        # Update Slack channel IDs
        elif node['type'] == 'n8n-nodes-base.slack':
            node['parameters']['channelId']['value'] = client_config['slack_channel_id']
            node['parameters']['channelId']['cachedResultName'] = client_config['slack_channel']
        
        # Update GoMarble credential reference
        elif node['type'] == '@n8n/n8n-nodes-langchain.mcpClientTool':
            node['credentials']['httpBearerAuth']['name'] = "Bearer Auth account"
    
    return workflow

def generate_error_workflow(client_config):
    """Generate error handler workflow for a client"""
    workflow = json.loads(json.dumps(template_error))  # Deep copy
    
    # Update workflow name
    workflow['name'] = f"{client_config['client_name']} - Meta Ads Diagnostics Error Handler v9"
    
    # Update error configuration
    for node in workflow['nodes']:
        if node['name'] == 'Extract Error Details':
            error_config = node['parameters']['assignments']['assignments'][0]['value']
            error_config.update({
                'CLIENT_NAME': client_config['client_name'],
                'MAIN_WORKFLOW_NAME': f"{client_config['client_name']} - Meta Ads Diagnostics v9",
                'MAIN_WORKFLOW_ID': 'TBD',  # Will be updated after main workflow deployment
                'ERROR_SLACK_CHANNEL': client_config['slack_channel'],
                'ERROR_EMAIL': client_config['error_email'],
                'ACCOUNT_ID': client_config['account_id']
            })
        
        # Update Slack channel IDs
        elif node['type'] == 'n8n-nodes-base.slack':
            node['parameters']['channelId']['value'] = client_config['slack_channel_id']
            node['parameters']['channelId']['cachedResultName'] = client_config['slack_channel']
    
    return workflow

# Generate workflows for Meta Ads clients only
meta_clients = [client for client in config['clients'] if client['account_type'] == 'meta']

for client in meta_clients:
    client_name = client['client_name'].lower().replace(' ', '-')
    client_dir = f"/Users/malachirose/Projects/n8n-builder/workflows/meta-ads-diagnostics/clients/{client_name}"
    
    # Ensure directory exists
    Path(client_dir).mkdir(parents=True, exist_ok=True)
    
    # Generate main workflow
    main_workflow = generate_main_workflow(client)
    with open(f"{client_dir}/main-workflow.json", 'w') as f:
        json.dump(main_workflow, f, indent=2)
    
    # Generate error handler workflow
    error_workflow = generate_error_workflow(client)
    with open(f"{client_dir}/error-handler.json", 'w') as f:
        json.dump(error_workflow, f, indent=2)
    
    print(f"✅ Generated workflows for {client['client_name']}")

print(f"\n🎉 Generated workflows for {len(meta_clients)} Meta Ads clients!")
print("\nNext steps:")
print("1. Create GoMarble credentials in n8n for each client")
print("2. Deploy main workflows and record workflow IDs")
print("3. Update error handlers with main workflow IDs")
print("4. Deploy error handlers")
print("5. Activate all workflows")