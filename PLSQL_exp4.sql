-- PL/SQL code to check whether a number is perfect or not
 
DECLARE	
	NUM NUMBER;
	TOTAL NUMBER:=0;
	I NUMBER;
BEGIN	
	NUM:=&NUM;
	FOR I IN 1..NUM/2
	LOOP
		IF MOD(NUM,I) = 0 THEN
			TOTAL:=TOTAL+I;
		END IF;
	END LOOP;
	IF TOTAL = NUM THEN
		DBMS_OUTPUT.PUT_LINE('THE NUMBER '||NUM||' IS A PERFECT NUMBER');
	ELSE IF TOTAL > NUM THEN
		DBMS_OUTPUT.PUT_LINE('THE NUMBER '||NUM||' IS A ABUNDANT NUMBER');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('THE NUMBER '||NUM||' IS A DEFICIENT NUMBER');
		END IF;
	END IF;
END;
/