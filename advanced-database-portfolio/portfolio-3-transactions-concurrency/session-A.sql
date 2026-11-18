-- Session A: Holds exclusive write lock during seat allocation
-- PostgreSQL equivalent: BEGIN; SELECT * FROM course_offerings WHERE offering_id = 1 FOR UPDATE;
BEGIN IMMEDIATE;
UPDATE course_offerings SET capacity = capacity - 1 WHERE offering_id = 1;
-- Pause here before COMMIT while Session B attempts concurrent update
COMMIT;
