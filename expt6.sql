CREATE DATABASE expt6;
USE expt6;
CREATE TABLE Branch(branch_id VARCHAR(10) PRIMARY KEY,
					branch_name VARCHAR(50),
					branch_city VARCHAR(50));
CREATE TABLE Customer(customer_id VARCHAR(10) PRIMARY KEY,
						customer_name VARCHAR(50),
						customer_city VARCHAR(50));
CREATE TABLE Savings(c_id VARCHAR(10),
						b_id VARCHAR(10),
						saving_accno VARCHAR(40),
						balance INT,
						FOREIGN KEY(c_id) REFERENCES Customer(customer_id),
						FOREIGN KEY(b_id) REFERENCES Branch(branch_id),
						PRIMARY KEY(c_id,b_id));
CREATE TABLE Loan(cust_id VARCHAR(10),
					br_id VARCHAR(10),
					loan_accno VARCHAR(10),
					balance_amt INT,
					FOREIGN KEY(cust_id) REFERENCES Customer(customer_id),
					FOREIGN KEY(br_id) REFERENCES Branch(branch_id),
					PRIMARY KEY(cust_id,br_id));
insert into Branch values
(401,"Thiruvananthapuram","Thiruvananthapuram"),
(402,"Kottayam","Kottayam"),
(403,"Ernakulam","Kochi"),
(404,"Kozhikode","Kozhikode");

insert into Customer values
(6001,"Ananthakrishnan","Thiruvananthapuram"),
(6002,"Irfan","Thiruvananthapuram"),
(6003,"Suneeth","Thiruvananthapuram"),
(6004,"Sreejith","Kottayam"),
(6005,"Jafar","Kazhakoottam"),
(6006,"Radika","Pampady"),
(6007,"Jameela","Kanjikuzhi"),
(6008,"Bindu","Kottayam"),
(6009,"Purushothaman","Kollam"),
(6010,"Vincy","Kottayam"),
(6011,"Abdul Rahman","Thrissur"),
(6012,"Vishwanathan","Ernakulam"),
(6013,"Marykutty","Mattancheri"),
(6014,"Hajara","Ernakulam"),
(6015,"Revathy","Kozhikode"),
(6016,"Hameed","Perambra"),
(6017,"Suchithra","Kozhikode"),
(6018,"Saneesh","North Paravoor"),
(6019,"Gokul Das","Kozhikode"),
(6020,"Abraham","Kappad");

insert into Savings values
(6001,401,6400101,15000),
(6002,401,6400102,200000),
(6005,401,6400105,30000),
(6007,401,6400107,70000),
(6004,402,6400204,400000),
(6006,402,6400206,100000),
(6007,402,6400207,40000),
(6008,402,6400208,74000),
(6010,402,6400210,128507),
(6011,403,6400311,700000),
(6001,403,6400301,200000),
(6012,403,6400312,500000),
(6013,403,6400313,250000),
(6015,404,6400415,100000),
(6016,404,6400416,90756);

insert into Loan values
(6005,401,4600105,100000),
(6003,401,4600103,200000),
(6009,401,4600109,150000),
(6019,401,4600119,100000),
(6011,403,4600311,1000000),
(6013,403,4600313,500000),
(6014,403,4600314,300000),
(6018,403,4600318,300000),
(6006,403,4600306,100000),
(6009,403,4600309,200000),
(6014,404,4600414,100000),
(6016,404,4600416,150000),
(6017,404,4600417,200000),
(6019,404,4600419,300000),
(6020,404,4600419,400000),
(6008,404,4600408,100000);
\! ECHO BRANCH
SELECT *
FROM Branch;

\! ECHO CUSTOMER
SELECT *
FROM Customer;

\! ECHO SAVINGS
SELECT * 
FROM Savings;

\! ECHO LOAN
SELECT * 
FROM Loan;

\! ECHO List out the details of the customers who live in the same city as they have savings or loan account 

CREATE VIEW TEMP AS (SELECT * FROM customer,Savings WHERE customer_id=c_id ) UNION (SELECT * FROM customer,Loan WHERE customer_id=cust_id ) ;
SELECT * FROM TEMP;

SELECT T1.*
FROM TEMP AS T1,TEMP AS T2
WHERE T1.customer_city=T2.customer_city AND T1.customer_id!=T2.customer_id
GROUP BY customer_city;

\! ECHO List out the customers who have an account in a given branch-city 

SELECT  customer_id,customer_name
FROM Branch,Customer,Savings
WHERE branch_id=b_id AND customer_id=c_id AND branch_city="Thiruvananthapuram"
UNION 
SELECT  customer_id,customer_name
FROM Branch,Customer,Loan
WHERE branch_id=br_id AND customer_id=cust_id AND branch_city="Thiruvananthapuram";


\! ECHO List out details of the customer who have neither a saving account but a loan

SELECT DISTINCT customer_id,customer_name,customer_city
FROM customer,Savings,Loan
WHERE customer_id!=c_id AND customer_id=cust_id
ORDER BY customer_id;

\! ECHO List out details of the customer who have neither a loan but has a saving account

SELECT DISTINCT customer_id,customer_name,customer_city
FROM customer,Savings,Loan
WHERE customer_id=c_id AND customer_id!=cust_id
ORDER BY customer_id;

\! ECHO List out details of the customer having both loan and saving

SELECT DISTINCT customer_id,customer_name,customer_city
FROM customer,Savings,Loan
WHERE customer_id=c_id AND customer_id=cust_id
ORDER BY customer_id;

\! ECHO For each branch produce a list of the total number of customers

CREATE VIEW TEMP5 AS (SELECT * FROM customer,branch,Savings WHERE customer_id=c_id AND branch_id=b_id ) UNION (SELECT * FROM customer,branch,Loan WHERE customer_id=cust_id AND branch_id=br_id ) ;

CREATE VIEW TEMP6 AS SELECT branch_id,branch_name,COUNT(*) AS Total_no_of_cutomers FROM TEMP5 GROUP BY branch_id;

SELECT * FROM TEMP6;

\! ECHO For each branch produce a list of the total number of customers with loan only

CREATE VIEW TEMP7 AS SELECT * FROM customer,branch,Loan WHERE customer_id=cust_id AND branch_id=br_id;

CREATE VIEW TEMP8 AS SELECT branch_id,branch_name,COUNT(*) AS Total_no_of_customers_with_loan FROM TEMP7 GROUP BY branch_id;

SELECT * FROM TEMP8;

\! ECHO For each branch produce a list of the total number of customers with savings only

CREATE VIEW TEMP9 AS SELECT * FROM customer,branch,Savings WHERE customer_id=c_id AND branch_id=b_id;

CREATE VIEW TEMP10 AS SELECT branch_id,branch_name,COUNT(*) AS Total_no_of_customers_with_savings FROM TEMP9 GROUP BY branch_id;

SELECT * FROM TEMP10;

\! ECHO For each branch produce a list of the total number of customers with both loan and savings 

CREATE VIEW TEMP11 AS SELECT * FROM customer,branch,Savings,Loan WHERE customer_id=c_id AND branch_id=b_id AND customer_id=cust_id AND branch_id=br_id ;

CREATE VIEW TEMP12 AS SELECT branch_id,branch_name,COUNT(*) AS Total_no_of_cutomers_with_both_loan_and_savings FROM TEMP11 GROUP BY branch_id;

SELECT * FROM TEMP12;

\! ECHO Find the details of the branch which has issued max amount of loan 

CREATE VIEW TEMP3 AS SELECT branch_id,branch_name,SUM(balance_amt) AS Total_loan_amount FROM branch,Loan WHERE branch_id=br_id ;
SELECT * FROM TEMP3;

SELECT * 
FROM TEMP3
WHERE Total_loan_amount IN (SELECT MAX(Total_loan_amount)
								FROM TEMP3);
								
\! ECHO Find the details of the branch which has not yet issued any loan at all

CREATE VIEW TEMP4 AS SELECT * FROM branch JOIN Loan ON branch_id=br_id;
SELECT * FROM TEMP4;

SELECT 	*
FROM branch
WHERE branch_id NOT IN( SELECT DISTINCT branch_id
							FROM TEMP4);
DROP VIEW TEMP;	
DROP VIEW TEMP5;
DROP VIEW TEMP6;
DROP VIEW TEMP7;
DROP VIEW TEMP8;
DROP VIEW TEMP9;
DROP VIEW TEMP10;
DROP VIEW TEMP11;
DROP VIEW TEMP12;		
DROP VIEW TEMP3;
DROP VIEW TEMP4;
DROP TABLE Loan;
DROP TABLE Savings;
DROP TABLE Customer;
DROP TABLE Branch;