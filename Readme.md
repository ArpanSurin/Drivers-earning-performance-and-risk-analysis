# 🚖 Driver Earning Performance & risk Analysis

![Driver analytics Dashboard](https://github.com/ArpanSurin/Drivers-earning-performance-and-risk-analysis/blob/main/Driver_analytics_dashboard.png)

## 📊 Project Overview

This project analyzes over 3 million trip, rider, driver, and earnings records to uncover key marketplace insights across demand, driver performance, and revenue risk.

The goal was to move beyond surface-level metrics and answer strategic business questions such as:

- Which cities are operationally healthiest?
- Do higher-rated drivers actually earn more?
- How much revenue is at risk due to potential driver churn?

## Dataset
The synthetic dataset was generated using `notebooks/generate_dataset.ipynb`.
To regenerate it, run all cells in the notebook.

Total size: ~500MB (excluded from repo due to file size limits)

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

![table view](https://github.com/ArpanSurin/Drivers-earning-performance-and-risk-analysis/blob/main/result_tables/city-level-view.png)

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

![table view](https://github.com/ArpanSurin/Drivers-earning-performance-and-risk-analysis/blob/main/result_tables/driver-quality-earning-view.png)

### 3️⃣ High-Earning Drivers & Revenue at Risk

Using window functions and decile segmentation (NTILE(10)), drivers were ranked by total earnings.

Key findings:
- Identified the **top 10% highest-earning drivers.**
- Labeled drivers as “at risk” if they were historically active but had no trips in the last 30 days
- Measured both driver churn concentration and revenue exposure

![table view](https://github.com/ArpanSurin/Drivers-earning-performance-and-risk-analysis/blob/main/result_tables/driver-churn-risk.png)

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

## 💡Future improvements
1. Implementing a backend service and deploying that backend for a server to run on.
2. Live database hosted on a cloud platform into which the data can be pushed to.
3. Deploying the entire project on Docker, encapsulating the whole project and ensuring that it runs on any system without crashing.

