# 🚂 Indian Railways Train Delay Analysis

## 📌 Project Overview
This project analyzes punctuality and delay patterns of Indian Railways trains using real-world data scraped from etrain.info. The dataset covers 90 trains, 1,829 station-level records, and tracks delay accumulation along routes.

## 🛠️ Tools Used
- **Excel** — Data cleaning, pivot tables, charts
- **MySQL** — SQL queries for analytical insights
- **Python** — Pandas, Matplotlib, Seaborn for visualization
- **Power BI** — Interactive dashboard
- **AI Chatbot** — Natural language querying of the data

## 📊 Key Findings
- Howrah Duronto (12261) has the highest average delay of **370 minutes**
- Howrah Duronto arrives at final destination **586 minutes** late on average
- **Rajamundry, Balugan, Brahmapur** are the most consistently delayed stations
- Premium trains (Shatabdi, Vande Bharat) average **~10 min** delay vs **38 min** for regular express trains
- Tamil Nadu Express shows clear delay buildup from Chennai (0 min) to New Delhi (54 min)

## 📁 Project Files
| File | Description |
|------|-------------|
| `Entrain_delays_final.xlsx` | Cleaned dataset with stop_order column |
| `Railway_queries.sql` | 7 SQL analytical queries |
| `Railwayproject.ipynb` | Python analysis and visualizations |
| `Train_delay_dashboard.jpeg` | Power BI dashboard screenshot |

## 📈 Dashboard Preview
![Dashboard](Train_delay_dashboard.jpeg)

## 🔍 SQL Queries Covered
1. Most delayed trains
2. Most delayed stations
3. Delay buildup along a route
4. Most punctual trains
5. Worst delay at final destination
6. Systemically problematic stations
7. Premium vs regular train comparison

## 👩‍💻 Author
Vaishnavi | Data Analytics Fresher | REVA University Bengaluru
