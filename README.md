# Lokesh Data Warehouse SQL Project

A complete SQL-based data warehouse project demonstrating database design, schema creation, data loading, ETL processes, data transformation, and analytical reporting.

## 📌 Project Overview

This project builds a data warehouse using SQL. It transforms raw source data into structured, analysis-ready data that can be used for reporting and business insights.

The project covers:

- Database and schema design
- Table creation
- Raw data loading
- Data cleansing and transformation
- ETL pipeline development
- Fact and dimension modeling
- Data quality validation
- Analytical SQL queries

## 🏗️ Data Warehouse Architecture

The project follows a layered architecture:

1. **Bronze Layer**
   Stores raw data exactly as received from source files.

2. **Silver Layer**
   Cleans, standardizes, and transforms the raw data.

3. **Gold Layer**
   Contains business-ready fact and dimension tables for reporting and analysis.
<?xml version="1.0" encoding="UTF-8"?>
<svg width="1400" height="760" viewBox="0 0 1400 760" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <pattern id="bronzeStripes" patternUnits="userSpaceOnUse" width="18" height="18" patternTransform="rotate(45)">
      <rect width="18" height="18" fill="#e7c5c0"/>
      <line x1="0" y1="0" x2="0" y2="18" stroke="#f7dfe0" stroke-width="2"/>
    </pattern>
    <pattern id="silverStripes" patternUnits="userSpaceOnUse" width="20" height="20" patternTransform="rotate(45)">
      <rect width="20" height="20" fill="#1a1f25"/>
      <line x1="0" y1="0" x2="0" y2="20" stroke="#72787d" stroke-width="3"/>
    </pattern>
    <pattern id="goldStripes" patternUnits="userSpaceOnUse" width="16" height="16" patternTransform="rotate(45)">
      <rect width="16" height="16" fill="#f2e488"/>
      <line x1="0" y1="0" x2="0" y2="16" stroke="#f7f0a4" stroke-width="2"/>
    </pattern>
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="6" stdDeviation="6" flood-color="#000000" flood-opacity="0.18"/>
    </filter>
  </defs>

  <rect width="1400" height="760" fill="#050505"/>

  <g font-family="Arial, Helvetica, sans-serif">
    <text x="110" y="150" fill="#ff4d4d" font-size="38" font-weight="700">Sources</text>

    <g transform="translate(140,260)">
      <rect x="0" y="0" width="40" height="28" fill="#f3d54d" rx="4"/>
      <rect x="6" y="8" width="28" height="18" fill="#f7e99a" rx="2"/>
      <path d="M10 8 L20 3 L30 8" stroke="#d7a700" stroke-width="2" fill="none"/>
      <path d="M15 15 L25 15" stroke="#d7a700" stroke-width="2"/>
      <path d="M12 19 L28 19" stroke="#d7a700" stroke-width="2"/>
      <path d="M8 25 L32 25" stroke="#d7a700" stroke-width="2"/>
    </g>

    <g transform="translate(140,472)">
      <rect x="0" y="0" width="40" height="28" fill="#f3d54d" rx="4"/>
      <rect x="6" y="8" width="28" height="18" fill="#f7e99a" rx="2"/>
      <path d="M10 8 L20 3 L30 8" stroke="#d7a700" stroke-width="2" fill="none"/>
      <path d="M15 15 L25 15" stroke="#d7a700" stroke-width="2"/>
      <path d="M12 19 L28 19" stroke="#d7a700" stroke-width="2"/>
      <path d="M8 25 L32 25" stroke="#d7a700" stroke-width="2"/>
    </g>

    <g transform="translate(620,50)" filter="url(#shadow)">
      <rect x="0" y="0" width="320" height="75" fill="#f5f5f5" stroke="#d7d7d7" stroke-width="2"/>
      <text x="160" y="48" text-anchor="middle" fill="#d92525" font-size="27" font-weight="700">Lokesh Data Ware House</text>
    </g>

    <g>
      <g transform="translate(350,170)" filter="url(#shadow)">
        <rect x="0" y="0" width="260" height="440" fill="url(#bronzeStripes)"/>
        <text x="130" y="36" text-anchor="middle" fill="#d93e3e" font-size="22" font-weight="700">Bronze Layer</text>
        <rect x="89" y="80" width="82" height="62" fill="#f3f3f3" stroke="#d0d0d0" stroke-width="2"/>
        <ellipse cx="130" cy="80" rx="41" ry="17" fill="#f3f3f3" stroke="#d0d0d0" stroke-width="2"/>
        <path d="M89 80 H171 V142 H89 Z" fill="#f3f3f3" stroke="#d0d0d0" stroke-width="2"/>
        <path d="M90 142 C115 130, 146 130, 171 142" fill="none" stroke="#d0d0d0" stroke-width="2"/>
      </g>

      <g transform="translate(700,170)" filter="url(#shadow)">
        <rect x="0" y="0" width="260" height="440" fill="url(#silverStripes)"/>
        <text x="130" y="36" text-anchor="middle" fill="#dfe7f5" font-size="22" font-weight="700">Silver Layer</text>
        <rect x="89" y="80" width="82" height="62" fill="#f3f3f3" stroke="#d0d0d0" stroke-width="2"/>
        <ellipse cx="130" cy="80" rx="41" ry="17" fill="#f3f3f3" stroke="#d0d0d0" stroke-width="2"/>
        <path d="M89 80 H171 V142 H89 Z" fill="#f3f3f3" stroke="#d0d0d0" stroke-width="2"/>
        <path d="M90 142 C115 130, 146 130, 171 142" fill="none" stroke="#d0d0d0" stroke-width="2"/>
      </g>

      <g transform="translate(1050,170)" filter="url(#shadow)">
        <rect x="0" y="0" width="260" height="440" fill="url(#goldStripes)"/>
        <text x="130" y="36" text-anchor="middle" fill="#d93e3e" font-size="22" font-weight="700">Gold Layer</text>
        <rect x="89" y="80" width="82" height="62" fill="#f3f3f3" stroke="#d0d0d0" stroke-width="2"/>
        <ellipse cx="130" cy="80" rx="41" ry="17" fill="#f3f3f3" stroke="#d0d0d0" stroke-width="2"/>
        <path d="M89 80 H171 V142 H89 Z" fill="#f3f3f3" stroke="#d0d0d0" stroke-width="2"/>
        <path d="M90 142 C115 130, 146 130, 171 142" fill="none" stroke="#d0d0d0" stroke-width="2"/>
      </g>
    </g>

    <g stroke="#2ec9ff" stroke-width="6" stroke-linecap="round">
      <path d="M180 310 H350" fill="none"/>
      <path d="M610 310 H700" fill="none"/>
      <path d="M960 310 H1050" fill="none"/>
    </g>

    <g fill="#2ec9ff">
      <circle cx="350" cy="310" r="6"/>
      <circle cx="610" cy="310" r="6"/>
      <circle cx="960" cy="310" r="6"/>
    </g>
  </g>
</svg>

```text
Source Files
     ↓
Bronze Layer
     ↓
Silver Layer
     ↓
Gold Layer
     ↓
Analytical Reports
```

<p align="center">
  <img src="docs/data-warehouse-architecture.svg" alt="Lokesh Data Warehouse Architecture" width="1200" />
</p>

## 🗂️ Project Structure

```text
├── datasets/
│   └── Source data files
├── scripts/
│   ├── database/
│   ├── bronze/
│   ├── silver/
│   ├── gold/
│   └── analytics/
├── docs/
│   └── Data warehouse documentation
└── README.md
```

## ⚙️ Technologies Used

- SQL
- Relational databases
- Data warehouse concepts
- ETL and ELT processes
- Data modeling
- Analytical SQL

## 🚀 How to Run the Project

1. Clone the repository:

```bash
git clone https://github.com/LokeshwarReddy200630/LokeshDatawareHouse-SQL-Project.git
```

2. Open the project in your SQL development environment.

3. Execute the scripts in the following order:

```text
1. Database and schema creation
2. Bronze layer table creation
3. Raw data loading
4. Silver layer transformations
5. Gold layer table creation
6. Data quality checks
7. Analytical queries
```

4. Review the analytical results generated from the gold layer.

## 🔄 ETL Workflow

The ETL process includes:

- Extracting data from source files
- Loading raw data into staging tables
- Removing duplicate and invalid records
- Handling missing values
- Standardizing data formats
- Joining related datasets
- Creating fact and dimension tables
- Validating the final data

## 📊 Analytical Queries

The project includes SQL queries for analyzing:

- Customer behavior
- Product performance
- Sales trends
- Revenue by category
- Monthly and yearly performance
- Top-performing products and customers

## ✅ Data Quality Checks

The following validations are performed:

- Duplicate record detection
- Null-value checks
- Invalid date checks
- Referential integrity checks
- Data consistency validation
- Record-count comparison between layers

## 🎯 Project Goals

The main goals of this project are to:

- Practice real-world data warehouse development
- Understand ETL pipeline design
- Improve SQL and data transformation skills
- Build analysis-ready data models
- Generate useful business insights from structured data

## 👤 Author

**Lokeshwar Reddy**

GitHub: [@LokeshwarReddy200630](https://github.com/LokeshwarReddy200630)
