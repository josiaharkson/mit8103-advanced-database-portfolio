MIT 8103 Advanced Database Systems - Continuous Assessment Submission
Student Name: Josiah Arkson Akpe
Student ID: 301916051
Student Email: j.akpe6051@miva.edu.ng
Course: MIT 8103 - Advanced Database Systems (September 2026 Cohort)
Institution: Miva Open University (School of Postgraduate Studies)
Case Study: Apex Collegiate University Student Result Management Portal
GitHub Repository: https://github.com/josiaharkson/mit8103-advanced-database-portfolio

Submission package (folder Akpe_Josiah_301916051)
1. Akpe_Josiah_301916051_PortfolioReport.pdf - 3-page report: case study, all five
   portfolios, ER and cloud diagrams, benchmark and transcript tables, reflection,
   references and AI Use Declaration.
2. Akpe_Josiah_301916051_PortfolioReport.docx - editable Word version, same content.
3. Akpe_Josiah_301916051_README.txt - this file (also uploaded separately on the form).
4. advanced-database-portfolio/ - portfolio repository:
   portfolio-1-database-design (er-diagram.mmd, schema.sql, seed.sql,
   university_portal.db, README.md), portfolio-2-query-optimisation (queries.sql,
   index-comparison.sql, README.md), portfolio-3-transactions-concurrency
   (transactions.sql, session-A.sql, session-B.sql, README.md), portfolio-4-nosql
   (mongodb.js, expected-document-shape.json, student_transcripts_collection.json,
   README.md), portfolio-5-distributed-cloud (architecture.mmd,
   architecture-analysis.md, README.md), evidence/ (er_diagram.png,
   cloud_architecture.png, query_optimization_log.txt,
   transactions_concurrency_log.txt, nosql_aggregation_output.txt), README.md.

Work checked by running the files
- Portfolio 1: rebuilt with sqlite3 university_portal.db < schema.sql then
  < seed.sql. Counts: 500 students, 8 offerings, 2,494 enrollments, 2,494 grades;
  foreign-key check clean; total_score equals CA + exam on every grade row.
- Portfolio 2: transcript, pass-rate and CGPA queries run (queries.sql). Distinction
  test for MIT8103 (offering_id = 2, 75 rows, 500-run mean): 0.1957 ms before
  indexes, 0.1058 ms after the two covering indexes (1.85x, 46.0% lower).
- Portfolio 3: on a working copy, enrolment COMMIT (offering 5 capacity 400 to 399,
  visible from a second connection), grade ROLLBACK (84.0 to 100.0 and back to 84.0),
  and two-session locking (Session B blocked 188.1 ms with "database is locked",
  then succeeded; offering 1 capacity 400 to 398).
- Portfolio 4: 10 documents in student_transcripts; single-document lookup by
  matric number; $unwind/$group aggregation returned 8 course rows.
- Portfolio 5: Multi-AZ PostgreSQL primary/standby with PgBouncer, WAL streaming,
  MongoDB Atlas transcript cache and PITR archiving (RPO < 5 min, RTO < 15 min).
