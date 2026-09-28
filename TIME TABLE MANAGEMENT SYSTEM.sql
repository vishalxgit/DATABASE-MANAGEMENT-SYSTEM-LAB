/* =========================================================
   TIME TABLE MANAGEMENT SYSTEM
   ========================================================= */

SET SERVEROUTPUT ON;
SET LINESIZE 120;
SET PAGESIZE 50;


/* =========================================================
   STEP 1: REMOVE OLD TABLES
   ========================================================= */

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Timetable CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Student CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Subject CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Faculty CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Classroom CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Department CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


/* =========================================================
   STEP 2: CREATE TABLES
   ========================================================= */

CREATE TABLE Department (
    Department_ID NUMBER PRIMARY KEY,
    Department_Name VARCHAR2(100)
);


CREATE TABLE Faculty (
    Faculty_ID NUMBER PRIMARY KEY,
    Faculty_Name VARCHAR2(100),
    Department_ID NUMBER
);


CREATE TABLE Subject (
    Subject_ID NUMBER PRIMARY KEY,
    Subject_Name VARCHAR2(100),
    Department_ID NUMBER
);


CREATE TABLE Classroom (
    Room_ID NUMBER PRIMARY KEY,
    Room_Number VARCHAR2(30),
    Building VARCHAR2(100),
    Capacity NUMBER
);


CREATE TABLE Student (
    Student_ID NUMBER PRIMARY KEY,
    Student_Name VARCHAR2(100),
    Department_ID NUMBER,
    Year_Of_Study NUMBER
);


CREATE TABLE Timetable (
    Timetable_ID NUMBER PRIMARY KEY,
    Day_Name VARCHAR2(20),
    Period_Number NUMBER,
    Subject_ID NUMBER,
    Faculty_ID NUMBER,
    Room_ID NUMBER
);


/* =========================================================
   STEP 3: INSERT DEPARTMENT DATA
   ========================================================= */

INSERT INTO Department VALUES
(1, 'Computer Science');

INSERT INTO Department VALUES
(2, 'Information Technology');

INSERT INTO Department VALUES
(3, 'Electronics and Communication');

INSERT INTO Department VALUES
(4, 'Mechanical Engineering');

INSERT INTO Department VALUES
(5, 'Electrical Engineering');


/* =========================================================
   STEP 4: INSERT FACULTY DATA
   ========================================================= */

INSERT INTO Faculty VALUES
(101, 'Dr. Kumar', 1);

INSERT INTO Faculty VALUES
(102, 'Dr. Priya', 1);

INSERT INTO Faculty VALUES
(103, 'Dr. Arun', 2);

INSERT INTO Faculty VALUES
(104, 'Dr. Meena', 3);


/* =========================================================
   STEP 5: INSERT SUBJECT DATA
   ========================================================= */

INSERT INTO Subject VALUES
(201, 'DBMS', 1);

INSERT INTO Subject VALUES
(202, 'Operating Systems', 1);

INSERT INTO Subject VALUES
(203, 'Web Technology', 2);

INSERT INTO Subject VALUES
(204, 'Computer Networks', 2);

INSERT INTO Subject VALUES
(205, 'Data Structures', 1);


/* =========================================================
   STEP 6: INSERT CLASSROOM DATA
   ========================================================= */

INSERT INTO Classroom VALUES
(301, 'CSE-101', 'Main Block', 60);

INSERT INTO Classroom VALUES
(302, 'CSE-102', 'Main Block', 60);

INSERT INTO Classroom VALUES
(303, 'IT-201', 'IT Block', 50);

INSERT INTO Classroom VALUES
(304, 'ECE-301', 'ECE Block', 60);

INSERT INTO Classroom VALUES
(305, 'ME-401', 'Mechanical Block', 50);


/* =========================================================
   STEP 7: INSERT STUDENT DATA
   ========================================================= */

INSERT INTO Student VALUES
(401, 'Arun Kumar', 1, 3);

INSERT INTO Student VALUES
(402, 'Priya Ravi', 1, 3);

INSERT INTO Student VALUES
(403, 'Karthik S', 2, 2);

INSERT INTO Student VALUES
(404, 'Meena Devi', 2, 2);

INSERT INTO Student VALUES
(405, 'Rahul Kumar', 3, 3);


/* =========================================================
   STEP 8: INSERT TIMETABLE DATA
   ========================================================= */

INSERT INTO Timetable VALUES
(501, 'Monday', 1, 201, 101, 301);

INSERT INTO Timetable VALUES
(502, 'Monday', 2, 202, 102, 302);

INSERT INTO Timetable VALUES
(503, 'Tuesday', 1, 203, 103, 303);

INSERT INTO Timetable VALUES
(504, 'Tuesday', 2, 204, 103, 303);

INSERT INTO Timetable VALUES
(505, 'Wednesday', 1, 201, 101, 301);

INSERT INTO Timetable VALUES
(506, 'Wednesday', 2, 205, 102, 302);

INSERT INTO Timetable VALUES
(507, 'Thursday', 1, 202, 102, 302);

INSERT INTO Timetable VALUES
(508, 'Thursday', 2, 203, 103, 303);

INSERT INTO Timetable VALUES
(509, 'Friday', 1, 204, 103, 303);

COMMIT;


/* =========================================================
   STEP 9: DISPLAY DEPARTMENTS
   ========================================================= */

SELECT *
FROM Department;

/*
OUTPUT:

DEPARTMENT_ID  DEPARTMENT_NAME
-------------  ---------------------------------------
1              Computer Science
2              Information Technology
3              Electronics and Communication
4              Mechanical Engineering
5              Electrical Engineering
*/


/* =========================================================
   STEP 10: DISPLAY FACULTY
   ========================================================= */

SELECT *
FROM Faculty;

/*
OUTPUT:

FACULTY_ID  FACULTY_NAME   DEPARTMENT_ID
----------  -------------  -------------
101         Dr. Kumar      1
102         Dr. Priya      1
103         Dr. Arun       2
104         Dr. Meena      3
*/


/* =========================================================
   STEP 11: DISPLAY SUBJECTS
   ========================================================= */

SELECT *
FROM Subject;

/*
OUTPUT:

SUBJECT_ID  SUBJECT_NAME          DEPARTMENT_ID
----------  --------------------  -------------
201         DBMS                  1
202         Operating Systems     1
203         Web Technology        2
204         Computer Networks     2
205         Data Structures       1
*/


/* =========================================================
   STEP 12: DISPLAY CLASSROOMS
   ========================================================= */

SELECT *
FROM Classroom;

/*
OUTPUT:

ROOM_ID  ROOM_NUMBER  BUILDING             CAPACITY
-------  -----------  -------------------  --------
301      CSE-101      Main Block            60
302      CSE-102      Main Block            60
303      IT-201       IT Block              50
304      ECE-301      ECE Block             60
305      ME-401       Mechanical Block      50
*/


/* =========================================================
   STEP 13: DISPLAY STUDENTS
   ========================================================= */

SELECT *
FROM Student;

/*
OUTPUT:

STUDENT_ID  STUDENT_NAME    DEPARTMENT_ID  YEAR_OF_STUDY
----------  --------------  -------------  -------------
401         Arun Kumar      1              3
402         Priya Ravi      1              3
403         Karthik S       2              2
404         Meena Devi      2              2
405         Rahul Kumar     3              3
*/


/* =========================================================
   STEP 14: DISPLAY COMPLETE TIMETABLE
   ========================================================= */

SELECT
    t.Timetable_ID,
    t.Day_Name,
    t.Period_Number,
    s.Subject_Name,
    f.Faculty_Name,
    c.Room_Number,
    c.Building
FROM Timetable t
JOIN Subject s
ON t.Subject_ID = s.Subject_ID
JOIN Faculty f
ON t.Faculty_ID = f.Faculty_ID
JOIN Classroom c
ON t.Room_ID = c.Room_ID
ORDER BY t.Timetable_ID;

/*
OUTPUT:

TIMETABLE_ID DAY_NAME   PERIOD  SUBJECT_NAME          FACULTY       ROOM
------------ ---------- ------  --------------------  ------------  -------
501          Monday     1       DBMS                  Dr. Kumar     CSE-101
502          Monday     2       Operating Systems     Dr. Priya     CSE-102
503          Tuesday    1       Web Technology        Dr. Arun      IT-201
504          Tuesday    2       Computer Networks     Dr. Arun      IT-201
505          Wednesday  1       DBMS                  Dr. Kumar     CSE-101
506          Wednesday  2       Data Structures       Dr. Priya     CSE-102
507          Thursday   1       Operating Systems     Dr. Priya     CSE-102
508          Thursday   2       Web Technology        Dr. Arun      IT-201
509          Friday     1       Computer Networks     Dr. Arun      IT-201
*/


/* =========================================================
   STEP 15: MONDAY TIMETABLE
   ========================================================= */

SELECT
    t.Day_Name,
    t.Period_Number,
    s.Subject_Name,
    f.Faculty_Name,
    c.Room_Number
FROM Timetable t
JOIN Subject s
ON t.Subject_ID = s.Subject_ID
JOIN Faculty f
ON t.Faculty_ID = f.Faculty_ID
JOIN Classroom c
ON t.Room_ID = c.Room_ID
WHERE t.Day_Name = 'Monday'
ORDER BY t.Period_Number;

/*
OUTPUT:

DAY_NAME  PERIOD  SUBJECT_NAME       FACULTY_NAME  ROOM_NUMBER
--------  ------  -----------------  ------------  -----------
Monday    1       DBMS               Dr. Kumar     CSE-101
Monday    2       Operating Systems  Dr. Priya     CSE-102
*/


/* =========================================================
   STEP 16: SUBJECTS HANDLED BY DR. ARUN
   ========================================================= */

SELECT
    f.Faculty_Name,
    s.Subject_Name,
    t.Day_Name,
    t.Period_Number
FROM Timetable t
JOIN Faculty f
ON t.Faculty_ID = f.Faculty_ID
JOIN Subject s
ON t.Subject_ID = s.Subject_ID
WHERE f.Faculty_Name = 'Dr. Arun'
ORDER BY t.Timetable_ID;

/*
OUTPUT:

FACULTY_NAME  SUBJECT_NAME       DAY_NAME   PERIOD
------------  -----------------  ---------  ------
Dr. Arun      Web Technology     Tuesday    1
Dr. Arun      Computer Networks  Tuesday    2
Dr. Arun      Web Technology     Thursday   2
Dr. Arun      Computer Networks  Friday     1
*/


/* =========================================================
   STEP 17: NUMBER OF PERIODS FOR EACH FACULTY
   ========================================================= */

SELECT
    f.Faculty_Name,
    COUNT(t.Timetable_ID) AS Number_Of_Periods
FROM Faculty f
LEFT JOIN Timetable t
ON f.Faculty_ID = t.Faculty_ID
GROUP BY f.Faculty_Name
ORDER BY f.Faculty_Name;

/*
OUTPUT:

FACULTY_NAME  NUMBER_OF_PERIODS
------------  -----------------
Dr. Arun      4
Dr. Kumar     2
Dr. Meena     0
Dr. Priya     3
*/


/* =========================================================
   STEP 18: STUDENTS FROM COMPUTER SCIENCE
   ========================================================= */

SELECT
    Student_ID,
    Student_Name,
    Year_Of_Study
FROM Student
WHERE Department_ID = 1;

/*
OUTPUT:

STUDENT_ID  STUDENT_NAME  YEAR_OF_STUDY
----------  ------------  -------------
401         Arun Kumar    3
402         Priya Ravi    3
*/


/* =========================================================
   STEP 19: NUMBER OF STUDENTS IN EACH DEPARTMENT
   CORRECTED VERSION
   ========================================================= */

SELECT
    d.Department_Name,
    COUNT(s.Student_ID) AS Number_Of_Students
FROM Department d
LEFT JOIN Student s
ON d.Department_ID = s.Department_ID
GROUP BY d.Department_ID, d.Department_Name
ORDER BY d.Department_ID;

/*
OUTPUT:

DEPARTMENT_NAME                    NUMBER_OF_STUDENTS
---------------------------------  ------------------
Computer Science                   2
Information Technology             2
Electronics and Communication      1
Mechanical Engineering             0
Electrical Engineering             0
*/


/* =========================================================
   STEP 20: CLASSROOM USAGE
   ========================================================= */

SELECT
    c.Room_Number,
    c.Building,
    COUNT(t.Timetable_ID) AS Number_Of_Periods
FROM Classroom c
LEFT JOIN Timetable t
ON c.Room_ID = t.Room_ID
GROUP BY c.Room_Number, c.Building
ORDER BY c.Room_Number;

/*
OUTPUT:

ROOM_NUMBER  BUILDING             NUMBER_OF_PERIODS
-----------  -------------------  -----------------
CSE-101      Main Block            2
CSE-102      Main Block            3
ECE-301      ECE Block             0
IT-201       IT Block              4
ME-401       Mechanical Block      0
*/


/* =========================================================
   STEP 21: SUBJECTS WITH DEPARTMENT
   ========================================================= */

SELECT
    s.Subject_Name,
    d.Department_Name
FROM Subject s
JOIN Department d
ON s.Department_ID = d.Department_ID
ORDER BY s.Subject_ID;

/*
OUTPUT:

SUBJECT_NAME          DEPARTMENT_NAME
--------------------  ----------------------------
DBMS                  Computer Science
Operating Systems     Computer Science
Web Technology        Information Technology
Computer Networks     Information Technology
Data Structures       Computer Science
*/


/* =========================================================
   STEP 22: CLASSROOMS WITH CAPACITY GREATER THAN 50
   ========================================================= */

SELECT
    Room_Number,
    Building,
    Capacity
FROM Classroom
WHERE Capacity > 50;

/*
OUTPUT:

ROOM_NUMBER  BUILDING       CAPACITY
-----------  -------------  --------
CSE-101      Main Block     60
CSE-102      Main Block     60
ECE-301      ECE Block      60
*/


/* =========================================================
   STEP 23: UPDATE CLASSROOM CAPACITY
   ========================================================= */

UPDATE Classroom
SET Capacity = 70
WHERE Room_ID = 301;

COMMIT;


SELECT *
FROM Classroom
WHERE Room_ID = 301;

/*
OUTPUT:

ROOM_ID  ROOM_NUMBER  BUILDING       CAPACITY
-------  -----------  -------------  --------
301      CSE-101      Main Block     70
*/


/* =========================================================
   STEP 24: UPDATE FACULTY
   ========================================================= */

UPDATE Faculty
SET Faculty_Name = 'Dr. Kumar Updated'
WHERE Faculty_ID = 101;

COMMIT;


SELECT *
FROM Faculty
WHERE Faculty_ID = 101;

/*
OUTPUT:

FACULTY_ID  FACULTY_NAME        DEPARTMENT_ID
----------  -------------------  -------------
101         Dr. Kumar Updated     1
*/


/* =========================================================
   STEP 25: DELETE A STUDENT
   ========================================================= */

DELETE FROM Student
WHERE Student_ID = 405;

COMMIT;


SELECT *
FROM Student;

/*
OUTPUT:

STUDENT_ID  STUDENT_NAME  DEPARTMENT_ID  YEAR_OF_STUDY
----------  ------------  -------------  -------------
401         Arun Kumar    1              3
402         Priya Ravi    1              3
403         Karthik S     2              2
404         Meena Devi    2              2
*/


/* =========================================================
   FINAL VERIFICATION
   ========================================================= */

SELECT * FROM Department;

SELECT * FROM Faculty;

SELECT * FROM Subject;

SELECT * FROM Classroom;

SELECT * FROM Student;

SELECT * FROM Timetable;


/* =========================================================
   END OF TIME TABLE MANAGEMENT SYSTEM
   ========================================================= */
