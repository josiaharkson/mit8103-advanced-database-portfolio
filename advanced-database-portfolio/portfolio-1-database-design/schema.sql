-- MIT 8103 Portfolio 1: Relational Database Schema
-- Case Study: Apex Collegiate University Student Result Management Portal
-- Engine: SQLite 3.40+ / PostgreSQL 15+ Compatible DDL

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS course_offerings;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS lecturers;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY AUTOINCREMENT,
    dept_code VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(100) UNIQUE NOT NULL,
    faculty VARCHAR(100) NOT NULL
);

CREATE TABLE students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    matric_no VARCHAR(25) UNIQUE NOT NULL,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    level INT NOT NULL CHECK (level IN (700, 800, 900)),
    department_id INT NOT NULL REFERENCES departments(department_id) ON DELETE RESTRICT
);

CREATE TABLE lecturers (
    lecturer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    staff_no VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(120) NOT NULL,
    rank VARCHAR(50) NOT NULL,
    department_id INT NOT NULL REFERENCES departments(department_id) ON DELETE RESTRICT
);

CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_code VARCHAR(15) UNIQUE NOT NULL,
    title VARCHAR(150) NOT NULL,
    credits INT NOT NULL CHECK (credits BETWEEN 1 AND 6),
    department_id INT NOT NULL REFERENCES departments(department_id) ON DELETE RESTRICT
);

CREATE TABLE course_offerings (
    offering_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INT NOT NULL REFERENCES courses(course_id) ON DELETE RESTRICT,
    lecturer_id INT NOT NULL REFERENCES lecturers(lecturer_id) ON DELETE RESTRICT,
    semester VARCHAR(20) NOT NULL CHECK (semester IN ('First', 'Second')),
    academic_year VARCHAR(9) NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0),
    UNIQUE (course_id, semester, academic_year)
);

CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    offering_id INT NOT NULL REFERENCES course_offerings(offering_id) ON DELETE RESTRICT,
    status VARCHAR(20) NOT NULL DEFAULT 'Registered' CHECK (status IN ('Registered', 'Dropped', 'Completed')),
    enrolled_at TEXT NOT NULL DEFAULT (datetime('now')),
    UNIQUE (student_id, offering_id)
);

CREATE TABLE grades (
    enrollment_id INT PRIMARY KEY REFERENCES enrollments(enrollment_id) ON DELETE CASCADE,
    ca_score NUMERIC(5,2) NOT NULL CHECK (ca_score BETWEEN 0 AND 40),
    exam_score NUMERIC(5,2) NOT NULL CHECK (exam_score BETWEEN 0 AND 60),
    total_score NUMERIC(5,2) GENERATED ALWAYS AS (ca_score + exam_score) STORED,
    letter_grade CHAR(1) NOT NULL CHECK (letter_grade IN ('A', 'B', 'C', 'D', 'E', 'F')),
    grade_point NUMERIC(3,2) NOT NULL CHECK (grade_point BETWEEN 0.00 AND 5.00),
    graded_at TEXT NOT NULL DEFAULT (datetime('now'))
);
