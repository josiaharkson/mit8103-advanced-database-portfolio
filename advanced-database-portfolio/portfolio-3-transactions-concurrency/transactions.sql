-- MIT 8103 Portfolio 3: ACID Transactions (COMMIT & ROLLBACK)

-- 1. Atomic Student Course Registration (COMMIT)
BEGIN TRANSACTION;
INSERT INTO enrollments (student_id, offering_id, status)
VALUES (1, 5, 'Registered');

UPDATE course_offerings
SET capacity = capacity - 1
WHERE offering_id = 5 AND capacity > 0;
COMMIT;

-- 2. Erroneous Grade Modification Recovery (ROLLBACK)
BEGIN TRANSACTION;
UPDATE grades
SET ca_score = 40.0, exam_score = 60.0, letter_grade = 'A', grade_point = 5.00
WHERE enrollment_id = 1;

-- Audit check detects unauthorized score override -> Abort transaction
SELECT enrollment_id, ca_score, exam_score, total_score FROM grades WHERE enrollment_id = 1;
ROLLBACK;

-- Verify original grade remains intact
SELECT enrollment_id, ca_score, exam_score, total_score FROM grades WHERE enrollment_id = 1;
