--Write a PL/SQL code to check whether a number is even or odd.

DECLARE 
	NUM NUMBER;
	CHEC NUMBER;
BEGIN
	NUM:=&NUM;
	CHEC:=MOD(NUM,2);
	IF CHEC =0 THEN
		DBMS_OUTPUT.PUT_LINE('THE NUMBER'||NUM||' IS EVEN');
	ELSE
		DBMS_OUTPUT.PUT_LINE('THE NUMBER '||NUM||' IS ODD');
	END IF;
END;
/
		
	