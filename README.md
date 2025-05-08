# ☕ Cafe Sales Data Cleaning & Analysis

This project showcases a complete data workflow on a real-world-style transactional dataset from a cafe. It includes data cleaning using SQL, exploratory data analysis (EDA) in SQL and Python, and visualizations using Seaborn.

## 📂 Files Included

- `cafe_sales_dataset_cleaned.sql` – SQL script for cleaning the raw sales dataset.
- `cafe_sales_dataset_data_analysis.sql` – SQL script with EDA queries.
- `main.ipynb` – Jupyter Notebook for Python-based visualizations using Pandas and Seaborn.

## 🛠 Tools & Tech

- MySQL
- Python (Pandas, Matplotlib, Seaborn)
- Jupyter Notebook

## 🧹 Data Cleaning Highlights

- Replaced placeholder values like `UNKNOWN`, `ERROR`, or empty strings.
- Standardized item names based on price patterns.
- Parsed and validated dates (`trans_date`).
- Removed or corrected invalid entries.
- Casted numeric fields like `total_spent` for proper analysis.

## 📊 Key EDA Insights

- Most ordered and most profitable items
- Monthly revenue trends
- Average spending by payment method
- Location-based transaction volume
- Quantity distribution and order behavior

## 📈 Sample Visualizations

- Total revenue per item (barplot)
- Monthly sales trend (lineplot)
- Payment method comparison (boxplot & average bars)
- Quantity vs. spending (scatterplot)

## ▶️ How to Run

1. Open `main.ipynb` to explore Python-based insights and plots.
2. Use a MySQL environment to run the `.sql` files for cleaning and SQL-based EDA.

## 📎 Dataset Source

The original dataset was sourced from [Kaggle.com](https://www.kaggle.com/).

## 👤 Author

**Matan Nafshi**  
Feel free to contact me!
💼 [LinkedIn Profile](https://www.linkedin.com/in/matan-nafshi)  
📧 matannaf@gmail.com  

A project for mastering data cleaning, analysis, and visualization.

---

⭐ Feel free to star this repository if you find it helpful or inspiring!
