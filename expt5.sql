CREATE DATABASE expt5;
USE expt5;
CREATE TABLE book(accession_no INT PRIMARY KEY,
 title VARCHAR(50),
 publisher VARCHAR(30),
 year INT,
 date_of_purchase DATE,
 status VARCHAR(30));
CREATE TABLE members(member_id INT PRIMARY KEY,
            name VARCHAR(50),
    number_of_books_issued INT,
    max_limit INT);
CREATE TABLE books_issue(accession_no INT,
                 member_id INT,
 date_of_issue DATE,
 FOREIGN KEY(accession_no) REFERENCES book(accession_no),
 FOREIGN KEY(member_id) REFERENCES members(member_id),
 PRIMARY KEY(accession_no,member_id));
 INSERT INTO book VALUES('161334','ANDROID IN ACTION','DREAMTECH PRESS',2000,'2003-10-13','ISSUED');
INSERT INTO book VALUES('157506','ANDROID IN ACTION','DREAMTECH PRESS',1998,'2003-10-13','ISSUED');
INSERT INTO book VALUES('814990','ZEN OF CODE OPTIMIZATION','GALGOTIA PUBLICATIONS',2000,'2005-05-25','PRESENT IN THE LIBRARY');
INSERT INTO book VALUES('127105','LINUX SYSTEM ADMINISTRATION','SHROFF PUBLISHERS',2005,'2015-12-09','ISSUED');
INSERT INTO book VALUES('118531','DATA MINING','ADDISON WESLEY',2008,'2018-10-29','CANNOT BE ISSUED');
INSERT INTO book VALUES('137575','DATABASE MANAGEMENT SYSTEM','PRATEEKSHA PUBLICATIONS',2007,'2010-09-18','REFERENCE');
INSERT INTO book VALUES('117583','INTRODUCTION TO HTML','KITAB MAHAL',1999,'2004-10-23','ISSUED');
INSERT INTO book VALUES('811702','PRIMER ON SQL','GALGOTIA PUBLICATIONS',2001,'2006-07-15','PRESENT IN THE LIBRARY');
INSERT INTO book VALUES('782314','PRINCIPLES OF COMPILER DESIGN','NAROSA PUBLISHING HOUSE',1990,'2002-04-23','ISSUED');
INSERT INTO book VALUES("588322","MIDNIGHT CHILDREN","SALMAN RUSHDIE","1947","2002-05-18","CANNOT BE ISSUED");
INSERT INTO book VALUES("789123","THE MAGIC MOUNTAIN","THOMAS MANN","1998","2003-05-28","ISSUED");
INSERT INTO book VALUES("178924","GREAT EXPECTATIONS","CHARLES DICKENS","2005","2008-01-28","ISSUED");
INSERT INTO book VALUES("156625","LEAVES OF GRASS","WALT WHITMAN","2008","2011-11-26","REFERENCE");
INSERT INTO book VALUES("987126","TRISTRAM SHANDY","LAURENCE STRENE","1996","2002-01-08","ISSUED");
INSERT INTO book VALUES("156127","DAVID COPPERFIELD","CHARLES DICKENS","1999","2003-02-07","CANNOT BE ISSUED");
INSERT INTO book VALUES("190528","THE AENEID","VIRGIL","2000","2001-12-10","ISSUED");
INSERT INTO book VALUES("904529","JANE EYRE","CHARLOTTE BRONTE","2010","2011-04-05","PRESENT IN THE LIBRARY");
INSERT INTO book VALUES("187830","THE STRANGER","ALBERT CAMUS","2021","2022-04-12","ISSUED");
INSERT INTO book VALUES("135671","BELOVED","TONI MORRISON","2004","2021-07-22","CANNOT BE ISSUED");
INSERT INTO book VALUES("138812","MIDDLEMARCH","GEORGE ELIOT","2002","2004-10-21","ISSUED");
INSERT INTO members VALUES('9876','ABHAYA','1','3');
INSERT INTO members VALUES('5678','AVANI','3','3');
INSERT INTO members VALUES('8976','BEN','0','3');
INSERT INTO members VALUES('8710','SWATHI','0','3');
INSERT INTO members VALUES('6754','NIRMAL','2','3');
INSERT INTO members VALUES('8722','ALANYA','1','3');
INSERT INTO members VALUES('9341','VISHNUPRIYA','1','3');
INSERT INTO members VALUES('6722','ARYA','1','3');
INSERT INTO members VALUES('7852','NAJI','1','3');
INSERT INTO members VALUES('8911','SREEJA','1','3');
INSERT INTO books_issue VALUES('161334','9876','2022-11-10');
INSERT INTO books_issue VALUES('157506','5678','2022-10-12');
INSERT INTO books_issue VALUES('127105','5678','2022-10-12');
INSERT INTO books_issue VALUES('117583','6754','2022-10-15');
INSERT INTO books_issue VALUES('782314','5678','2022-10-12');
INSERT INTO books_issue VALUES('789123','6754','2022-09-17');
INSERT INTO books_issue VALUES('178924','9341','2022-11-12');
INSERT INTO books_issue VALUES('987126','6722','2022-11-23');
INSERT INTO books_issue VALUES('190528','8722','2022-10-25');
INSERT INTO books_issue VALUES('187830','7852','2022-11-22');
INSERT INTO books_issue VALUES('138812','8911','2022-10-22');

\! ECHO BOOK
SELECT *
FROM book;

\! ECHO MEMBERS
SELECT *
FROM members;

\! ECHO  BOOK_ISSUE
SELECT *
FROM books_issue;

\! ECHO  List all those books which are due from the students. A Book is considered as Due if it has been issued 15 days back and not yet returned

SELECT *
FROM book,books_issue
WHERE book.accession_no=books_issue.accession_no AND DATEDIFF('2022-11-18',date_of_issue)>15;

\! ECHO List all members who cannot be issued any more books

SELECT name,number_of_books_issued
FROM members
WHERE number_of_books_issued=max_limit;

\! ECHO List the details of the book which is taken by the maximum number of members and the book which is taken by the least number of members

CREATE VIEW TEMP AS
SELECT title,publisher,member_id FROM book JOIN books_issue ON book.accession_no=books_issue.accession_no;

SELECT *
FROM TEMP;

CREATE VIEW TEMP1 AS SELECT title,publisher,COUNT(*) AS NO_OF_COPIES_ISSUED
FROM TEMP
GROUP BY title,publisher;

SELECT *
FROM TEMP1;

SELECT title,publisher
FROM TEMP1
WHERE NO_OF_COPIES_ISSUED IN(SELECT MAX(NO_OF_COPIES_ISSUED)
							  FROM TEMP1);

SELECT title,publisher
FROM TEMP1
WHERE NO_OF_COPIES_ISSUED IN (SELECT MIN(NO_OF_COPIES_ISSUED)
							  FROM TEMP1);

DROP TABLE books_issue;
DROP TABLE members;
DROP TABLE book;
DROP DATABASE expt5;