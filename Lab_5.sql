--1
SELECT * FROM DBA_TABLESPACES;
--2
CREATE TABLESPACE PAV_QDATA2
  DATAFILE 'C:\app\Tablespaces\PAV_QDATA2.dbf'
  SIZE 10M
  AUTOEXTEND ON NEXT 2M
  MAXSIZE 30M
  OFFLINE
  EXTENT MANAGEMENT LOCAL;
  
ALTER TABLESPACE PAV_QDATA2 ONLINE;

ALTER USER PAVCORE 
DEFAULT TABLESPACE PAV_QDATA2
QUOTA 2M ON PAV_QDATA2;

--PAVCORE ACTIONS
CREATE TABLE PAV_T1 
(
id number primary key,
name nvarchar2(50)
);

INSERT INTO PAV_T1 VALUES (1, 'Breathe');
INSERT INTO PAV_T1 VALUES (2, 'all the');
INSERT INTO PAV_T1 VALUES (3, 'time...');

DELETE FROM PAV_T1;
--3
SELECT DISTINCT SEGMENT_TYPE FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'PAV_QDATA2';
--4
SELECT DISTINCT * FROM DBA_SEGMENTS WHERE SEGMENT_NAME = 'PAV_T1';
--5 
SELECT DISTINCT * FROM DBA_SEGMENTS;
--6
DROP TABLE PAV_T1;
--7
SELECT * FROM USER_RECYCLEBIN;
--8
FLASHBACK TABLE PAV_T1 TO BEFORE DROP;

SELECT * FROM PAV_T1;
--9
BEGIN
FOR K IN 1..10000 LOOP
INSERT INTO PAV_T1(id, name) VALUES(K, 'O');
END LOOP;
END;

SELECT COUNT(*) FROM PAV_T1;
--10 
SELECT DISTINCT * FROM DBA_SEGMENTS WHERE SEGMENT_NAME = 'PAV_T1';
--11
SELECT DISTINCT * FROM DBA_EXTENTS;
--12
SELECT ROWID FROM PAV_T1;
--13
SELECT ORA_ROWSCN FROM PAV_T1;
--16
DROP TABLESPACE PAV_QDATA2 INCLUDING CONTENTS AND DATAFILES;

