# Portfolio 1 — Database Design and Modelling
## Schema & Normalization Rationale
- **First Normal Form (1NF):** All attributes are atomic (`ca_score`, `exam_score`, `matric_no`, `course_code`), with no repeating groups.
- **Second Normal Form (2NF):** Every table uses a single-column surrogate primary key (`department_id`, `student_id`, etc.) or a 1:1 primary/foreign key (`grades.enrollment_id`), eliminating partial dependencies.
- **Third Normal Form (3NF):** Transitive dependencies are eliminated by isolating `departments`, `courses`, and `lecturers` from `course_offerings` and `enrollments`.
- **Integrity Constraints:** `CHECK (ca_score BETWEEN 0 AND 40)`, `CHECK (exam_score BETWEEN 0 AND 60)`, generated column `total_score = ca_score + exam_score`, `UNIQUE (student_id, offering_id)`, and `ON DELETE RESTRICT/CASCADE` referential actions.

## Files and rebuild

- `er-diagram.mmd` — diagram source; rendered as `../evidence/er_diagram.png`.
- `schema.sql` — 7 tables with keys and CHECK/UNIQUE constraints. Grading scale used
  throughout: A (70+) = 5.0, B (60-69) = 4.0, C (50-59) = 3.0, D (45-49) = 2.0,
  E (40-44) = 1.0, F (below 40) = 0.0. `total_score` is a generated column.
- `seed.sql` — 4 departments, 6 lecturers, 8 courses, 8 offerings (capacity 400),
  500 students, 2,494 enrollments, 2,494 grades.
- `university_portal.db` — built database. Rebuild with:
  `sqlite3 university_portal.db < schema.sql && sqlite3 university_portal.db < seed.sql`
