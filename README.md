# 🧹 Nashville Housing Data Cleaning Project (SQL)

This project demonstrates how I used **SQL** to clean and prepare a real-world housing dataset for analysis. The dataset contains property sales data from **Nashville, Tennessee**, and includes issues like inconsistent formatting, null values, and duplicate records.

This is one of my earliest hands-on data cleaning projects using SQL — and a solid step on my learning journey.

---

## 📁 Dataset Description

The dataset includes:
- Property and owner information
- Sale dates and prices
- Locations (addresses, cities, states)
- Indicators such as whether the property was sold as vacant

---

## 🧼 Cleaning Tasks Completed

Here’s what I cleaned and transformed in the SQL script:

1. **Converted `SaleDate`** to proper `DATE` format
2. **Filled missing `PropertyAddress` values** using a self-join on `ParcelID`
3. **Split `PropertyAddress`** into:
   - `PropertySplitAddress` (street)
   - `PropertySplitCity`
4. **Split `OwnerAddress`** into:
   - `OwnerSplitAddress`
   - `OwnerSplitCity`
   - `OwnerSplitState`
5. **Standardized the `SoldAsVacant` field**
   - Replaced 'Y' and 'N' with 'Yes' and 'No'
6. **Removed duplicate records** using a `ROW_NUMBER()` CTE method
7. **Dropped unused columns** to streamline the dataset

You can view the full cleaning process in the [SQL script](./Nashville%20Data%20Cleaning%20Project.sql).

---

## 🛠 Tools Used

- SQL Server Management Studio (SSMS)
- SQL queries (`SUBSTRING`, `CHARINDEX`, `PARSENAME`, `ROW_NUMBER`, `JOIN`, `CASE`, etc.)

---

## 📊 Future Steps (Optional)
- Export the cleaned data to a CSV
- Perform Exploratory Data Analysis (EDA) in Excel, Tableau, or Python
- Create data visualizations to show trends in pricing, sales volume, etc.

---

## 📌 Status
✅ Project Complete — cleaning phase done and documented.

---

## 📚 Learning Reflection
This was a great project for:
- Practicing real-life SQL cleaning techniques
- Understanding data inconsistencies
- Building confidence in step-by-step transformation

