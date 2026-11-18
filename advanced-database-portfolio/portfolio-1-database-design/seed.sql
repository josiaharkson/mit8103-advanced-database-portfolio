-- MIT 8103 Portfolio 1: Seed Data Script
-- Case Study: Apex Collegiate University Student Result Management Portal
-- Cohort seed: 4 departments, 6 lecturers, 8 courses, 8 offerings,
-- 500 students, 2,494 enrollments and 2,494 grades.

INSERT INTO departments (dept_code, name, faculty) VALUES
('MIT', 'Information Technology', 'School of Postgraduate Studies'),
('MCS', 'Cybersecurity & Network Engineering', 'School of Postgraduate Studies'),
('MDS', 'Data Science & Artificial Intelligence', 'School of Postgraduate Studies'),
('MBA', 'Business & Technology Management', 'School of Postgraduate Studies');

INSERT INTO lecturers (staff_no, full_name, rank, department_id) VALUES
('STF-101', 'Prof. Amina Lawal', 'Professor', 1),
('STF-102', 'Dr. Chika Obi', 'Senior Lecturer', 1),
('STF-103', 'Dr. Ibrahim Danjuma', 'Associate Professor', 2),
('STF-104', 'Dr. Ngozi Eze', 'Senior Lecturer', 3),
('STF-105', 'Dr. Babatunde Adeyemi', 'Lecturer I', 4),
('STF-106', 'Dr. Fatima Abdullahi', 'Senior Lecturer', 1);

INSERT INTO courses (course_code, title, credits, department_id) VALUES
('MIT8101', 'Foundations of Information Technology', 3, 1),
('MIT8103', 'Advanced Database Systems', 3, 1),
('MIT8105', 'Network Architecture and Protocols', 3, 2),
('MIT8107', 'Enterprise Software Engineering', 3, 1),
('MIT8109', 'Applied Machine Learning & Analytics', 3, 3),
('MIT8111', 'Cloud Computing & Distributed Systems', 2, 2),
('MIT8113', 'IT Governance and Risk Management', 2, 4),
('MIT8115', 'Information Security & Cryptography', 3, 2);

INSERT INTO course_offerings (course_id, lecturer_id, semester, academic_year, capacity) VALUES
(1, 1, 'First', '2026/2027', 400),
(2, 2, 'First', '2026/2027', 400),
(3, 3, 'First', '2026/2027', 400),
(4, 6, 'First', '2026/2027', 400),
(5, 4, 'First', '2026/2027', 400),
(6, 3, 'First', '2026/2027', 400),
(7, 5, 'First', '2026/2027', 400),
(8, 2, 'First', '2026/2027', 400);

INSERT INTO students (matric_no, full_name, email, level, department_id) VALUES
('ACU20260001', 'Adaeze Okoro', 'adaeze.okoro@apexuni.edu.ng', 800, 1),
('ACU20260002', 'Babatunde Bello', 'babatunde.bello@apexuni.edu.ng', 800, 1),
('ACU20260003', 'Zainab Musa', 'zainab.musa@apexuni.edu.ng', 800, 2),
('ACU20260004', 'Chinedu Okafor', 'chinedu.okafor@apexuni.edu.ng', 800, 3),
('ACU20260005', 'Aisha Suleiman', 'aisha.suleiman@apexuni.edu.ng', 800, 1),
('ACU20260006', 'Kemi Musa', 'kemi.musa6@apexuni.edu.ng', 800, 3),
('ACU20260007', 'Chinedu Eze', 'chinedu.eze7@apexuni.edu.ng', 800, 4),
('ACU20260008', 'Aisha Garba', 'aisha.garba8@apexuni.edu.ng', 800, 1),
('ACU20260009', 'Femi Nwosu', 'femi.nwosu9@apexuni.edu.ng', 800, 2),
('ACU20260010', 'Nneka Suleiman', 'nneka.suleiman10@apexuni.edu.ng', 800, 3);

-- Students 11-500: cohort records ACU20260011 to ACU20260500.
WITH RECURSIVE seq(n) AS (
    SELECT 11 UNION ALL SELECT n + 1 FROM seq WHERE n < 500
),
first_names(idx, fn) AS (VALUES
    (0,'Tunde'),(1,'Funke'),(2,'Ibrahim'),(3,'Ngozi'),(4,'Emeka'),(5,'Halima'),
    (6,'Segun'),(7,'Bisi'),(8,'Yusuf'),(9,'Amara'),(10,'Olumide'),(11,'Fatima'),
    (12,'Kechi'),(13,'Musa'),(14,'Ada'),(15,'Bola'),(16,'Sani'),(17,'Ruth'),
    (18,'Ifeanyi'),(19,'Zainab')),
last_names(idx, ln) AS (VALUES
    (0,'Adeyemi'),(1,'Okonkwo'),(2,'Bello'),(3,'Eze'),(4,'Garba'),(5,'Ojo'),
    (6,'Nwosu'),(7,'Lawal'),(8,'Okafor'),(9,'Musa'),(10,'Ibrahim'),(11,'Suleiman'),
    (12,'Adeleke'),(13,'Obi'),(14,'Danjuma'),(15,'Okoro'),(16,'Balogun'),(17,'Umar'),
    (18,'Eze'),(19,'Nwachukwu'),(20,'Ogunleye'),(21,'Abubakar'),(22,'Chukwu'),
    (23,'Salami'),(24,'Onyeka'))
INSERT INTO students (matric_no, full_name, email, level, department_id)
SELECT printf('ACU2026%04d', n),
       f.fn || ' ' || l.ln,
       lower(f.fn) || '.' || lower(l.ln) || n || '@apexuni.edu.ng',
       800,
       ((n - 1) % 4) + 1
FROM seq
JOIN first_names f ON f.idx = (n % 20)
JOIN last_names l ON l.idx = ((n / 20) % 25);

-- Enrollments for students 1-10 (transcript records in Portfolio 4).
INSERT INTO enrollments (student_id, offering_id, status) VALUES
(1,1,'Completed'),
(1,2,'Completed'),
(1,3,'Completed'),
(1,4,'Completed'),
(1,6,'Completed'),
(2,1,'Completed'),
(2,2,'Completed'),
(2,4,'Completed'),
(2,7,'Completed'),
(3,2,'Completed'),
(3,3,'Completed'),
(3,6,'Completed'),
(3,8,'Completed'),
(4,2,'Completed'),
(4,5,'Completed'),
(4,6,'Completed'),
(5,1,'Completed'),
(5,2,'Completed'),
(5,3,'Completed'),
(6,4,'Completed'),
(6,5,'Completed'),
(6,6,'Completed'),
(6,7,'Completed'),
(6,8,'Completed'),
(7,2,'Completed'),
(7,3,'Completed'),
(7,6,'Completed'),
(7,7,'Completed'),
(7,8,'Completed'),
(8,1,'Completed'),
(8,3,'Completed'),
(8,6,'Completed'),
(8,7,'Completed'),
(8,8,'Completed'),
(9,1,'Completed'),
(9,4,'Completed'),
(9,5,'Completed'),
(9,6,'Completed'),
(9,8,'Completed'),
(10,2,'Completed'),
(10,4,'Completed'),
(10,6,'Completed'),
(10,7,'Completed'),
(10,8,'Completed');

-- Enrollments for students 11-500: five offerings per student on rotation.
WITH RECURSIVE seq(n) AS (
    SELECT 11 UNION ALL SELECT n + 1 FROM seq WHERE n < 500
),
slots(k) AS (VALUES (0),(1),(2),(3),(4))
INSERT INTO enrollments (student_id, offering_id, status)
SELECT n, ((n - 1 + k) % 8) + 1, 'Completed'
FROM seq CROSS JOIN slots
ORDER BY n, ((n - 1 + k) % 8) + 1;

-- Fixed status for the first cohort so transcripts read as completed.
UPDATE enrollments SET status = 'Completed';

-- Grades for students 1-10.
WITH known(student_id, offering_id, ca_score, exam_score) AS (VALUES
(1,1,34.0,50.0),
(1,2,32.0,48.0),
(1,3,29.0,44.0),
(1,4,35.0,52.0),
(1,6,30.0,42.0),
(2,1,25.0,40.0),
(2,2,28.0,41.0),
(2,4,31.0,46.0),
(2,7,26.0,38.0),
(3,2,33.0,49.0),
(3,3,36.0,53.0),
(3,6,31.0,45.0),
(3,8,34.0,48.0),
(4,2,24.0,35.0),
(4,5,35.0,51.0),
(4,6,27.0,39.0),
(5,1,30.0,43.0),
(5,2,29.0,45.0),
(5,3,27.0,40.0),
(6,4,29.1,37.4),
(6,5,32.8,41.2),
(6,6,36.3,27.0),
(6,7,21.9,52.2),
(6,8,23.6,29.3),
(7,2,31.3,49.9),
(7,3,25.9,33.4),
(7,6,34.7,47.7),
(7,7,19.9,43.3),
(7,8,18.7,25.2),
(8,1,25.1,45.6),
(8,3,33.2,43.1),
(8,6,25.2,44.0),
(8,7,25.6,26.5),
(8,8,35.1,44.6),
(9,1,31.0,32.3),
(9,4,30.0,47.9),
(9,5,29.2,27.8),
(9,6,36.8,55.8),
(9,8,31.9,47.8),
(10,2,22.2,27.1),
(10,4,22.9,37.0),
(10,6,22.4,47.3),
(10,7,37.1,39.7),
(10,8,27.7,46.2))
INSERT INTO grades (enrollment_id, ca_score, exam_score, letter_grade, grade_point)
SELECT e.enrollment_id, k.ca_score, k.exam_score,
       CASE WHEN k.ca_score + k.exam_score >= 70 THEN 'A'
            WHEN k.ca_score + k.exam_score >= 60 THEN 'B'
            WHEN k.ca_score + k.exam_score >= 50 THEN 'C'
            WHEN k.ca_score + k.exam_score >= 45 THEN 'D'
            WHEN k.ca_score + k.exam_score >= 40 THEN 'E' ELSE 'F' END,
       CASE WHEN k.ca_score + k.exam_score >= 70 THEN 5.00
            WHEN k.ca_score + k.exam_score >= 60 THEN 4.00
            WHEN k.ca_score + k.exam_score >= 50 THEN 3.00
            WHEN k.ca_score + k.exam_score >= 45 THEN 2.00
            WHEN k.ca_score + k.exam_score >= 40 THEN 1.00 ELSE 0.00 END
FROM enrollments e
JOIN known k ON k.student_id = e.student_id AND k.offering_id = e.offering_id;

-- Grades for students 11-500 (CA 0-40, Exam 0-60, 5.00 scale as above).
INSERT INTO grades (enrollment_id, ca_score, exam_score, letter_grade, grade_point)
SELECT e.enrollment_id,
       15 + ((e.student_id * 13 + e.offering_id * 7) % 22),
       18 + ((e.student_id * 17 + e.offering_id * 11) % 38),
       CASE WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 70 THEN 'A'
            WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 60 THEN 'B'
            WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 50 THEN 'C'
            WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 45 THEN 'D'
            WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 40 THEN 'E' ELSE 'F' END,
       CASE WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 70 THEN 5.00
            WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 60 THEN 4.00
            WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 50 THEN 3.00
            WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 45 THEN 2.00
            WHEN (15 + ((e.student_id * 13 + e.offering_id * 7) % 22))
               + (15 + ((e.student_id * 17 + e.offering_id * 11) % 38)) >= 40 THEN 1.00 ELSE 0.00 END
FROM enrollments e
WHERE e.student_id >= 11;
