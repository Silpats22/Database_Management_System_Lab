CREATE TABLE EMPLOYEE(empid INT PRIMARY KEY,
						empname VARCHAR(30),
						salary int);
INSERT INTO employee VALUES(7,'Aswathi',75000);
INSERT INTO employee VALUES(8,'Swetha',56000);
INSERT INTO employee VALUES(9,'Kavya',33000);
INSERT INTO employee VALUES(10,'Navya',80000);


CREATE TABLE Increments (
  empid int,
  incr int,
  PRIMARY KEY (empid, incr),
  FOREIGN KEY(empid) references Employee(empid) 
);

--creating trigger 

CREATE OR REPLACE TRIGGER salary_increment
AFTER UPDATE OF salary ON employee
FOR EACH ROW
DECLARE
  diff NUMBER;
BEGIN
  diff := :NEW.salary - :OLD.salary;
  IF diff > 1000 THEN
    INSERT INTO Increments (empid, incr)
    VALUES (:NEW.empid, diff);
  END IF;
END;
/

--updating salary of an employee

update employee
set salary = 59000
where empid=8;

select * from increments;