CREATE DATABASE expt4;
USE expt4;
CREATE TABLE student(roll_no INT PRIMARY KEY,
name VARCHAR(30),
category VARCHAR(30),
district VARCHAR(30),
state VARCHAR(30));
CREATE TABLE student_rank(roll_number INT,
 mark INT,
 s_rank INT,
 FOREIGN KEY(roll_number) REFERENCES student(roll_no));
INSERT INTO student VALUES('1','ABHAYA','GENERAL','THRISSUR','KERALA');
INSERT INTO student VALUES('2','ANANDHU','GENERAL','KOLLAM','KERALA');
INSERT INTO student VALUES('3','AMAL','OBC','KOTTAYAM','KERALA');
INSERT INTO student VALUES('4','AVANI','SC','THRISSUR','KERALA');
INSERT INTO student VALUES('5','EVIN','GENERAL','KOZHIKODE','KERALA');
INSERT INTO student VALUES('6','HIRAN','ST','WAYANAD','KERALA');
INSERT INTO student VALUES('7','JERIN','GENERAL','PALAKKAD','KERALA');
INSERT INTO student VALUES('8','LAKSHMI','GENERAL','THIRUVANANTHAPURAM','KERALA');
INSERT INTO student VALUES('9','MANU','SC','IDUKKI','KERALA');
INSERT INTO student VALUES('10','SIDHARTH','GENERAL','KOTTAYAM','KERALA');
INSERT INTO student VALUES('11','SYAM','ST','KOTTAYAM','KERALA');
INSERT INTO student_rank VALUES('1','450','1201');
INSERT INTO student_rank VALUES('2','489','1121');
INSERT INTO student_rank VALUES('3','400','3879');
INSERT INTO student_rank VALUES('4','300','4023');
INSERT INTO student_rank VALUES('5','450','1201');
INSERT INTO student_rank VALUES('6','450','1500');
INSERT INTO student_rank VALUES('7','360','3690');
INSERT INTO student_rank VALUES('8','437','1561');
INSERT INTO student_rank VALUES('9','398','2001');
INSERT INTO student_rank VALUES('10','453','1199');
INSERT INTO student_rank VALUES('11','453','1023');
\! ECHO STUDENT
SELECT *
FROM student;

\! ECHO STUDENT_RANK
SELECT *
FROM student_rank;

CREATE VIEW TEMP AS
SELECT * FROM student JOIN student_rank ON roll_no=roll_number;

SELECT *
FROM TEMP;

\! ECHO List the details of student with same category and rank 

SELECT T1.*
FROM TEMP AS T1,TEMP AS T2
WHERE T1.category=T2.category AND T1.s_rank=T2.s_rank AND T1.roll_no!=T2.roll_no
ORDER BY T1.category,T1.s_rank;

\! ECHO List the details of student who secured the highest rank for each category for each state

SELECT category,MAX(s_rank) AS Highest_rank
FROM TEMP AS s1
WHERE roll_no=roll_number
GROUP BY category,state;

\! ECHO List the names of student having either marks same but different ranks or marks different but rank same together with the status

SELECT S1.*
FROM TEMP AS S1,TEMP AS S2
WHERE S1.mark=S2.mark AND S1.s_rank!=S2.s_rank
UNION
SELECT S3.*
FROM TEMP AS S3,TEMP AS S4
WHERE S3.mark!=S4.mark AND S3.s_rank=S4.s_rank;

\! ECHO Find the category with the highest academic performance and the one with the least academic performance

CREATE VIEW TEMP1 AS SELECT *,AVG(mark) AS Average FROM TEMP GROUP BY category;

SELECT * FROM TEMP1;

SELECT category
FROM TEMP1
WHERE Average = (SELECT MAX(Average)
					FROM TEMP1);

SELECT category
FROM TEMP1
WHERE Average = (SELECT MIN(Average)
					FROM TEMP1);

\! ECHO Find the category whose academic performance is below the average academic performance

SELECT AVG(mark) AS Average_mark
FROM TEMP;

SELECT category,AVG(mark) AS average_of_marks
FROM TEMP
GROUP BY category;

SELECT category
FROM TEMP
GROUP BY category
HAVING AVG(mark)<(SELECT AVG(mark)
 FROM TEMP);

DROP VIEW TEMP;
DROP TABLE student_rank;
DROP TABLE student;
DROP DATABASE expt4;