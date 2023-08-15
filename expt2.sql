CREATE DATABASE expt2;
USE expt2;
CREATE TABLE BOOK(accession_no varchar(10),
				  title varchar(50),
				  publisher varchar(50),
				  author varchar(50),
				  date_of_purchase Date,
				  date_of_publishing Date,
				  status varchar(30));
INSERT INTO BOOK VALUES('5612','SYSTEM SOFTWARE','PEARSON','LELAND L BECK','2022-02-12','2003-11-10','ISSUED');
INSERT INTO BOOK VALUES('9234','DISCRETE MATHEMATICS','PEARSON','BABU RAM','2022-06-13','2003-03-24','REFERENCE');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','ISSUED');
INSERT INTO BOOK VALUES('5612','SYSTEM SOFTWARE','EXCEL','LELAND L BECK','2022-06-12','2013-06-09','REFERENCE');
INSERT INTO BOOK VALUES('5612','SYSTEM SOFTWARE','PEARSON','LELAND L BECK','2022-02-12','2013-11-10','CANNOT BE ISSUED');
INSERT INTO BOOK VALUES('9234','DISCRETE MATHEMATICS','PEARSON','BABU RAM','2022-06-13','2003-03-24','CANNOT BE ISSUED');
INSERT INTO BOOK VALUES('9234','DISCRETE MATHEMATICS','PEARSON','BABU RAM','2022-06-13','2003-03-24','PRESENT IN THE LIBRARY');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','CANNOT ISSUED');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','ISSUED');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','REFERENCE');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','ISSUED');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','PRESENT IN THE LIBRARY');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','ISSUED');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','CANNOT BE ISSUED');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','ISSUED');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','REFERENCE');
INSERT INTO BOOK VALUES('7786','MICROPROCESSOR ARCHITECTURE','PENRAM','GAONKAR','2021-02-15','2020-03-19','ISSUED');
\! ECHO BOOK
SELECT * FROM BOOK;
/* List out the total number of copies of each book in the library*/

SELECT title,COUNT(*) AS Total_count
FROM   BOOK
GROUP BY title,author,publisher;

/*List out the total number of reference copies for each book in the Library*/

SELECT title,COUNT(*) AS Number_of_books
FROM BOOK
WHERE status='REFERENCE'
GROUP BY title,author,publisher;

/*For each book in the Library obtain a count of the total number of issued copies, number copies existing at present in the library and the number of reference copies*/

SELECT title,status,COUNT(*) AS Total_count
FROM book
GROUP BY status,title;

/*List out the details of various books of each publisher with status of the books set to “cannot be issued”*/

SELECT title,publisher,COUNT(*) AS count
FROM BOOK
WHERE status='CANNOT BE ISSUED'
GROUP BY publisher;

/*List out the details of the books which are new arrivals.The books which are purchased during the last 6 months are categorized as new arrivals*/

SELECT *
FROM BOOK
WHERE DATEDIFF(CURRENT_DATE,date_of_purchase)<=183;

/*List out the details of each famous book . Each Famous book should be purchased within 1 year of its date-of –publishing and the number of total copies is more than 10*/

SELECT *
FROM book
WHERE DATEDIFF(date_of_purchase,date_of_publishing)<=365
GROUP BY title,author,publisher
HAVING COUNT(*)>10;

DROP TABLE BOOK;
DROP DATABASE expt2;
				  

