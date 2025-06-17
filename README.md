# 🛍️ Fashion Retail Intelligence: MySQL-Powered Business Insights
This project explores a simulated fashion retail sales data using MySQL o generate actionable business insights. Through structured queries, we uncover key patterns in store performance, product trends, customer demographics, and promotional effectiveness. <br/>
The objective is to demonstrate advanced SQL skills and deliver insights that help inform strategic business decisions in the retail sector.

---

## 🎯 Project Goals
- Identify top-performing **stores, products and employees**
- Understand sales trends by **region, time, and product**
- Measure **marketing and discount** effectiveness
- Uncover actionable patterns in **customer behavior**
- Support strategic decisions in **operations, HR, and sales**

---

## 🛠️ Tools and Technologies
- **Database Language**: MySQL (Window Functions, CTEs, Aggregations, JOIN, Date Manipulation)
- **Data Source**: Simulated transactional retail data
- **Data Schema**: 6 normalized tables (Transactions, Customers, Products, Stores, Employees, Discounts)
- **Deliverables**: SQL query notebook, business insights, entity-relationship diagram, data visualization with Power BI

---

## 🗂️ Entity Relationship Diagram (ERD)
A visual representation of the retail database schema is provided below: <br/>
![ERD_fashionsales](https://github.com/user-attachments/assets/2f472577-3b47-4f01-8666-01eae140b635)


---

## 📌 Key Business Questions & Insights

### 🔍 Q1: Which stores generate the highest revenue and productivity?
**Insight**: Top-performing stores are located in high-footfall cities. <br/>
**Metric**: Total sales, average order value, and sales-per-employee. <br/>
**Action**: Use for strategic expansion and benchmarking. <br/>

<img src="https://github.com/user-attachments/assets/bdba72ba-6556-4afa-a3c8-1d537e372b67" width="600">

---

### ⏰ Q2: What are the peak sales hours and days?
**Insight**: Peak sales occur between **16:00–20:00**, especially on **weekends**. <br/>
**Action**: Optimize staff scheduling and plan flash promotions. <br/>

<img src="https://github.com/user-attachments/assets/598b2268-5f2a-4671-9e5a-e55cadab0b02" width="250"> <br/>

<img src="https://github.com/user-attachments/assets/f0e6bbe1-23dd-4925-8fc3-aab1f15bfb40" width="250">

---

### 💳 Q3: What are the most common payment methods?
**Insight**: **Credit Cards** dominate across all locations. <br/>
**Action**: Prioritize seamless digital payment experiences. <br/>

<img src="https://github.com/user-attachments/assets/715c920b-5f1c-4d7e-9154-31f6741b469a" width="400">

---

### 🔁 Q4: Which stores have the highest return rates?
**Insight**: **Store 1** reports the most returns — possible product quality or customer fit issue. <br/>
**Action**: Investigate product mix, store policies, or customer satisfaction. <br/>

<img src="https://github.com/user-attachments/assets/6e9729e0-aec4-4e2c-b681-247ff95a16a2" width="400">

---

### 🧑‍💼 Q5: Does store manager experience affect sales?
**Insight**: Experienced managers correlate with higher store revenue. <br/>
**Action**: Supports training programs and promotion decisions. <br/>

<img src="https://github.com/user-attachments/assets/739eec15-a1f3-4550-980a-c4b5c16573b7" width="400">

---

### 🧑‍🤝‍🧑 Q6: Which employees have the highest sales efficiency?
**Insight**: **David Pitts** and **Carl Walters** are consistent top performers. <br/>
**Action**: Use for incentives, mentoring, or team leadership. <br/>

<img src="https://github.com/user-attachments/assets/4163ff00-feaf-4616-9d73-5815bfcd6c8c" width="650">

---

### 🧾 Q7: Does team size influence discounting behavior?
**Insight**: Larger teams may offer more discounts. <br/>
**Action**: Monitor profitability vs. conversion strategies. <br/>

<img src="https://github.com/user-attachments/assets/c125042b-dc4e-4fa0-a6aa-6d63febfbfdb" width="600">

---

### 👥 Q8: How do customer demographics affect product category sales?
**Insight**: <br/>
  **Sportswear**: Popular with younger males in urban areas. <br/>
  **Formalwear**: Appeals to older females. <br/>
**Action**: Tailor marketing and product recommendations. <br/>

<img src="https://github.com/user-attachments/assets/3a7e6251-6335-4cdd-9f47-13a8f010c8d6" width="800">

---

### 📦 Q9: Which product categories generate the most revenue?
**Insight**: Top categories significantly outperform others in sales. <br/>
**Action**: Prioritize high-performing inventory and promotions. <br/>

<img src="https://github.com/user-attachments/assets/d7d01dd7-508d-48e6-b0ea-baa4ea71a7e7" width="250">

---

### 🧵 Q10: Which product subcategories have niche potential?
**Insight**: Certain subcategories consistently generate high profit. <br/>
**Action**: Identify cross-sell or bundling opportunities. <br/>

<img src="https://github.com/user-attachments/assets/ec5f01ce-6226-4324-8afe-29697b5a04da" width="300">

---

### 📏 Q11: What are the most sold product sizes?
**Insight**: Size distribution varies by category and demographic. <br/>
**Action**: Improves demand forecasting and supply chain efficiency. <br/>

<img src="https://github.com/user-attachments/assets/2aaa9be4-1adf-4fe5-ad81-21e01a21dca0" width="150">

---

### 🎨 Q12: What are the most popular product colors?
**Insight**: Identifies customer aesthetic preferences. <br/>
**Action**: Guides seasonal campaigns and design choices. <br/>

<img src="https://github.com/user-attachments/assets/3b59d93f-72df-4721-aa1f-92e1fcc20560" width="180">

---

### 💰 Q13: What is the profit margin per product?
**Insight**: Some products offer significantly higher margins. <br/>
**Action**: Promote high-margin items and optimize pricing. <br/>

<img src="https://github.com/user-attachments/assets/1cc24198-38a1-413c-ac73-c90d8a0f49f0" width="500">

---

### 🚫 Q14: Which products are underperforming or unsold?
**Insight**: Low turnover SKUs signal overstock or low demand. <br/>
**Action**: Use for clearance sales or product repositioning. <br/>

<img src="https://github.com/user-attachments/assets/8d464c70-5aee-4eb3-b62c-5be2bb01e260" width="350"> <br/>

<img src="https://github.com/user-attachments/assets/569a5650-c184-4403-b5f2-2368ebd81003" width="450">

---

### 🏷️ Q15: What is the revenue split between discounted and full-price items?
**Insight**: ~19% of revenue comes from discounted sales. <br/>
**Action**: Analyze reliance on promotions to evaluate pricing strategy. <br/>

<img src="https://github.com/user-attachments/assets/e9a2a35b-056f-4221-8921-45bf873d4754" width="350">

---

### 📅 Q16: How frequent and diverse are marketing campaigns?
**Insight**: Monthly campaign frequency and impact varies. <br/>
**Action**: Helps optimize future marketing calendar and ROI. <br/>

<img src="https://github.com/user-attachments/assets/f9caa06a-4a3a-4356-b4ca-bfaa82c61620" width="800">

---

## 📊 Visualization and Dashboard (Power BI)
### Overview
<img src="https://github.com/user-attachments/assets/94c430b9-0b25-4b65-ac22-64e39ae48be1" width="800">


### Employee & Sales Performance
<img src="https://github.com/user-attachments/assets/3daf49d8-1f5f-4b4b-a30b-ef11d9dfbb55" width="800">


### Product Analysis
<img src="https://github.com/user-attachments/assets/9085bd14-d3b8-40dd-aac3-959207f0c42d" width="800">


### Customer & Campaign
<img src="https://github.com/user-attachments/assets/5d6bc08a-f5de-40db-8a53-43d3031cebac" width="800">

---

## 📁 File Structure
fashion_sales_project/ <br/>
    └── fashion_sales_analysis.sql <br/>
    └── fashion_sales_dashboard.pbix <br/>
    └── README.md <br/>

---

## 🧠 Outcomes & Reflections

+ Applied **advanced SQL techniques**: **CTEs, window functions, aggregations, multi-table joins, date/time functions**
+ Transformed raw data into **strategic business insights**
+ Created **interactive dashboards** to support decision-making across retail departments
+ Improved **data storytelling** and cross-functional communication skills

---

## 📌 Summary

This project demonstrates how data analytics can enhance performance in a competitive retail environment. From high-level strategy to individual store actions, these insights help optimize decisions in operations, marketing, HR, and product planning.







