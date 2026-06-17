# Enterprise Database Lifecycle Architecture

## Overview
This repository contains a production-grade relational database lifecycle deployed on Microsoft SQL Server. It demonstrates the complete architectural flow from initial schema design to data staging, normalization, and security auditing.

## Project Phases & Structure

### 1. Schema Initialization (`/schema-initialization`)
* **Architecture:** Designed a strict Third Normal Form (3NF) relational schema to eliminate data redundancy and preserve referential integrity.
* **Implementation:** Utilized independent dimension tables (Directors, Stars, Genres, Producers) mapped to a central Fact table via strictly numeric Foreign Keys.

### 2. Data Migration & ETL (`/data-migration-etl`)
* **Staging:** Engineered a temporary staging environment to intercept unorganized, flat-file mock data (simulating raw CSV imports).
* **Transformation:** Developed an automated SQL pipeline to scrub duplicates, extract distinct entities, and seamlessly map relational identifiers into the normalized architecture.

### 3. Security & Access Control (`/security-rbac`)
* **Data Abstraction:** Constructed secure Views to provide read-only, pre-joined data layers, preventing direct access to base tables.
* **ACID Compliance:** Built fault-tolerant Stored Procedures utilizing `TRY/CATCH/ROLLBACK` transactional blocks to prevent partial data corruption during multi-step inserts.
* **Role-Based Access Control (RBAC):** Established granular security roles (e.g., `ReportAuditor`, `DataEntryClerk`) adhering to the Principle of Least Privilege (PoLP).

## Technology Stack
* **Engine:** Microsoft SQL Server (Docker Containerized)
* **Language:** T-SQL
* **Concepts:** 3NF Normalization, ETL Pipelines, Transactional Processing (ACID), RBAC, Relational Modeling