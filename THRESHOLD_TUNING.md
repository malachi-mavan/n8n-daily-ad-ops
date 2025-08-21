# Threshold Fine-Tuning Guide

## 🎯 Current Thresholds (Enhanced Workflow)

### Creative Performance Alert Thresholds

#### Frequency Alerts
- **Current**: >3.0 in last 7 days
- **Rationale**: Meta best practices (2024-2025) indicate effectiveness drops at 3.4
- **Status**: Conservative threshold to catch ad fatigue early

#### CPM Spike Alerts  
- **Current**: >25% from account average
- **Rationale**: User feedback - reduced from 40% for earlier detection
- **Status**: Tuned based on account sensitivity preferences

#### CTR Drop Alerts
- **Current**: >30% from 7-day average
- **Rationale**: Significant drop indicating creative fatigue or audience saturation
- **Status**: Standard threshold for performance degradation

#### Spend Change Alerts
- **Current**: >20% day-over-day
- **Rationale**: Maintained from original workflow - proven effective
- **Status**: Established baseline

#### Conversion Rate Alerts
- **Current**: >40% drop with >$100 spend
- **Rationale**: Dual threshold - significant drop + meaningful spend
- **Status**: Prevents false alarms on low-spend tests

### Anomaly Detection Thresholds

#### Statistical Significance
- **Current**: $500+ spend minimum
- **Rationale**: Ensures sufficient data for reliable performance assessment
- **Status**: Conservative to avoid noise from small tests

#### Breakthrough Detection
- **Current**: >50% ROAS improvement
- **Rationale**: Substantial improvement worth scaling/analyzing
- **Status**: High bar for genuine breakthroughs

#### Critical Failure Detection
- **Current**: >50% ROAS decline or 0 conversions
- **Rationale**: Significant problems requiring immediate attention
- **Status**: Emergency-level thresholds

## 📊 Threshold Tuning Process

### Data Collection Method

#### Week 1: Baseline Data
Collect for each alert type:
- **True Positives**: Alerts that led to valuable actions
- **False Positives**: Alerts that were noise/irrelevant
- **False Negatives**: Issues missed by current thresholds
- **True Negatives**: Correctly ignored non-issues

#### Performance Metrics
Track for each threshold:
- **Sensitivity**: True Positives / (True Positives + False Negatives)
- **Specificity**: True Negatives / (True Negatives + False Positives)
- **Precision**: True Positives / (True Positives + False Positives)
- **Action Rate**: Percentage of alerts acted upon

### Account-Specific Optimization

#### 38TERA Account Characteristics
- **Daily Spend**: ~$1,360 average
- **Campaign Mix**: Brand awareness, conversion, retargeting, prospecting
- **Performance Range**: ROAS 0.26x - 2.53x observed
- **Volatility**: Some campaigns show high day-to-day variation

#### Initial Observations (From Example Data)
- **High-performing campaigns**: ROAS >1.2x
- **Problem campaigns**: ROAS <0.8x  
- **Typical frequency**: Some creatives at 3.4+ (already in fatigue zone)
- **CPM range**: $26-$28 typical

### Threshold Adjustment Framework

#### Week 1 Adjustments (Conservative)
Only adjust if >40% false positive rate or missing obvious issues

#### Week 2-4 Adjustments (Calibrated)
Fine-tune based on performance data and team feedback

#### Month 2+ Adjustments (Optimized)
Account-specific optimization based on historical patterns

## 🔧 Specific Tuning Scenarios

### Scenario 1: Frequency Alerts Too Sensitive

**Symptoms**:
- Multiple frequency alerts daily
- Team says alerts are for ads still performing well
- High false positive rate

**Adjustments**:
- **Conservative**: Increase to 3.5
- **Moderate**: Increase to 4.0  
- **Aggressive**: Change to "Frequency >3.0 AND CTR declining"

**Implementation**:
```
# In enhanced prompt, change:
Frequency >3.0 in last 7 days
# To:
Frequency >3.5 in last 7 days
```

### Scenario 2: CPM Alerts Missing Market Changes

**Symptoms**:
- CPM increases across all campaigns but no alerts
- Missing seasonal or competitive pressure
- Team manually identifies CPM issues

**Adjustments**:
- **Conservative**: Decrease to 20%
- **Moderate**: Decrease to 15%
- **Context-aware**: Add "unusual for day-of-week" logic

**Implementation**:
```
# In enhanced prompt, change:
CPM spike >25% from account avg
# To:
CPM spike >20% from account avg
```

### Scenario 3: Anomaly Detection Too Restrictive

**Symptoms**:
- $500 threshold excludes important small campaigns
- Missing significant improvements in testing campaigns
- Team identifies breakthroughs not flagged

**Adjustments**:
- **Conservative**: Decrease to $300
- **Moderate**: Decrease to $200
- **Segmented**: Different thresholds by campaign type

**Implementation**:
```
# In enhanced prompt, change:
(min $500 spend for significance)
# To:
(min $300 spend for significance)
```

### Scenario 4: CTR Alerts Too Insensitive

**Symptoms**:
- Creative fatigue identified manually before alerts
- 30% threshold misses gradual declines
- Team wants earlier warning

**Adjustments**:
- **Conservative**: Decrease to 25%
- **Moderate**: Decrease to 20%
- **Trend-based**: "CTR declining 3 days in a row"

**Implementation**:
```
# In enhanced prompt, change:
CTR drop >30% from 7-day average
# To:
CTR drop >25% from 7-day average
```

## 📈 Advanced Tuning Considerations

### Account-Specific Patterns

#### Seasonal Adjustments
- **Q4 Holiday**: Increase CPM thresholds (higher competition)
- **Summer Slow**: Decrease conversion thresholds (lower baseline)
- **Back-to-School**: Adjust frequency for audience changes

#### Campaign Type Adjustments
- **Brand campaigns**: Higher frequency tolerance
- **Conversion campaigns**: Lower ROAS tolerance
- **Retargeting**: Higher frequency, lower spend thresholds
- **Prospecting**: Higher CPM tolerance

#### Industry Benchmarks
- **Meta Ads average CTR**: 0.9% (vs 0.64% observed)
- **Meta Ads average CPM**: $14.40 (vs $26+ observed)
- **E-commerce ROAS**: 4:1 typical (vs mixed performance observed)

### Dynamic Threshold Concepts

#### Time-Based Adjustments
- **Monday**: Looser thresholds (weekend effect)
- **Friday**: Tighter thresholds (prepare for weekend)
- **Month-end**: Budget-aware thresholds

#### Performance-Based Adjustments
- **High-performing periods**: Tighter thresholds to maintain quality
- **Testing periods**: Looser thresholds to allow experimentation
- **Crisis periods**: Emergency thresholds for damage control

## 🎛️ Implementation Priority

### Phase 1: Critical Fixes (Days 1-7)
1. **False positive reduction**: Adjust thresholds causing alert fatigue
2. **Missing critical issues**: Lower thresholds for obvious problems
3. **Data validation**: Fix any "Data unavailable" issues

### Phase 2: Optimization (Days 8-30)
1. **Account calibration**: Tune to 38TERA specific patterns
2. **Alert relevance**: Maximize actionable alerts
3. **Team workflow**: Optimize for daily decision-making

### Phase 3: Advanced Features (Days 31+)
1. **Predictive thresholds**: Based on historical patterns
2. **Context awareness**: Day-of-week, seasonal adjustments
3. **Custom metrics**: Account-specific KPIs

## 📋 Tuning Documentation Template

### Change Log Format
```
Date: 2025-08-XX
Threshold: [Frequency/CPM/CTR/Anomaly]
Change: [Old Value] → [New Value]
Reason: [Performance data/Team feedback/Account pattern]
Expected Impact: [Reduce false positives/Catch more issues/etc.]
Review Date: [1 week later]
```

### Performance Tracking
- **Before/After**: Alert counts and relevance
- **Team Feedback**: Satisfaction with alert quality
- **Business Impact**: Time savings and optimization improvements

---

**Next Action**: Begin monitoring with current thresholds and document all alerts for first week analysis.