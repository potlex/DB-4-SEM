set serveroutput on 
SELECT * FROM USER_OBJECTS;
--1
BEGIN 
NULL;
END;
--2
BEGIN
DBMS_OUTPUT.PUT_LINE('Hello world!');
END;
--3
SELECT KEYWORD FROM V_$RESERVED_WORDS
WHERE LENGTH = 1 AND KEYWORD != 'A'
/
--4 
SELECT KEYWORD FROM V_$RESERVED_WORDS
WHERE LENGTH > 1 AND KEYWORD != 'A' ORDER BY KEYWORD
/
--5
DECLARE
N1 NUMBER(3) := 25;
N2 NUMBER(3) := 5;
DIV NUMBER(10,2);
NF1 NUMBER(10,2) := 5.53;
NO2 NUMBER(4,-5) := 5.54535;
NE1 NUMBER(32,10) := 12345E-10;
DT DATE := '05-05-2004';
CH CHAR(20) := 'Hello';
VC VARCHAR2(20) := 'Hello';
BL BOOLEAN := TRUE;
BEGIN 
DIV := MOD(N1, N2);
DBMS_OUTPUT.PUT_LINE('N1 = '||N1);
DBMS_OUTPUT.PUT_LINE('N2 = '||N2);
DBMS_OUTPUT.PUT_LINE('DIV = '||DIV);
DBMS_OUTPUT.PUT_LINE('NF1 = '||NF1);
DBMS_OUTPUT.PUT_LINE('NO2 = '||NO2);
DBMS_OUTPUT.PUT_LINE('NE1 = '||NE1);
DBMS_OUTPUT.PUT_LINE('DT = '||DT);
DBMS_OUTPUT.PUT_LINE('CH = '||CH);
DBMS_OUTPUT.PUT_LINE('VC = '||VC);
IF BL THEN dbms_output.put_line('b1 = '||'true'); end if;
END;
--6
DECLARE
N CONSTANT NUMBER := 5; 
V CONSTANT VARCHAR2(20) := 'HOLA!'; 
C CONSTANT CHAR(5) := 'NO';          
BEGIN
DBMS_OUTPUT.PUT_LINE('V = '||V);
DBMS_OUTPUT.PUT_LINE('N = '||N);
DBMS_OUTPUT.PUT_LINE('C = '||C);
--N:=10;
EXCEPTION WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('ERROR = '||N);
END;
--7, 8
DECLARE
SUBJECT PAV.SUBJECT.SUBJECT%TYPE;
FACULTY PAV.FACULTY%ROWTYPE;
BEGIN 
SUBJECT := 'DB';
FACULTY.FACULTY := 'SOME';
FACULTY.FACULTY_NAME := 'SOME';

DBMS_OUTPUT.PUT_LINE(SUBJECT);
DBMS_OUTPUT.PUT_LINE(RTRIM(FACULTY.FACULTY)||':'||FACULTY.FACULTY_NAME);
END;
--9
DECLARE 
X NUMBER := 5;
BEGIN
IF 10 > X
THEN 
DBMS_OUTPUT.PUT_LINE('10 > '||X);
ELSIF 10 = X
THEN
DBMS_OUTPUT.PUT_LINE('10 = '||X);
ELSE 
DBMS_OUTPUT.PUT_LINE('10 < '||X);
END IF;
END;
--10
DECLARE
X NUMBER := 5;
BEGIN
CASE X
WHEN 5 THEN DBMS_OUTPUT.PUT_LINE(X);
END CASE;
CASE 
WHEN 1 > X THEN DBMS_OUTPUT.PUT_LINE('1 > '||X);
WHEN X BETWEEN 3 AND 10 THEN DBMS_OUTPUT.PUT_LINE('Good!');
ELSE DBMS_OUTPUT.PUT_LINE('ELSE...');
END CASE;
END;
--11, 12, 13
DECLARE 
X NUMBER := 1;
BEGIN
LOOP
X := X + 1;
DBMS_OUTPUT.PUT_LINE(X);
EXIT WHEN X > 5;
END LOOP;
FOR N IN  1..5
LOOP
DBMS_OUTPUT.PUT_LINE(X);
END LOOP;
WHILE (X > 0)
LOOP
X := X - 1;
DBMS_OUTPUT.PUT_LINE(X);
END LOOP;
END;