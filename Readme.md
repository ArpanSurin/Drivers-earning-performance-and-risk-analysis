# 🚖 Marketplace Analytics & Driver Churn Risk Analysis

## 📊 Project Overview

This project analyzes over 3 million trip, rider, driver, and earnings records to uncover key marketplace insights across demand, driver performance, and revenue risk.

The goal was to move beyond surface-level metrics and answer strategic business questions such as:

- Which cities are operationally healthiest?
- Do higher-rated drivers actually earn more?
- How much revenue is at risk due to potential driver churn?

## 🧠 Key Insights

### 1️⃣ Top 3 Healthiest Cities (Last 30 Days)

Based on:
- High trip demand
- Low cancellation rate
- Strong revenue per trip

The top performing cities were:
- Chennai
- Hyderabad
- Mumbai

These cities demonstrated strong marketplace balance — healthy demand, operational efficiency, and consistent revenue generation.

![table view]()

### 2️⃣ Do Higher Rated Drivers Earn More? (Last 60 Days)

A common assumption in marketplaces is:

***Higher rated drivers earn more.***

After segmenting drivers into rating tiers and analyzing earnings and cancellation behavior:

- Earnings did not increase consistently with rating.
- Tier 3 drivers (avg rating ~4.29) had the highest average earnings.
- Cancellation rates were nearly identical across tiers (~8–9%).

**🔎 Conclusion:**

Rating alone is not a strong predictor of earnings.
Other factors such as trip frequency, location, and availability likely play a larger role.

![table view]()

### 3️⃣ High-Earning Drivers & Revenue at Risk

Using window functions and decile segmentation (NTILE(10)), drivers were ranked by total earnings.

Key findings:
- Identified the **top 10% highest-earning drivers.**
- Labeled drivers as “at risk” if they were historically active but had no trips in the last 30 days
- Measured both driver churn concentration and revenue exposure

![table view]()

### 🚨 Results:

- **53% of top 10% drivers are at risk.**

- **Revenue at risk: 32,778,028.37**

This indicates churn risk is concentrated among revenue-driving drivers — posing significant business exposure.

### 📉 Business Impact
If high-earning drivers churn:
- Marketplace liquidity declines
- Rider wait times increase
- Competitors gain supply advantage
- Revenue impact becomes disproportionate

Retention strategies should prioritize high-value drivers rather than treating all churn equally.