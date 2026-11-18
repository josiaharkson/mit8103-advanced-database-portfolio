-- MIT 8103 Portfolio 2: Analytical Queries & Execution Plan Optimization

-- Query 1: Student Transcript & Semester GPA Calculation (5.00 Scale)
SELECT s.matric_no, s.full_name, c.course_code, c.title, c.credits,
       g.ca_score, g.exam_score, g.total_score, g.letter_grade, g.grade_point
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN course_offerings o ON o.offering_id = e.offering_id
JOIN courses c ON c.course_id = o.course_id
JOIN grades g ON g.enrollment_id = e.enrollment_id
WHERE s.matric_no = 'ACU20260001'
ORDER BY c.course_code;

-- Query 2: Course Performance Summary & Pass Rate Analytics
SELECT c.course_code, c.title, l.full_name AS lecturer,
       COUNT(g.enrollment_id) AS graded_students,
       ROUND(AVG(g.total_score), 2) AS mean_score,
       MAX(g.total_score) AS highest_score,
       MIN(g.total_score) AS lowest_score,
       ROUND(100.0 * SUM(CASE WHEN g.total_score >= 50 THEN 1 ELSE 0 END) / COUNT(*), 1) AS pass_rate_pct
FROM courses c
JOIN course_offerings o ON o.course_id = c.course_id
JOIN lecturers l ON l.lecturer_id = o.lecturer_id
JOIN enrollments e ON e.offering_id = o.offering_id
JOIN grades g ON g.enrollment_id = e.enrollment_id
GROUP BY c.course_code, c.title, l.full_name
ORDER BY mean_score DESC;

-- Query 3: Departmental CGPA Leaderboard (Top 5 Students)
SELECT d.dept_code, s.matric_no, s.full_name,
       SUM(c.credits) AS total_units,
       ROUND(SUM(g.grade_point * c.credits) / SUM(c.credits), 2) AS gpa
FROM students s
JOIN departments d ON d.department_id = s.department_id
JOIN enrollments e ON e.student_id = s.student_id
JOIN course_offerings o ON o.offering_id = e.offering_id
JOIN courses c ON c.course_id = o.course_id
JOIN grades g ON g.enrollment_id = e.enrollment_id
GROUP BY d.dept_code, s.matric_no, s.full_name
ORDER BY gpa DESC, total_units DESC
LIMIT 5;
