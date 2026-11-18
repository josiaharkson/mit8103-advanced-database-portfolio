# MIT 8103 Advanced Database Systems Portfolio
**Author:** Josiah Arkson Akpe (`Student ID: 301916051 | Miva Open University — September 2026 Cohort`)  
**Case Study:** Apex Collegiate University — Student Result Management Portal  

## 1. Case Study Overview
**Apex Collegiate University Student Result Management Portal** is a centralized postgraduate academic management system serving three user groups:
- **Students:** Register for semester course offerings, view continuous assessment (CA) and examination scores, and retrieve official GPA transcripts.
- **Lecturers:** Manage assigned course offerings, submit CA (0–40) and Exam (0–60) scores, and review course pass-rate distributions.
- **Registry Officers:** Administer academic departments, enforce seat capacity constraints during enrollment windows, audit grade modifications, and generate departmental CGPA leaderboards.

## 2. Repository Structure
```text
advanced-database-portfolio/
├── portfolio-1-database-design/
│   ├── er-diagram.mmd
│   ├── schema.sql
│   ├── seed.sql
│   ├── university_portal.db
│   └── README.md
├── portfolio-2-query-optimisation/
│   ├── queries.sql
│   ├── index-comparison.sql
│   └── README.md
├── portfolio-3-transactions-concurrency/
│   ├── transactions.sql
│   ├── session-A.sql
│   ├── session-B.sql
│   └── README.md
├── portfolio-4-nosql/
│   ├── expected-document-shape.json
│   ├── student_transcripts_collection.json
│   ├── mongodb.js
│   └── README.md
├── portfolio-5-distributed-cloud/
│   ├── architecture.mmd
│   ├── architecture-analysis.md
│   └── README.md
├── evidence/
│   ├── er_diagram.png
│   ├── cloud_architecture.png
│   ├── query_optimization_log.txt
│   ├── transactions_concurrency_log.txt
│   └── nosql_aggregation_output.txt
└── README.md
```

## 3. Summary of Verified Technical Work
1. **Portfolio 1 (Relational Design & 3NF):** Designed a 7-table relational schema (`departments`, `students`, `lecturers`, `courses`, `course_offerings`, `enrollments`, `grades`) enforcing entity, referential, and domain integrity (`CHECK`, `UNIQUE`, `GENERATED ALWAYS AS` columns) and populated 500 students with 2,494 enrollment/grade records.
2. **Portfolio 2 (Query Processing & Indexing):** Benchmarked multi-table transcript, pass-rate, and CGPA queries, and demonstrated a **46.0% lower mean latency (1.85x speedup, 0.1957 ms to 0.1058 ms over 500 runs)** using composite covering indexes (`idx_enrollments_offering`, `idx_grades_grade_score`).
3. **Portfolio 3 (ACID Transactions & Concurrency):** Verified durable atomic enrollment (`COMMIT`), clean error recovery (`ROLLBACK`), and two-session write-lock contention preventing lost updates on course seat capacity.
4. **Portfolio 4 (NoSQL Document Model):** Transformed normalized student records into denormalized MongoDB transcript documents for O(1) single-document reads and verified cross-course analytics using an `$unwind` + `$group` aggregation pipeline.
5. **Portfolio 5 (Distributed & Cloud Architecture):** Designed a Multi-AZ primary/standby relational topology with WAL streaming replication, PgBouncer connection pooling, CDC sync to MongoDB Atlas, and Point-in-Time Recovery (PITR).
