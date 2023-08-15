-- Program to find factorial of a number
 
DECLARE	
	NUM NUMBER;
	RES NUMBER:=1;
	I NUMBER;
BEGIN	
	NUM:=&NUM;
	FOR I IN 1..NUM
	LOOP
		RES:= RES*I;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('THE FACTORIAL OF NUMBER IS '||RES||'');
END;
/