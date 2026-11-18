-- MIT 8103 Portfolio 2: Index Optimization Comparison
-- Target Workload: Retrieve all Distinction ('A') candidates for MIT8103 (offering_id = 2)

-- STEP 1: Baseline (No secondary index on enrollments.offering_id or grades.letter_grade)
DROP INDEX IF EXISTS idx_enrollments_offering;
DROP INDEX IF EXISTS idx_grades_grade_score;

EXPLAIN QUERY PLAN
SELECT e.enrollment_id, e.student_id, g.total_score, g.letter_grade
FROM enrollments e
JOIN grades g ON g.enrollment_id = e.enrollment_id
WHERE e.offering_id = 2 AND g.letter_grade = 'A';

-- STEP 2: Create Composite Covering Indexes & Gather Optimizer Statistics
CREATE INDEX idx_enrollments_offering ON enrollments(offering_id, student_id);
CREATE INDEX idx_grades_grade_score ON grades(letter_grade, enrollment_id, total_score);
ANALYZE;

-- STEP 3: Post-Index Execution Plan
EXPLAIN QUERY PLAN
SELECT e.enrollment_id, e.student_id, g.total_score, g.letter_grade
FROM enrollments e
JOIN grades g ON g.enrollment_id = e.enrollment_id
WHERE e.offering_id = 2 AND g.letter_grade = 'A';
