# Daily Ad Ops Prompt Analysis

## Current Prompt Structure Analysis

### Strengths ✅
1. **Clear Role Definition**: "Senior Meta Ads performance analyst for 38TERA"
2. **Specific Account Targeting**: Account ID "732630268714732" 
3. **Detailed Formatting Rules**: Comprehensive visual formatting (emojis, arrows, code blocks)
4. **Structured Output Template**: Well-organized sections with clear hierarchy
5. **Performance Thresholds**: Specific ROAS and CAC criteria for status colors
6. **Actionable Output**: Clear action items categorized by priority

### Current Output Sections
1. **Core Performance Metrics**: Yesterday vs WTD vs LW comparison
2. **Top Campaigns by Spend**: Campaign-level performance breakdown  
3. **Creative Performance Alerts**: Day-over-day spend changes >20%
4. **Audience Analysis**: Remarketing vs Prospecting segments
5. **Status Summary**: Overall health assessment
6. **Action Items**: Prioritized recommendations

### Potential Issues & Improvement Areas

#### 🔴 Missing Elements (likely causing incomplete output)

1. **Data Source Instructions**
   - No clear guidance on which MCP tools to use
   - Missing data retrieval methodology
   - No fallback if data is unavailable

2. **Date Range Specifications**
   - "Yesterday" is ambiguous (need timezone context)
   - "Week-to-Date" vs "Same Day Last Week" needs clearer definition
   - No handling for weekends/holidays

3. **Error Handling Instructions**
   - No guidance for missing data scenarios
   - No instructions for API failures
   - No placeholder values when data unavailable

4. **Data Validation**
   - No checks for data freshness
   - No validation of data completeness
   - No quality checks before report generation

#### 🟡 Structure Improvements Needed

5. **Metric Calculations**
   - CAC calculation method not specified
   - ROAS calculation not defined
   - Trend calculation methodology unclear

6. **Campaign Filtering**
   - Top campaigns criteria not specified (by spend? by impressions?)
   - No minimum threshold for inclusion
   - No handling of paused/inactive campaigns

7. **Creative Performance Logic**
   - 20% threshold may need adjustment
   - No context for why creative spend changed
   - Missing creative performance metrics beyond spend

8. **Audience Segmentation**
   - Remarketing vs Prospecting definition not clear
   - May need more granular audience breakdown
   - Missing lookalike audience performance

#### 🟢 Enhancement Opportunities

9. **Additional Metrics**
   - Frequency and reach data
   - Attribution window considerations
   - Quality score / relevance score
   - Landing page performance

10. **Competitive Context**
    - Industry benchmarks
    - Seasonal comparisons
    - Account historical performance context

11. **Predictive Elements**
    - Forecast based on current trends
    - Budget pacing analysis
    - Optimization suggestions

## Recommended Prompt Improvements

### 1. Add Data Retrieval Instructions
```
Before generating the report, use available MCP tools to:
1. Query Meta Ads data for account 732630268714732
2. Retrieve data for yesterday (previous business day)
3. Calculate week-to-date averages (Monday-current day)
4. Get same day last week comparison data
5. Verify data completeness before proceeding
```

### 2. Add Error Handling
```
If data is unavailable or incomplete:
- Clearly mark missing sections with "Data unavailable"
- Provide context for why data might be missing
- Include partial data with appropriate caveats
- Still generate actionable recommendations based on available data
```

### 3. Add Timezone Context
```
Use PST/PDT timezone for "yesterday" calculations.
If today is Monday, use Friday as "yesterday".
Account for Meta Ads reporting delays.
```

### 4. Enhance Metric Definitions
```
Calculations:
- CAC = Total Spend / Total Conversions
- ROAS = Total Conversion Value / Total Spend
- Trends = ((Current - Previous) / Previous) * 100
- Use purchase attribution window for conversion metrics
```

### 5. Add Data Quality Checks
```
Before generating report, verify:
- Data is for the correct date range
- Conversion tracking is active
- No major account changes in the period
- Data freshness (last updated timestamp)
```

## Missing Elements Analysis

Based on the prompt structure, likely missing elements in output could be:

1. **Empty tables** when MCP fails to retrieve data
2. **Placeholder values** (X,XXX) not replaced with actual numbers
3. **Missing creative names** in Creative Performance Alerts section
4. **Incomplete action items** due to lack of specific performance context
5. **Status emojis defaulting** to neutral when thresholds aren't met

## Ready for User Feedback

The prompt analysis is complete. Ready to receive details about:
- Which specific elements were missing in the last output
- What data was incomplete or incorrect
- Which sections need improvement or expansion
- Any formatting or presentation issues observed