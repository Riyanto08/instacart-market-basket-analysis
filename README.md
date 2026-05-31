🛒 Instacart Market Basket Analysis
Project Overview
Every time a customer opens a grocery app, there's a story hidden in their cart. Which products do they always reach for? What do they buy together without realizing it? And when are they most likely to shop?
This project dives into Instacart's transaction data to uncover those patterns — not just to describe what happened, but to answer a more important question: what should the business do about it?
Using SQL (PostgreSQL) as the primary analysis tool and Power BI for visualization, this project follows the CRISP-DM framework to deliver actionable business insights around cross-sell opportunities, repeat purchase behavior, and promotion timing.

Business Questions

What products are most frequently bought together?
When is the best time to drive purchases?
How can we increase basket size and repeat purchases?


Dataset
Source: Instacart Market Basket Analysis — Kaggle
TableDescriptionordersOrder-level data including user, timing, and order sequenceorder_products_priorAll prior order items with reorder flagorder_products_trainTrain set order itemsproductsProduct names and category mappingaislesAisle-level categorydepartmentsDepartment-level category
Scale: 32M+ rows in the analytical dataset after joining all tables.

Tech Stack

PostgreSQL — Data preparation & analysis
Power BI — Dashboard & visualization
VS Code + Git — Query management & version control


instacart-market-basket-analysis/
│
├── queries/
│   ├── 01_data_understanding.sql
│   ├── 02_data_preparation.sql
│   ├── 03_eda.sql
│   └── 04_basket_analysis.sql
│
└── README.md

Methodology (CRISP-DM)
1. Data Understanding
Explored all 6 tables to understand structure, volume, missing values, duplicates, and relationships between fact and dimension tables. Confirmed referential integrity across joins.
2. Data Preparation
Built a single analytical_dataset by joining all tables — creating an item-level flat table ready for analysis with product, aisle, department, and order context in one place.
3. Exploratory Data Analysis (EDA)
Customer Behavior

Analyzed order frequency by day of week and hour of day
Identified peak shopping windows

Reorder Behavior

Calculated overall, per-product, and per-customer reorder rates
Identified high-loyalty customers and sticky products

Product Insight

Ranked top products by volume
Identified dominant departments and aisles

4. Basket Analysis (Core)
Applied association rule mining concepts using SQL:

Support — how often a product pair appears together
Confidence — how likely product B is bought when product A is bought
Lift — strength of the relationship beyond coincidence


Key Findings
🕑 Peak Shopping: Sunday at 2 PM
Sunday is by far the busiest shopping day, with the peak hour landing at 2 PM. This is when Instacart's platform sees the highest transaction volume — valuable for operational planning and promotion timing.
🔁 58% of All Items Are Reorders
More than half of every item purchased is a product the customer has bought before. This signals a customer base with strong habitual purchasing behavior — a foundation for loyalty and subscription strategies.
🍌 Banana: The King of the Cart
Banana is not only the most purchased product (472K+ appearances) but also carries an 84% reorder rate — meaning customers come back for it repeatedly. It functions as an anchor product that drives return visits.
🥦 Fresh & Organic Products Dominate
The top department is Produce, and the top aisles are Fresh Fruits and Fresh Vegetables. Organic variants (Organic Strawberries, Organic Baby Spinach, Organic Hass Avocado) dominate the reorder leaderboard — showing that health-conscious, fresh shopping is a core behavior of Instacart's user base.
🍋 Large Lemon + Limes: Strongest Product Pair (Lift: 4.10)
Despite not being the most popular products individually, Large Lemon and Limes show a Lift of 4.10 — meaning customers who buy one are over 4x more likely to buy the other compared to chance. This is the strongest product association in the top 10, making it the most compelling bundling opportunity.

Business Recommendations
#InsightRecommendation1Peak orders on Sunday at 2 PMRun promotions (flash sales, free shipping) on weekdays or off-peak hours to spread demand and reduce operational strain258% reorder rateIntroduce a subscription or auto-reorder feature for high-reorder products to lock in repeat revenue3Banana dominates volume & reorderEnsure constant stock availability; use Banana as an anchor in homepage recommendations to drive basket attachment4Organic & fresh products lead all categoriesPrioritize freshness guarantees and organic product availability; build marketing around health-conscious positioning5Large Lemon + Limes Lift = 4.10Launch a "Citrus Pack" bundle with a small discount — high confidence this drives incremental attachment

Dashboard (Power BI)
The Power BI dashboard is structured around business questions, not just charts:

Overview — total orders, users, and item volume
Behavior — peak time heatmap, order frequency distribution
Product Insight — top products, departments, and aisles
Cross-Sell — basket pairs ranked by Support, Confidence, and Lift


Dashboard file coming soon.
