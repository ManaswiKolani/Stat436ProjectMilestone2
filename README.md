# 🌿 ESGProject

**Shiny App**: [ESG Investment Visualization](https://ekass.shinyapps.io/ESGApp/)  
**Code**: [GitHub - ESGApp.R](https://github.com/ManaswiKolani/Stat436ProjectMilestone2/blob/main/ESGApp.R)  
**Paper**: [`STAT436 Milestone 3`](https://github.com/ManaswiKolani/Stat436ProjectMilestone2/blob/main/STAT436%20Milestone%203%20(1).pdf)

## 📌 Overview

**ESG** stands for *Environmental, Social, and Governance*, and refers to the three central factors used to measure the sustainability and ethical impact of an investment in a company. This project centers on building a web-based visual interface for hypothetical ESG investors, especially those interested in **clean energy companies**. Our goal is to empower a diverse range of users to make informed investment decisions that align financial success with environmental and social responsibility.

## 🎯 Project Goal

Create an intuitive, customizable Shiny app to:
- Enable investors to explore and compare ESG scores across companies and industries.
- Support both novice and experienced investors through clear, interactive visual tools.
- Identify patterns, trends, and outliers in ESG performance data.

## 📊 Visualizations & Features

The dashboard is organized into four modular tabs, each focused on different aspects of ESG insights:

### 1. **Radar Chart Comparison**
- Compare two companies' ESG scores across three dimensions.
- Highlights score differences through contrasting triangle overlays.
- Zoom and interact for clarity and detail.

### 2. **Boxplots by Industry**
- Visualize ESG score distributions across selected industries.
- Select specific sectors and ESG categories (Environmental, Social, Governance, or total).
- Hover and zoom to explore company-level details.

### 3. **Industry Overview**
- Combines bar charts, heatmaps, and a comparison table.
- Color-coded letter grades (A, BBB, BB, B) highlight performance.
- Summary statistics and filters for detailed sector analysis.

### 4. **ESG Performance Insights (Dashboard Section)**
- Filter by ESG sectors and grade levels:
  - **High**: AAA, AA, A
  - **Medium**: BBB, BB, B
  - **Low**: CCC, C
- Adjust bin width to control score distribution granularity.
- Search bar to highlight specific companies directly in the graph.

## 📂 Datasets Used

1. [**Public Company ESG Ratings**](https://www.kaggle.com/datasets/alistairking/public-company-esg-ratings-dataset):  
   Contains ESG letter grades and numeric scores (0–1000) for public companies.

2. [**Corporate Environmental Impact**](https://www.kaggle.com/datasets/mannmann2/corporate-environmental-impact):  
   Includes monetary-based sustainability metrics and multiple "safeguard subject" ratings per firm, requiring unnesting for tidy use.

---

This project was developed in **STAT 436 - Milestone 3**, Group 10.  
Authors: Manaswi Kolani, Emili Robles, Jason Clark, Maya Blumenthal, Carson Stone, Neve Peterson
📅 December 2024
