# 🏗 Zillow Real Estate Data Pipeline (End-to-End AWS ETL)

## 📘 Overview
This project builds a production-grade **data engineering pipeline** that ingests property listings from the **Zillow API** (via RapidAPI), processes them in **AWS**, and loads the curated dataset into **Redshift** for analytics and **Power BI visualization**.

---

## 🔧 Architecture Used

| Layer | Tool | Purpose |
|-------|------|----------|
| Ingestion | AWS Lambda + Python | Fetch data from Zillow API and store in S3 |
| Transformation | AWS Glue + PySpark | Clean and convert JSON → Parquet |
| Orchestration | AWS Step Functions | Manage full ETL workflow |
| Warehousing | AWS Redshift | Store analytical data |
| Modeling | dbt | Create dimensions, facts, and KPIs |
| Visualization | Power BI | Build dashboards |
| Monitoring | CloudWatch | Track ETL runs and errors |
| CI/CD | GitHub Actions | Automate Lambda + dbt deployment |

---


## ⚙️ Tech Stack
- Python, SQL  
- AWS (S3, Lambda, Glue, Redshift, Step Functions, CloudWatch, IAM)  
- dbt, Power BI, GitHub Actions  

---

## 🗓 Implementation Plan (7 Days)
**Day 1:** Setup + Documentation **(Done)**  
**Day 2:** API ingestion Lambda  **(Done)**

**Day 3:** Glue transformation  
**Day 4:** Step Functions orchestration  
**Day 5:** Redshift + dbt  
**Day 6:** Power BI dashboard  
**Day 7:** CI/CD + Monitoring  

---

## 📸 Results (To Add Later)
- Screenshots of S3 raw & curated data  
- Step Function run graph  
- Redshift tables  
- Power BI dashboard  

---

## 🧠 Learning Outcomes
- Integrate APIs into AWS data pipelines  
- Build automated ETL + orchestration flows  
- Model data in Redshift with dbt  
- Automate & monitor pipelines professionally