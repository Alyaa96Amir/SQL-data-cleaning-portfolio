# # Global Layoffs Data Cleaning Project

## 📌 Project Overview

This project focuses on cleaning and preparing a dataset containing information about employee layoffs across various companies and countries.

Due to inconsistencies and missing values, data cleaning is required to ensure accuracy and reliability for analysis.

---

## 🌍 Dataset Description

The dataset captures global layoff trends, including:

* Company
* Industry
* Country / location
* Total number of employees laid off
* Percentage of layoffs
* Date of layoffs
*Fund raised by company

This dataset contains common real-world data issues such as duplicates, inconsistent formatting, and missing values.

---

## 🎯 Objectives

### 1. Identify and Remove Duplicates

* Detect duplicate records using `ROW_NUMBER()`
* Retain only unique and relevant entries
* Ensure data integrity for accurate analysis

---

### 2. Standardize Data

* Clean and normalize text fields:

  * Fix inconsistent company names
  * Standardize country and industry names
  * Remove leading/trailing spaces using `TRIM()`
* Ensure consistent formatting across the dataset

---

### 3. Handle Missing Values

* Identify NULL and blank values
* Populate missing data where possible using:

  * Existing records (e.g., same company)
  * Logical assumptions
* Evaluate whether to keep or remove incomplete data

---

### 4. Format and Transform Data

* Convert date fields into proper date format using `STR_TO_DATE()`
* Ensure numerical fields are correctly structured for analysis

---

### 5. Remove Irrelevant Data

* Drop unnecessary or redundant columns
* Remove invalid or incomplete rows when necessary
* Improve dataset structure for efficiency

---

## 🛠️ Tools & Techniques

* SQL (MySQL)

  * `ROW_NUMBER()`
  * `TRIM()`
  * `STR_TO_DATE()`
  * `UPDATE JOIN`
  * `DELETE`

---

## 📊 Expected Outcome

* A clean and structured dataset
* Improved data consistency and quality
* Ready for exploratory data analysis (EDA) or visualization

---

## 🚀 Future Work

* Perform data analysis to identify layoff trends by:

  * Industry
  * Country
  * Time (year/month)
  * Funds raised by company
* Visualize insights using tools like Python or BI dashboards

---

