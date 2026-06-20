# lms-database-management
Relational database design, schema normalization, and advanced SQL queries for a Learning Management System.
# Academic Project: Relational Database Design for an LMS

## Project Overview
This repository contains the database architecture for a Learning Management System (LMS) developed during my Database Systems course. The project focuses on schema normalization (up to 3NF), establishing relational integrity, and writing optimized SQL queries for academic reporting.


## Architecture & Relational Integrity
* **Normalization:** Designed the schema up to Third Normal Form (3NF) to eliminate data redundancy and data anomalies.
* **Constraints:** Implemented strict primary keys, composite keys, and foreign keys with cascading rules (`ON DELETE CASCADE`) to maintain transactional data integrity across entities.
* **Core Tables:** `Users`, `Students`, `Instructors`, `Courses`, `Enrollments`, and `Departments`.

## Core Queries Implemented
The `queries.sql` file includes optimized scripts for:
1. Multi-table `JOIN`s to generate complete student transcripts.
2. `GROUP BY` and `HAVING` clauses to aggregate average class grades and department performance.
3. Subqueries to track course enrollment capacities.

## Repository Structure
* `lms_database_system.sql`: The complete SQL script containing the database schema creation (DDL), sample data seeding (DML), and analytical reporting queries.

## How to Run
1. Open the `lms_database_system.sql` script in your preferred SQL environment (e.g., MySQL Workbench, SQL Server Management Studio, or pgAdmin).
2. Execute the entire script sequentially to generate the schema, populate the mock data, and view the analytical query outputs.
