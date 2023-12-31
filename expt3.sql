CREATE DATABASE expt3;
USE expt3;
CREATE TABLE STUDENT(roll_no int PRIMARY KEY,
     name varchar(50),
     date_of_birth date);
CREATE TABLE COURSE(course_id varchar(10) PRIMARY KEY,
    course_name varchar(50),
    fee int,
    duration varchar(10));
CREATE TABLE STUDY(roll_number int,
   CID varchar(10),
   FOREIGN KEY(roll_number) REFERENCES STUDENT(roll_no),
   FOREIGN KEY(CID) REFERENCES COURSE(course_id),
   PRIMARY KEY(roll_number,CID));
INSERT INTO STUDENT VALUES('1','ABHAYA','2003-02-07');
INSERT INTO STUDENT VALUES('2','ARUN','2002-10-16');
INSERT INTO STUDENT VALUES('3','BEN','2002-07-02');
INSERT INTO STUDENT VALUES('4','EDWIN','2001-06-23');
INSERT INTO STUDENT VALUES('5','EVIN','2000-11-18');
INSERT INTO STUDENT VALUES('6','KIRAN','2000-05-25');
INSERT INTO STUDENT VALUES('7','KRISHNA','2004-02-23');
INSERT INTO STUDENT VALUES('8','MANU','1998-04-17');
INSERT INTO STUDENT VALUES('9','PREM','2003-02-07');
INSERT INTO STUDENT VALUES('10','RAHUL','1998-02-07');
INSERT INTO COURSE VALUES('6754','MTECH CE','100000','2 YEARS');
INSERT INTO COURSE VALUES('9544','MTECH EEE','100000','2 YEARS');
INSERT INTO COURSE VALUES('8899','MTECH CSE','100000','2 YEARS');
INSERT INTO COURSE VALUES('1899','MTECH ECE','100000','2 YEARS');
INSERT INTO COURSE VALUES('7679','MTECH ME','100000','2 YEARS');
INSERT INTO COURSE VALUES('1122','BTECH ME','50000','4 YEARS');
INSERT INTO COURSE VALUES('3451','BTECH ECE','50000','4 YEARS');
INSERT INTO COURSE VALUES('8976','BTECH CSE','50000','4 YEARS');
INSERT INTO COURSE VALUES('3267','BTECH CE','50000','4 YEARS');
INSERT INTO COURSE VALUES('7632','BTECH EEE','50000','4 YEARS');
INSERT INTO COURSE VALUES('4628','MCA','40000','2 YEARS');
INSERT INTO STUDY VALUES('1','3451');
INSERT INTO STUDY VALUES('1','8976');
INSERT INTO STUDY VALUES('1','3267');
INSERT INTO STUDY VALUES('1','7632');
INSERT INTO STUDY VALUES('1','4628');
INSERT INTO STUDY VALUES('1','6754');
INSERT INTO STUDY VALUES('1','9544');
INSERT INTO STUDY VALUES('1','1122');
INSERT INTO STUDY VALUES('1','7679');
INSERT INTO STUDY VALUES('1','1899');
INSERT INTO STUDY VALUES('1','8899');
INSERT INTO STUDY VALUES('2','3267');
INSERT INTO STUDY VALUES('3','3451');
INSERT INTO STUDY VALUES('4','3267');
INSERT INTO STUDY VALUES('5','9544');
INSERT INTO STUDY VALUES('6','6754');
INSERT INTO STUDY VALUES('6','8899');
INSERT INTO STUDY VALUES('7','1122');
INSERT INTO STUDY VALUES('8','6754');
INSERT INTO STUDY VALUES('8','7679');
INSERT INTO STUDY VALUES('9','4628');
INSERT INTO STUDY VALUES('5','6754');
INSERT INTO STUDY VALUES('10','4628');
\! ECHO STUDENT
SELECT *
FROM STUDENT;

\! ECHO COURSE
SELECT *
FROM COURSE;

\! ECHO STUDY
SELECT *
FROM STUDY;

\! ECHO List the names of all students who are greater than 18 years of age and have opted B.Tech Course
 
SELECT DISTINCT name
FROM STUDY,STUDENT,COURSE
WHERE roll_no=roll_number AND course_id=CID AND course_name LIKE 'BTECH%' AND DATEDIFF(CURRENT_DATE,date_of_birth)>MONTH(216);

\! ECHO List the details of those courses whose fee is greater than that of B.Tech Course 

SELECT *
FROM COURSE
WHERE fee > (SELECT fee 
			FROM COURSE		
			WHERE course_name='BTECH CSE');
			
\! ECHO List the details of the students who have opted more than 2 courses 

SELECT name,roll_no,date_of_birth
FROM STUDY,STUDENT
WHERE roll_no=roll_number
GROUP BY roll_number
HAVING COUNT(*) >= 2;

\! ECHO List the details (name, fee and duration) of the course which have been opted by maximum number of students and those of the course which is opted by the least number of students 

CREATE VIEW TEMP AS 
SELECT * FROM COURSE JOIN STUDY ON course_id=CID;
SELECT * FROM TEMP;

CREATE VIEW TEMP1 AS SELECT course_id,course_name,fee,duration,COUNT(*) AS No_of_students FROM TEMP GROUP BY course_id;

SELECT * FROM TEMP1;

SELECT *
FROM TEMP1
WHERE No_of_students = (SELECT MAX(No_of_students)
						FROM TEMP1);
						
SELECT *
FROM TEMP1
WHERE No_of_students = (SELECT MIN(No_of_students)
						FROM TEMP1);
						
\! ECHO List the details of the student(s) who have opted every course 

CREATE VIEW TEMP2 AS SELECT roll_no,name,date_of_birth,COUNT(*) AS NO_of_courses FROM STUDENT JOIN STUDY ON roll_no=roll_number GROUP BY roll_no;
SELECT * FROM TEMP2;

SELECT roll_no,name,date_of_birth
FROM TEMP2
WHERE No_of_courses = (SELECT COUNT(*)
						FROM COURSE);
						
DROP TABLE STUDY;
DROP TABLE STUDENT;
DROP TABLE COURSE;
DROP DATABASE expt3;