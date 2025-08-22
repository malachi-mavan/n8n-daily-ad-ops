# Meta Ads Diagnostics - Version History

## v8 - Production Ready (2025-08-22)

**Status**: ✅ Current Production Version  
**n8n Workflow ID**: `gY7MTV11ZqRLtywG`  
**Direct URL**: `https://mavan.app.n8n.cloud/workflow/gY7MTV11ZqRLtywG`

### Fixed Critical Issues:
- ✅ **Report Title**: Full header with account ID and date
- ✅ **DoD% Calculation**: Added day before yesterday data retrieval
- ✅ **Fair Comparisons**: L7D vs P7D (two full 7-day periods)

### Key Features:
- Real campaign names from GoMarble MCP
- Backtick title formatting for orange Slack display
- Condensed creative alerts with top 3 priority actions
- Perfect table alignment and formatting
- Secure credential handling (no tokens in prompts)

### Technical Specs:
- **Schedule**: `0 9 * * 1,5` (Monday/Friday 9AM PST)
- **Data Periods**: Yesterday, day before yesterday, L7D, P7D
- **Output**: <60 lines for Slack compatibility
- **Model**: Claude Sonnet 4 (claude-sonnet-4-20250514)

---

## v7 - Enhanced Production (2025-08-21)

**Status**: ⚠️ Had 3 critical issues (resolved in v8)  
**n8n Workflow ID**: `2huY1h4BJqlkeBgZ`

### Major Features Added:
- Client configuration section for easy duplication
- Backtick title formatting: `` `META ADS DIAGNOSTICS REPORT` ``
- Real campaign names (fixed placeholder issue)
- Condensed creative performance summary
- Enhanced security with credential references

### Issues Identified:
- ❌ Report title getting truncated
- ❌ DoD% not calculating (missing prior day data)
- ❌ Unfair week comparisons (partial vs full periods)

---

## v6 - Format Optimized (2025-08-20)

**Status**: 📋 Development Complete

### Improvements:
- Fixed preamble issues (eliminated "Based on data retrieved")
- Condensed creative section to summary + top 3 actions
- Perfect table alignment with consistent column widths
- Under 60 lines total for Slack message limits

---

## v5 - Feature Complete (2025-08-20)

**Status**: 📋 Development Complete

### New Features:
- DoD% (Day-over-Day percentage) calculations
- Split campaign tables: 2A (Performance) and 2B (Efficiency)
- Enhanced creative alerts with multi-factor detection
- Key Changes section for insights

---

## v4 - User Feedback Integration (2025-08-20)

**Status**: 📋 Development Complete

### Addressed User Feedback:
- Green/yellow/red status emojis maintained
- Yesterday column preserved in core metrics
- Schedule adjusted to Monday/Friday 9AM PST
- Formatting improvements for Slack display
- 13 specific user feedback points implemented

---

## v3 Enhanced - Foundation (2025-08-19)

**Status**: 📋 Development Complete  
**n8n Workflow ID**: `rbdHVLUPnJogC8je`

### Major Enhancements:
- Real campaign names (fixed placeholder issue from original v3)
- Multi-factor creative alerts (frequency, CPM, CTR)
- Statistical anomaly detection ($500+ spend threshold)
- Better data validation and timezone handling

---

## Original v3 - Baseline (2025-08-18)

**Status**: 📋 Legacy Baseline

### Issues Fixed in Enhanced Version:
- ❌ Placeholder campaign names ([Campaign A], [Campaign B])
- ❌ Limited creative alerts (single-factor)
- ❌ No statistical significance thresholds
- ❌ Basic data validation

### Original Features:
- Basic daily diagnostics report
- Meta Ads account integration via GoMarble MCP
- Slack delivery to internal_38tera_reports
- Schedule trigger for automated reports

---

## Version Comparison Matrix

| Feature | v3 Original | v3 Enhanced | v4 | v5 | v6 | v7 | v8 |
|---------|-------------|-------------|----|----|----|----|----| 
| Real Campaign Names | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Creative Alerts | Basic | Multi-factor | Multi-factor | Multi-factor | Condensed | Condensed | Condensed |
| DoD% Calculation | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ |
| Split Campaign Tables | ❌ | ❌ | ❌ | ✅ | ✅ | ✅ | ✅ |
| Table Alignment | Basic | Basic | Improved | Improved | Perfect | Perfect | Perfect |
| Backtick Title | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ |
| Full Header | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Fair Week Comparison | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Client Duplication | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ | ✅ |

---

## Deployment History

### Production Deployments:
- **v8**: `gY7MTV11ZqRLtywG` - Current active workflow
- **v7**: `2huY1h4BJqlkeBgZ` - Available for fallback
- **v3 Enhanced**: `rbdHVLUPnJogC8je` - Original enhanced baseline

### API Upload Success Rate:
- All v4-v8 workflows successfully uploaded via direct n8n API
- MCP tools not available in Claude Code environment
- Workaround: `curl` with n8n API key authentication

---

## Breaking Changes

### v7 → v8:
- **Data Retrieval**: Added day before yesterday requirement
- **Period Labels**: "Current Week/Last Week" → "L7D/P7D"
- **Header Format**: Enhanced with full account details

### v6 → v7:
- **Credentials**: Moved from inline tokens to credential references
- **Client Config**: Added configuration section to prompt
- **Security**: Enhanced token handling

### v5 → v6:
- **Creative Section**: Verbose → Condensed summary format
- **Line Limit**: Strict <60 lines for Slack compatibility

### v4 → v5:
- **Campaign Tables**: Single → Split (Performance/Efficiency)
- **DoD Calculations**: Added yesterday vs day before comparison

---

## Upgrade Path

### From v7 to v8:
1. Import v8 workflow JSON
2. Update credentials (same as v7)
3. Test report output
4. Deactivate v7, activate v8

### From v3 Enhanced to v8:
1. Export v3 Enhanced credentials
2. Import v8 workflow JSON
3. Configure new credential references
4. Update Slack channel if needed
5. Test and activate

---

## Future Roadmap

### v9 Planned Features:
- Error handling workflow integration
- Multi-client batch deployment
- Advanced anomaly detection
- Cross-platform reporting

### Platform Expansion:
- Google Ads Diagnostics (based on v8)
- TikTok Ads Diagnostics
- Unified multi-platform reports