# Portfolio 2 — Query Processing and Optimisation

Dataset: 500 students, 8 offerings, 2,494 enrollments, 2,494 grades in
`../portfolio-1-database-design/university_portal.db` (see `../evidence/query_optimization_log.txt`).

Queries in `queries.sql`:
1. Transcript for one student (`ACU20260001`) with CA, exam, total, grade and grade point.
2. Per-course counts, mean/highest/lowest scores and pass rate (total >= 50).
3. Top-5 CGPA leaderboard on the 5.00 scale weighted by course credits.

Index test in `index-comparison.sql` — all Distinction records (`letter_grade = 'A'`)
for MIT8103 (`offering_id = 2`), mean of 500 runs:

- Before: 75 rows, 0.1957 ms. Plan scanned `enrollments` through its
  `sqlite_autoindex` and looked up `grades` by primary key.
- After `idx_enrollments_offering(offering_id, student_id)` and
  `idx_grades_grade_score(letter_grade, enrollment_id, total_score)`: 0.1058 ms.
  Both sides of the join are covered by the new indexes.
- Change: 1.85x faster, 46.0% lower mean latency.

On the small hand-checked records alone the two plans timed the same, which is why
the test uses the full 2,494-row set. Timings are from this machine and will differ
elsewhere; the plan change is the portable part.
