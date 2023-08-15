CREATE DATABASE expt1;
USE expt1;
CREATE TABLE COLLEGE(
	college_code varchar(20) PRIMARY KEY,
	college_name varchar(40),
	address varchar(30));
CREATE TABLE FACULTY(
	c_code varchar(20),
	faculty_code varchar(20),
	faculty_name varchar(15),
	qualification varchar(15),
	experience int,
	department varchar(20),
	f_address varchar(30),
	FOREIGN KEY(c_code) REFERENCES COLLEGE(college_code));
INSERT INTO COLLEGE VALUES('KTE','RIT','PAMPADY KOTTAYAM');
INSERT INTO COLLEGE VALUES('IDK','GEC','PAINAVU IDUKKI');
INSERT INTO COLLEGE VALUES('SNT','SAINGITS','PALA KOTTAYAM');
INSERT INTO COLLEGE VALUES('TCR','GOVERNMENT ENGINEERING COLLEGE,THRISSUR','RAMAVARMAPURAM THRISSUR');
INSERT INTO COLLEGE VALUES('VAS','VIDHYA ENGINEERING COLLEGE','THRISSUR');
INSERT INTO COLLEGE VALUES('CET','COLLEGE OF ENGINEERING','THIRUVANANTHAPURAM');
INSERT INTO COLLEGE VALUES('TKM','TKM COLLEGE OF ENGINEERING','KOLLAM');
INSERT INTO FACULTY VALUES('KTE','TC657','RAMAKRISHNAN','M-TECH','5','EEE','KOTTAYAM');
INSERT INTO FACULTY VALUES('TCR','GH456','SREELATHA','B-TECH','12','CE','KOCHI ERNAKULAM');
INSERT INTO FACULTY VALUES('TKM','JK678','AJAY','M-TECH','10','ECE','CHEROOR THRISSUR');
INSERT INTO FACULTY VALUES('TCR','YU598','BINDHU','PHD','16','CSE','ARPOOKARA KOTTAYAM');
INSERT INTO FACULTY VALUES('KTE','NH654','SHANURAJ','B-TECH','18','EEE','KOOTHATTUKULAM ERNAKULAM');
INSERT INTO FACULTY VALUES('VAS','KL690','SHINOJ','M-TECH','11','ME','MAVELIKKARA ALAPPUZHA');
INSERT INTO FACULTY VALUES('TKM','GY189','SANDRA','PHD','20','CSE','THIRUR MALAPPURAM');
INSERT INTO FACULTY VALUES('CET','UG547','MADHUPRIYA','B-TECH','17','EEE','SULTHANBATHERY WAYANAD');
INSERT INTO FACULTY VALUES('TCR','FT548','MANU','M-TECH','8','CSE','KOTTAYAM');
INSERT INTO FACULTY VALUES('KTE','KH487','FATHIMA','M-TECH','13','CE','KODANNUR THRISSUR');

SELECT *
FROM COLLEGE;

SELECT *
FROM FACULTY;

/* 
 List all faculty members of a specified college whose experience is greater than or equal to 10 years
*/

SELECT * 
FROM FACULTY 
WHERE c_code='KTE' AND experience>=10;

/*
 List all Faculty Members of a specified college who have at least 10 years of experience but not having M.Tech Degree
*/

SELECT * 
FROM FACULTY 
WHERE c_code='TCR' AND experience>=10 AND qualification='B-TECH';

/*
List out the Faculty of a specified college department wise in non decreasing order of their seniority
*/

SELECT * 
FROM FACULTY
WHERE c_code='KTE' 
ORDER BY experience ASC,department ASC;

/*
 List out the Names of the Colleges having more than a specified number of faculty members
*/

SELECT college_name
FROM COLLEGE,FACULTY
WHERE college_code=c_code 
GROUP BY c_code 
HAVING COUNT(*)>2;

/*List out the names of the colleges having the least number of faculties and the largest number of
faculty*/

CREATE VIEW TEMP AS SELECT c_code,college_name,COUNT(*) AS NO_OF_FACULTIES FROM COLLEGE JOIN FACULTY ON college_code=c_code GROUP BY c_code;
SELECT * FROM TEMP;

\! ECHO colleges having least number of faculties
SELECT c_code,college_name
FROM TEMP
WHERE NO_OF_FACULTIES = (SELECT MIN(NO_OF_FACULTIES)
					FROM TEMP);

\! ECHO colleges having largest number of faculties
SELECT c_code,college_name
FROM TEMP
WHERE NO_OF_FACULTIES = (SELECT MAX(NO_OF_FACULTIES)
					FROM TEMP);

DROP TABLE FACULTY;
DROP TABLE COLLEGE;
DROP DATABASE expt1;