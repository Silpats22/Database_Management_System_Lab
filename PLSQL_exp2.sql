-- Program to check whether a number is prime or not
 
DECLARE	
	NUM NUMBER;
	COUT NUMBER:=0;
	I NUMBER;
BEGIN	
	NUM:=&NUM;
	FOR I IN 1..NUM
	LOOP
		IF MOD(NUM,I) = 0 THEN
			COUT:=COUT+1;
		END IF;
	END LOOP;
	IF COUT > 2 THEN
		DBMS_OUTPUT.PUT_LINE('THE NUMBER '||NUM||' IS NOT PRIME');
	ELSE
		DBMS_OUTPUT.PUT_LINE('THE NUMBER '||NUM||' IS PRIME');
	END IF;
END;
/