-- Session B: Concurrent registration session attempting to update the same row
BEGIN IMMEDIATE;
UPDATE course_offerings SET capacity = capacity - 1 WHERE offering_id = 1;
COMMIT;
