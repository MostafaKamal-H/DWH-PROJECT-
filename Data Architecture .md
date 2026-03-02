🏗 Architecture Design
🔹 Data Sources
The system ingests data from:
CRM System
ERP System
CSV Batch Files
🥉 Bronze Layer – Raw Data
The Bronze layer stores raw data exactly as received from source systems.
✔ Characteristics
Object Type: Tables
Load Strategy:
Full Load
Truncate & Insert
🎯 Purpose
Preserve source data
Maintain traceability
Act as historical backup layer
🥈 Silver Layer – Cleaned & Standardized Data
The Silver layer applies data transformations and quality improvements.
✔ Transformations
Data Cleansing
Data Standardization
Data Normalization
Derived Columns
Data Enrichment
✔ Load Strategy
Batch Processing
Full Load
Truncate & Insert
🎯 Purpose
Improve data quality
Prepare structured datasets
Create consistent schema across systems
🥇 Gold Layer – Business-Ready Data
The Gold layer contains analytical models ready for reporting and insights.
✔ Object Type
Views (Logical Layer)
✔ Transformations
Business Logic
Data Integration
Aggregations
✔ Data Models
Star Schema
Aggregated Tables
Flat Analytical Views
