CREATE DATABASE college;
USE college;

CREATE TABLE student (
	rollno INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT NOT NULL,
    grade VARCHAR(1),
    city VARCHAR(20)
);

CREATE TABLE dept (
	id INT PRIMARY KEY,
    name VARCHAR(50),
);

CREATE TABLE teacher (
	id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES dept(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

DROP TABLE teacher;

INSERT INTO student (rollno, name, marks, grade, city)
VALUES
(101, "Amit", 78, "C", "Pune"),
(102, "Bhumika", 93, "A", "Mumbai"),
(103, "Chetan", 85, "B", "Mumbai"),
(104, "Dhruv", 96, "A", "Delhi"),
(105, "Esha", 12, "F", "Delhi");

INSERT INTO dept
VALUES
(101, "Science"),
(102, "Hindi"),
(103, "English");

INSERT INTO teacher
VALUES
(101, "Adam", 101),
(102, "Eve", 103);

SELECT name, marks FROM student;

SELECT DISTINCT city FROM student;

SELECT name, marks, city FROM student
WHERE marks >= 80 AND city="Mumbai";

SELECT * FROM student
WHERE marks BETWEEN 80 AND 90;

SELECT * FROM student
WHERE city IN ("Delhi", "Mumbai");

SELECT * FROM student
WHERE city NOT IN ("Delhi", "Mumbai");

SELECT * FROM student
WHERE marks >= 80
LIMIT 3;

SELECT * FROM student
ORDER BY marks DESC;

SELECT MAX(marks)
FROM student;

SELECT city, COUNT(rollno)
FROM student
GROUP BY city;

# Write a query to find avg marks in each city in ascending order
SELECT city, AVG(marks) 
FROM student 
GROUP BY city
ORDER BY AVG(marks);

# Count number of students in each city where max marks cross 90
SELECT city, COUNT(rollno)
FROM student
GROUP BY city
HAVING MAX(marks) > 90;

# To update grade A to grade O
UPDATE student
SET grade = "O"
WHERE grade = "A";

SELECT * FROM student;

# To turn off safe mode
SET SQL_SAFE_UPDATES = 1;

# To delete students having marks less than 33
DELETE FROM student
WHERE marks < 33;
SELECT * FROM student;


# Table Relates Queries
UPDATE dept
SET name = "IT"
WHERE id = "102";
SELECT * FROM dept;

# Cascading
UPDATE dept
SET id = 104
WHERE id = 103;
SELECT * FROM dept;
SELECT * FROM teacher;

# Altering the table schema
ALTER TABLE student
ADD COLUMN age INT;

# Altering table to add age column
ALTER TABLE student
ADD COLUMN age INT NOT NULL DEFAULT 19;
SELECT * FROM student;

# Altering age column to modify datatype
ALTER TABLE student
MODIFY COLUMN age VARCHAR(2);

INSERT INTO student
(rollno, name, age, marks)
VALUES
(109, "Riya", 21, 96);

# Changing age column to stu_age and int
ALTER TABLE student
CHANGE COLUMN age stu_age INT;

# Dropping the age column
ALTER TABLE student
DROP COLUMN stu_age;

DROP TABLE student;
DROP DATABASE college;


# JOINS
CREATE DATABASE school;
USE school;

CREATE TABLE student (
id INT PRIMARY KEY,
name VARCHAR(50)
);

CREATE TABLE course(
id INT PRIMARY KEY,
course VARCHAR(50)
);

INSERT INTO student VALUES
(101, "adam"),
(102, "bob"),
(103, "casey");

INSERT INTO course VALUES
(102, "English"),
(103, "Math"),
(105, "Science"),
(107, "IT");

SELECT * FROM student;
SELECT * FROM course;

# Inner Join
SELECT *
FROM student AS a
INNER JOIN course AS b
ON a.id = b.id;

# Left Join
SELECT * 
FROM student AS a
LEFT JOIN course AS b
ON a.id = b.id;

# Right Join
SELECT * 
FROM student AS a
RIGHT JOIN course AS b
ON a.id = b.id;

# Full Join
SELECT *
FROM student AS a
LEFT JOIN course AS b
ON a.id = b.id
UNION
SELECT * 
FROM student AS a
RIGHT JOIN course AS b
ON a.id = b.id;

# Left Exclusive Join
SELECT *
FROM student AS a
LEFT JOIN course AS b
ON a.id = b.id
WHERE b.id IS NULL;

# Right Exclusive Join
SELECT *
FROM student AS a
RIGHT JOIN course AS b
ON a.id = b.id
WHERE a.id IS NULL;

# Full Exclusive Join
SELECT *
FROM student AS a
LEFT JOIN course AS b
ON a.id = b.id
WHERE b.id IS NULL
UNION
SELECT *
FROM student AS a
RIGHT JOIN course AS b
ON a.id = b.id
WHERE a.id IS NULL;

# Self Join
CREATE TABLE employee(
id INT PRIMARY KEY,
name VARCHAR(20),
manager_id INT);

INSERT INTO employee VALUES
(101, "Adam", 103),
(102, "Bob", 104),
(103, "Casey", NULL),
(104, "Donald", 103);

SELECT * FROM employee;

SELECT *
FROM employee AS a
JOIN employee AS b
ON a.id = b.manager_id;

# Efficient Self Join
SELECT a.name AS manager_name, b.name
FROM employee AS a
JOIN employee AS b
ON a.id = b.manager_id;

# SQL Subqueries
CREATE TABLE student2(
id INT PRIMARY KEY,
name VARCHAR(20),
marks INT NOT NULL,
grade VARCHAR(1),
city VARCHAR(20)
);

INSERT INTO student2 VALUES
(101, "anil", 78, "C", "Pune"),
(102, "bhumika", 93, "A", "Mumbai"),
(103, "chetan", 85, "B", "Mumbai"),
(104, "dhruv", 96, "A", "Delhi"),
(105, "emanuel", 92, "A", "Delhi"),
(106, "farah", 82, "B", "Delhi");

SELECT * FROM student2;

# Question: Find the names of students whose marks are greater than average of the class
# Step 1: Find average
SELECT AVG(marks)
FROM student2; # Avg = 87.6667
# Step 2: Find students marks > avg
SELECT name FROM student2
WHERE marks >
(SELECT AVG(marks) FROM student2);

# Question: Find the names of all students with even roll numbers
# Step 1: Find the even roll nos
SELECT id 
FROM student2
WHERE id % 2 = 0;
# Step 2: Find the names of students with even roll nos
SELECT id, name
FROM student2
WHERE id IN (
	SELECT id
    FROM student2
    WHERE id % 2 = 0
);

# Question: Find the max marks from the students of Delhi
# Step 1: Find the students of Delhi
SELECT * 
FROM student2
WHERE city = "Delhi";
# Step 2: Find their max marks using the sublist in step 1
SELECT MAX(marks)
FROM (
	SELECT * FROM student2 WHERE city = "Delhi"
) AS Delhi_Table;


# MySQL Views
CREATE VIEW view1 AS
SELECT id, name, marks FROM student2;

SELECT * FROM view1
WHERE marks > 90;

DROP VIEW view1;
