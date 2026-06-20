# lms-database-management
Relational database design, schema normalization, and advanced SQL queries for a Learning Management System.
# Academic Project: Relational Database Design for an LMS

## Project Overview
This repository contains the database architecture for a Learning Management System (LMS) developed during my Database Systems course. The project focuses on schema normalization (up to 3NF), establishing relational integrity, and writing optimized SQL queries for academic reporting.

## Database Schema (ER Diagram)
<!-- If you have an ER diagram image, upload it to GitHub and link it here like this: -->
![LMS ER Diagram](your_uploaded_image_name.png)

## Architecture & Relational Integrity
* **Normalization:** Designed the schema up to Third Normal Form (3NF) to eliminate data redundancy and data anomalies.
* **Constraints:** Implemented strict primary keys, composite keys, and foreign keys with cascading rules (`ON DELETE CASCADE`) to maintain transactional data integrity across entities.
* **Core Tables:** `Users`, `Students`, `Instructors`, `Courses`, `Enrollments`, and `Departments`.

## Core Queries Implemented
The `queries.sql` file includes optimized scripts for:
1. Multi-table `JOIN`s to generate complete student transcripts.
2. `GROUP BY` and `HAVING` clauses to aggregate average class grades and department performance.
3. Subqueries to track course enrollment capacities.

## How to Run
1. Execute `schema.sql` to generate the database structure.
2. Execute `data_seeding.sql` to populate the tables with sample mock data.
3. Run `queries.sql` to test individual business reporting scenarios.
