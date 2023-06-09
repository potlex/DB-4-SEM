--1
CREATE TABLE SOMETABLE
(
ID NUMBER NOT NULL,
NAME NVARCHAR2(20) NOT NULL,
PROFIT NUMBER NOT NULL,
CONSTRAINT PK_S
PRIMARY KEY (ID),
CONSTRAINT UQ_S
UNIQUE (NAME)
);

SELECT * FROM SOMETABLE;

DROP TABLE SOMETABLE;
--2
INSERT INTO SOMETABLE VALUES(1, 'IDG GROUP', 4845300);
INSERT INTO SOMETABLE VALUES(2, 'SMLE', 4343430);
INSERT INTO SOMETABLE VALUES(3, 'DOG PAPE', 54654665);
INSERT INTO SOMETABLE VALUES(4, 'SMBA GROUP', 2735668);
INSERT INTO SOMETABLE VALUES(5, 'EFRANCE', 3942004);
INSERT INTO SOMETABLE VALUES(6, 'ECOMMERCENCES', 154537);
INSERT INTO SOMETABLE VALUES(7, 'GLHF', 5435548);
INSERT INTO SOMETABLE VALUES(8, 'SAMPLE DAPE', 100035);
INSERT INTO SOMETABLE VALUES(9, 'GRAPHEED', 934778);
INSERT INTO SOMETABLE VALUES(10, 'IP', 73253);
--3
--INSERT
CREATE OR REPLACE TRIGGER AUDITORIUM_BEFORE_INSERT
BEFORE INSERT ON AUDITORIUM
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_BEFORE_INSERT');
END;
--UPDATE
CREATE OR REPLACE TRIGGER AUDITORIUM_BEFORE_UPDATE
BEFORE UPDATE ON AUDITORIUM
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_BEFORE_UPDATE');
END;
--DELETE
CREATE OR REPLACE TRIGGER AUDITORIUM_BEFORE_DELETE
BEFORE DELETE ON AUDITORIUM
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_BEFORE_DELETE');
END;
--4
--INSERT
CREATE OR REPLACE TRIGGER AUDITORIUM_BEFORE_INSERT_ROW
BEFORE INSERT ON AUDITORIUM
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_BEFORE_INSERT_ROW');
END;
--UPDATE
CREATE OR REPLACE TRIGGER AUDITORIUM_BEFORE_UPDATE_ROW
BEFORE UPDATE ON AUDITORIUM
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_BEFORE_UPDATE_ROW');
END;
--DELETE
CREATE OR REPLACE TRIGGER AUDITORIUM_BEFORE_DELETE_ROW
BEFORE DELETE ON AUDITORIUM
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_BEFORE_DELETE_ROW');
END;
--5
INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
VALUES('555-5', '555-5', '��', 55);
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = 555 WHERE AUDITORIUM = '555-5';
DELETE FROM AUDITORIUM WHERE AUDITORIUM = '555-5';
--6
--INSERT
CREATE OR REPLACE TRIGGER AUDITORIUM_AFTER_INSERT
AFTER INSERT ON AUDITORIUM
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_AFTER_INSERT');
END;
--UPDATE
CREATE OR REPLACE TRIGGER AUDITORIUM_AFTER_UPDATE
AFTER UPDATE ON AUDITORIUM
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_AFTER_UPDATE');
END;
--DELETE
CREATE OR REPLACE TRIGGER AUDITORIUM_AFTER_DELETE
AFTER DELETE ON AUDITORIUM
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_AFTER_DELETE');
END;
--7
--INSERT
CREATE OR REPLACE TRIGGER AUDITORIUM_AFTER_INSERT_ROW
AFTER INSERT ON AUDITORIUM
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_AFTER_INSERT_ROW');
END;

DROP TRIGGER AUDITORIUM_AFTER_INSERT_ROW;
--UPDATE
CREATE OR REPLACE TRIGGER AUDITORIUM_AFTER_UPDATE_ROW
AFTER UPDATE ON AUDITORIUM
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_AFTER_UPDATE_ROW');
END;

DROP TRIGGER AUDITORIUM_AFTER_UPDATE_ROW;
--DELETE
CREATE OR REPLACE TRIGGER AUDITORIUM_AFTER_DELETE_ROW
AFTER DELETE ON AUDITORIUM
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('AUDITORIUM_AFTER_DELETE_ROW');
END;

DROP TRIGGER AUDITORIUM_AFTER_DELETE_ROW;
--8
CREATE TABLE AUDIT_S
(
OperationDate DATE,
OperationtType NVARCHAR2(6),
TriggerName NVARCHAR2(27),
Data_S NVARCHAR2(50)
);

SELECT * FROM AUDIT_S;

DROP TABLE AUDIT_S;
--9
--AFTER
CREATE OR REPLACE TRIGGER AUDIT_AFTER_TRIGGER
AFTER INSERT OR UPDATE OR DELETE ON AUDITORIUM
BEGIN
IF INSERTING THEN
INSERT INTO AUDIT_S(OperationDate, OperationtType, TriggerName, Data_S)
SELECT SYSDATE,'INSERT', 'AUDIT_AFTER_TRIGGER', 
CONCAT(CONCAT(AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME), CONCAT(AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY))
FROM AUDITORIUM;
ELSIF UPDATING THEN
INSERT INTO AUDIT_S(OperationDate, OperationtType, TriggerName, Data_S)
SELECT SYSDATE,'INSERT', 'AUDIT_AFTER_TRIGGER', 
CONCAT(CONCAT(AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME), CONCAT(AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY))
FROM AUDITORIUM;
ELSIF DELETING THEN
INSERT INTO AUDIT_S(OperationDate, OperationtType, TriggerName, Data_S)
SELECT SYSDATE,'INSERT', 'AUDIT_AFTER_TRIGGER', 
CONCAT(CONCAT(AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME), CONCAT(AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY))
FROM AUDITORIUM;
END IF;
END;
--BEFORE
CREATE OR REPLACE TRIGGER AUDIT_BEFORE_TRIGGER
BEFORE INSERT OR UPDATE OR DELETE ON AUDITORIUM
BEGIN
IF INSERTING THEN
INSERT INTO AUDIT_S(OperationDate, OperationtType, TriggerName, Data_S)
SELECT SYSDATE,'INSERT', 'AUDIT_BEFORE_TRIGGER', 
CONCAT(CONCAT(AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME), CONCAT(AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY))
FROM AUDITORIUM;
ELSIF UPDATING THEN
INSERT INTO AUDIT_S(OperationDate, OperationtType, TriggerName, Data_S)
SELECT SYSDATE,'INSERT', 'AUDIT_BEFORE_TRIGGER', 
CONCAT(CONCAT(AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME), CONCAT(AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY))
FROM AUDITORIUM;
ELSIF DELETING THEN
INSERT INTO AUDIT_S(OperationDate, OperationtType, TriggerName, Data_S)
SELECT SYSDATE,'INSERT', 'AUDIT_BEFORE_TRIGGER', 
CONCAT(CONCAT(AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_NAME), CONCAT(AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_CAPACITY))
FROM AUDITORIUM;
END IF;
END;

INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
VALUES('555-5', '555-5', '��', 55);
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = 555 WHERE AUDITORIUM = '555-5';
DELETE FROM AUDITORIUM WHERE AUDITORIUM = '556-5';

DELETE FROM AUDIT_S;
SELECT * FROM AUDIT_S;
--11
CREATE OR REPLACE TRIGGER NOT_DROP_TABLE
BEFORE DROP ON SCHEMA
BEGIN
RAISE_APPLICATION_ERROR(-20000, 'DO NOT DROP TABLE. '||ORA_DICT_OBJ_TYPE||' '||ORA_DICT_OBJ_NAME);
END;

DROP TABLE AUDIT_S;
--12
DROP TRIGGER NOT_DROP_TABLE;
--13
CREATE VIEW AUDIT_VIEW AS SELECT * FROM AUDITORIUM;

CREATE OR REPLACE TRIGGER IOT_AUDIT
INSTEAD OF UPDATE ON AUDIT_VIEW
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE(:OLD.AUDITORIUM||' '||:OLD.AUDITORIUM_NAME||' '||:OLD.AUDITORIUM_TYPE||' '||:OLD.AUDITORIUM_CAPACITY);  
END;

INSERT INTO AUDIT_VIEW (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
VALUES('777-7', '777-7', '��', 77);
UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = 777 WHERE AUDITORIUM = '777-7';
DELETE FROM AUDITORIUM WHERE AUDITORIUM = '777-7';

SELECT * FROM AUDIT_VIEW;
--15
CREATE TABLE TASK15 
(
ID NUMBER
);
CREATE OR REPLACE TRIGGER T1
AFTER INSERT ON TASK15
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('T1');
END;
CREATE OR REPLACE TRIGGER T3
AFTER INSERT ON TASK15
FOR EACH ROW
FOLLOWS T2
BEGIN
DBMS_OUTPUT.PUT_LINE('T3');
END;
CREATE OR REPLACE TRIGGER T2
AFTER INSERT ON TASK15
FOR EACH ROW
FOLLOWS T1
BEGIN
DBMS_OUTPUT.PUT_LINE('T2');
END;

INSERT INTO TASK15 VALUES(4);