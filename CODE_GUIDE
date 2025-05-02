# 🧾 CODE GUIDE – Retail Sales SQL Project

This guide explains the logic, structure, and transformations made in the SQL scripts of this project. It serves as a reference for understanding the data cleaning and preparation process in detail.

---

## 📁 File: `SQL_Project_2025.sql`

### 🧹 1. Initial Data Exploration

We start by understanding the structure and contents of the raw data:

- 🔍 Preview the dataset (`SELECT * FROM`).
- 📆 Check the `date` column for minimum and maximum values.
- 🔤 Review string-based fields (`beverage_brand`, `region`) for:
  - Typos or inconsistent formats
  - Missing/null values
  - Duplicates or format issues

### 🧪 2. String Columns Validation

- Found issues in `beverage_brand` and `region` with inconsistent naming (e.g., extra spaces, case sensitivity).
- 🧼 The most frequent correct values were chosen as the base format.
- Verified no nulls or duplicates after cleaning.

### 🔢 3. Numeric Columns Validation

For numeric fields like:

- `state_id`, `id`, `retailer_id`, `month`, `price_per_unit`, `units_sold`

We checked for:
- ❌ Null values
- 🔁 Duplicates
- 🧾 Format errors (e.g., decimal separators in `price_per_unit`)
- ⚠️ `units_sold` had 4 null entries to be addressed in the next phase.

---

## 🛠️ File: `SQL_Project_2025_Validation.sql`

### 🧱 1. Table Setup

- 🆕 Created a clean copy of the original table (`sales_validados`).
- Inserted all records from the raw table.

### 🧼 2. Data Cleaning – Strings

- Applied transformations to standardize:
  - 🥤 `beverage_brand` (e.g., trimming spaces, fixing typos)
  - 🌎 `region` names

### 🧮 3. Data Cleaning – Numerics

- Standardized the decimal format in `price_per_unit`.
- Handled null values in `units_sold`:
  - 🤝 Imputed missing values using the average grouped by `brand` and `month`.
  - 🧠 Decided *not* to include `state_id` in grouping due to limited entries per group.

### 📊 4. Final Output

- ✅ Created a cleaned final table by joining and validating processed records.
- 🧾 Executed a summary check (`table_summary`) to confirm:
  - No nulls or duplicates
  - Consistent date range and outlier detection
