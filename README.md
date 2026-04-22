# Milano Cortina 2026 Winter Olympics   
## NLP Analysis of Global Media Coverage

**Author:** Michael Strommer  
**Affiliation:** Sports Analytics Group Berkeley (SAGB)  
**Focus:** Data Journalism | NLP | Sports Analytics  

---

## Overview

How do different countries tell the story of the Olympics?

This project analyzes **tens of thousands of global news articles** covering the **Milano Cortina 2026 Winter Olympics** to uncover how media narratives differ across countries—and how those differences shape sentiment.

Using a combination of **big data infrastructure and NLP**, this analysis reveals a clear pattern:

> **Countries that focus more on medal results produce significantly more positive Olympic coverage.**

---

## Motivation

- Do countries frame the Olympics differently?
- What narratives dominate global coverage?
- How does narrative framing influence sentiment (tone)?
- Is negative coverage driven by controversy—or something else?

---

## Key Findings

### Medal framing drives positive tone
- ~**60% of variation in sentiment across countries** is explained by how much coverage focuses on medals  
- Strong statistical relationship (p < 0.05)

### Narratives vary by country
- 🇹🇷 Turkey & 🇲🇾 Malaysia → heavily medal-focused (~40%)  
- 🇺🇸 United States → athlete-driven storytelling  
- 🇮🇹 Italy → balanced mix (competition, politics, infrastructure)

### Controversy does *not* drive negativity
- Controversy framing has **no significant negative effect on tone**  
- Many “controversy” stories reflect competitive dynamics rather than scandals  

---

## Example Visualizations

### URL Slug Classification
![URL Slug Classification](figures/classification_URL_slug_examples_NLP.png)

## Framing by Country
![Framing](figures/publisher_NLP_url_slug_classification_stacked_barchart.png)

### Tone Distribution by Country
![Tone Distribution](figures/publisher_tone_distribution_by_country_colored.png)

### Medal Framing vs Tone
![Medal vs Tone](figures/regression_medal_framing_on_tone.png)

---

## Methodology

### Data Pipeline
- **GDELT** global news database  
- Queried via **Google BigQuery**  
- ~30k+ articles collected (Feb 2026)

### Processing
- Feature engineering using **SQL + Python**  
- Publisher country mapping via domain parsing  
- Sentiment analysis using **GDELT V2Tone**

### NLP Layer
- Zero-shot classification using **DeBERTa (Hugging Face)**  
- Custom narrative categories:
  - Medal results  
  - Athlete profiles  
  - Broadcast/business  
  - Controversy  
  - Politics  
  - Climate  
  - Logistics  

### Modeling & Analysis
- Exploratory Data Analysis (EDA)  
- Regression modeling (**statsmodels**)  
- Visualization (**Matplotlib / Seaborn**)  

---

## Tech Stack

- Python  
- Google BigQuery  
- SQL  
- GDELT dataset  
- Hugging Face Transformers (DeBERTa)  
- NLP (Zero-shot classification)  
- Pandas / NumPy  
- Matplotlib / Seaborn  
- Statsmodels  
