# lms-database-management
Relational database design, schema normalization, and advanced SQL queries for a Learning Management System.
# Academic Project: Relational Database Design for an LMS

# Academic Project: Library Management System Relational Database

## Project Overview
This repository contains a fully implemented relational database system for a Library Management System (LMS) developed for my Database Systems course. The project includes full table schemas, constraints, custom database views, transactional stored procedures, and automated database triggers to enforce library policy and business rules.

## Database Schema Architecture
The database structure manages the primary relationships between library inventory, authorship, and memberships:
* **Authors:** Stores demographic data on content creators.
* **Categories:** Maintains unique lookup tags for book classifications.
* **Books:** Handles tracking details, physical shelf placements, and active inventory availability counts.
* **Members:** Manages user classification accounts (Students, Faculty, Staff), custom borrow caps, and contact logs.
* **BorrowRecords:** Tracks transactional history, overdue states, timestamps, and fine assessments.

## Advanced Database Automation Features

### 1. Stored Procedures (Data Abstraction)
* `sp_BorrowBook`: Automates the checkout verification cycle. It checks if copies are available, updates stock counts by decrementing inventory, and builds the transaction record.
* `sp_ReturnBook`: Automatically processes a physical check-in, calculates overdue thresholds dynamically using `datediff`, and flags a late fine multiplier of 5 units per overdue day.
* `sp_SearchBook`: Provides abstract wildcard textual parsing across catalog records utilizing clean `INNER JOIN` sets.

### 2. Database Triggers (Policy Automation)
* `trg_CheckBorrowLimit`: An `INSTEAD OF INSERT` safeguard that programmatically halts transaction loops if a member tries to check out more books than their account type threshold safely allows (e.g., maximum cap parameters).
* `trg_LogFine`: An automated `AFTER UPDATE` auditing hook that populates a dedicated security log table (`FineAuditLog`) whenever a financial liability charge gets processed.
* `trg_PreventBookDelete`: Keeps catalog states stable by restricting standard data pruning if system tables detect a book is currently out on loan.

### 3. Modular Reporting Views
* `vw_ActiveBorrows`: Displays live, unreturned assets along with borrower names and target deadlines.
* `vw_OverdueBooks`: Tracks active systemic risk by surfacing penalizable balances alongside corresponding member identities.
* `vw_MemberSummary`: Aggregates customer data profiles to deliver high-level metrics on total transaction volumes and accrued late fees using aggregated operations (`GROUP BY`).

## Repository File Structure
* `db project LMS.sql`: The comprehensive master script containing the DDL script generation definitions, operational record seeding inserts, nested multi-table `JOIN` queries, analytical subqueries, and advanced schema validation hooks.

## Deployment Instructions
1. Open the file `db project LMS.sql` in any Microsoft SQL Server Management Studio (SSMS) environment.
2. Initialize your instance by making sure the host destination creates or points to a target catalog via `use LibraryManagementSystem_Project;`.
3. Execute the full script sequentially to construct the schema tables, seed mock transactional rows, register system configurations, and execute functional procedures.
