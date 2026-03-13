# Lab-Inventory-SQL-Database
A relational database project for managing synthetic biology lab inventory

# SynBio Laboratory Inventory Management (SQL)

## 📌 Project Overview
In synthetic biology and genetic engineering (like iGEM), efficient tracking of reagents, enzymes, and plasmids is crucial for both Wet Lab and Dry Lab operations. This project demonstrates the design and implementation of a **Relational Database Management System (RDBMS)** using SQL to optimize lab inventory tracking, prevent reagent shortages, and monitor material usage.

## 🗄️ Database Schema Design
The database consists of three main interconnected tables:
1. **`Researchers`**: Stores information about lab members and their roles.
2. **`Inventory`**: Catalogs items (Plasmids, Enzymes, Reagents, Antibiotics) including current stock, storage locations (e.g., `-80C Freezer`), and minimum thresholds.
3. **`Usage_Log`**: Tracks transactions of who used what item, when, how much, and for what experimental purpose.

*Relationships: `Usage_Log` uses foreign keys linked to `Inventory(item_id)` and `Researchers(researcher_id)`.*

## 💻 Key SQL Skills Demonstrated
- **Data Definition Language (DDL):** `CREATE TABLE`, defining `PRIMARY KEY` and `FOREIGN KEY` constraints.
- **Data Manipulation Language (DML):** `INSERT INTO` for populating synthetic biology dummy data.
- **Advanced Querying:**
  - `WHERE` clauses for conditional filtering (e.g., automated low-stock alerts).
  - `JOIN` operations to merge logs with researcher and item details.
  - `GROUP BY` and aggregate functions (`SUM`) for resource allocation analysis.

## 📊 Example Queries Included in the Script
1. **Low Stock Alert:** Identifies items (e.g., Ampicillin, EcoRI) that have fallen below their minimum threshold and require immediate restocking.
2. **Usage Tracking:** A fully joined log showing the date, item name, researcher name, quantity used, and the specific experimental purpose (e.g., "PCR amplification").
3. **Resource Consumption:** Aggregates total material used grouped by category.

