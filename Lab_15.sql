--1
CREATE TABLE T_RANGE
(
ID NUMBER,
TIME_ID DATE
)
PARTITION BY RANGE(ID)
(
PARTITION P1 VALUES LESS THAN (100),
PARTITION P2 VALUES LESS THAN (200),
PARTITION P3 VALUES LESS THAN (300),
PARTITION PMAX VALUES LESS THAN (MAXVALUE)
);

INSERT INTO T_RANGE (ID, TIME_ID) VALUES (1, '01-04-2022');
INSERT INTO T_RANGE (ID, TIME_ID) VALUES (10, '02-04-2022');
INSERT INTO T_RANGE (ID, TIME_ID) VALUES (50, '03-04-2022');
INSERT INTO T_RANGE (ID, TIME_ID) VALUES (100, '04-04-2022');
INSERT INTO T_RANGE (ID, TIME_ID) VALUES (200, '05-04-2022');
INSERT INTO T_RANGE (ID, TIME_ID) VALUES (500, '06-04-2022');

SELECT * FROM T_RANGE PARTITION(P1);
SELECT * FROM T_RANGE PARTITION(P2);
SELECT * FROM T_RANGE PARTITION(P3);
SELECT * FROM T_RANGE PARTITION(PMAX);

SELECT TABLE_NAME, PARTITION_NAME, HIGH_VALUE, TABLESPACE_NAME
FROM USER_TAB_PARTITIONS 
WHERE TABLE_NAME = 'T_RANGE';
--2
CREATE TABLE T_INTERVAL
(
ID NUMBER,
TIME_ID DATE
)
PARTITION BY RANGE(TIME_ID)
INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))
(
PARTITION P1 VALUES LESS THAN (TO_DATE('01-01-2008', 'DD-MM-YYYY')),
PARTITION P2 VALUES LESS THAN (TO_DATE('01-05-2015', 'DD-MM-YYYY')),
PARTITION P3 VALUES LESS THAN (TO_DATE('01-12-2022', 'DD-MM-YYYY'))
);

INSERT INTO T_INTERVAL (ID, TIME_ID) VALUES (55, '01-08-2007');
INSERT INTO T_INTERVAL (ID, TIME_ID) VALUES (105, '01-08-2008');
INSERT INTO T_INTERVAL (ID, TIME_ID) VALUES (185, '15-05-2010');
INSERT INTO T_INTERVAL (ID, TIME_ID) VALUES (255, '26-08-2014');
INSERT INTO T_INTERVAL (ID, TIME_ID) VALUES (375, '04-06-2016');
INSERT INTO T_INTERVAL (ID, TIME_ID) VALUES (505, '09-04-2023');

SELECT * FROM T_INTERVAL PARTITION(P1);
SELECT * FROM T_INTERVAL PARTITION(P2);
SELECT * FROM T_INTERVAL PARTITION(P3);

SELECT TABLE_NAME, PARTITION_NAME, HIGH_VALUE, TABLESPACE_NAME
FROM USER_TAB_PARTITIONS 
WHERE TABLE_NAME = 'T_INTERVAL';
--3
CREATE TABLE T_HASH
(
ID NUMBER,
STR NVARCHAR2(25)
)
PARTITION BY HASH (STR)
(
PARTITION P1,
PARTITION P2,
PARTITION P3
);

INSERT INTO T_HASH VALUES (1, 'SOME1');
INSERT INTO T_HASH VALUES (2, 'SOME2');
INSERT INTO T_HASH VALUES (3, 'SOME3');
INSERT INTO T_HASH VALUES (4, 'SOME4');
INSERT INTO T_HASH VALUES (5, 'SOME5');
INSERT INTO T_HASH VALUES (6, 'SOME6');

SELECT * FROM T_HASH PARTITION(P1);
SELECT * FROM T_HASH PARTITION(P2);
SELECT * FROM T_HASH PARTITION(P3);

SELECT TABLE_NAME, PARTITION_NAME, HIGH_VALUE, TABLESPACE_NAME
FROM USER_TAB_PARTITIONS 
WHERE TABLE_NAME = 'T_HASH';
--4
CREATE TABLE T_LIST 
(
ID NUMBER,
SOME CHAR
)
PARTITION BY LIST (SOME)
(
PARTITION P1 VALUES ('A', 'B', 'C'),
PARTITION P2 VALUES ('D', 'E', 'F'),
PARTITION P3 VALUES ('G', 'H', 'K')
);

INSERT INTO T_LIST VALUES (1 , 'A');
INSERT INTO T_LIST VALUES (2 , 'B');
INSERT INTO T_LIST VALUES (3 , 'C');
INSERT INTO T_LIST VALUES (4 , 'D');
INSERT INTO T_LIST VALUES (5 , 'E');
INSERT INTO T_LIST VALUES (6 , 'F');
INSERT INTO T_LIST VALUES (7 , 'G');
INSERT INTO T_LIST VALUES (8 , 'H');
INSERT INTO T_LIST VALUES (9 , 'K');

SELECT * FROM T_LIST PARTITION(P1);
SELECT * FROM T_LIST PARTITION(P2);
SELECT * FROM T_LIST PARTITION(P3);

SELECT TABLE_NAME, PARTITION_NAME, HIGH_VALUE, TABLESPACE_NAME
FROM USER_TAB_PARTITIONS 
WHERE TABLE_NAME = 'T_LIST';
--5
--6
-----------------------------------------------------------
ALTER TABLE T_RANGE ENABLE ROW MOVEMENT;
UPDATE T_RANGE PARTITION(P1) SET ID = 190 WHERE ID = 1;
SELECT * FROM T_RANGE PARTITION(P1);
SELECT * FROM T_RANGE PARTITION(P2);
-----------------------------------------------------------
ALTER TABLE T_INTERVAL ENABLE ROW MOVEMENT;
UPDATE T_INTERVAL PARTITION(P1) SET TIME_ID = '15-05-2018' WHERE ID = 55;
SELECT * FROM T_INTERVAL PARTITION(P1);
SELECT * FROM T_INTERVAL PARTITION(P3);
-----------------------------------------------------------
ALTER TABLE T_HASH ENABLE ROW MOVEMENT;
UPDATE T_HASH PARTITION(P2) SET STR = 'SOME6' WHERE ID = 2;
SELECT * FROM T_HASH PARTITION(P1);
SELECT * FROM T_HASH PARTITION(P2);
-----------------------------------------------------------
ALTER TABLE T_LIST ENABLE ROW MOVEMENT;
UPDATE T_LIST PARTITION(P1) SET SOME = 'D' WHERE ID = 1;
SELECT * FROM T_LIST PARTITION(P1);
SELECT * FROM T_LIST PARTITION(P2);
-----------------------------------------------------------
--7
ALTER TABLE T_RANGE MERGE PARTITIONS P1, P2 INTO PARTITION P5;
SELECT * FROM T_RANGE PARTITION(P5);
--8
ALTER TABLE T_INTERVAL SPLIT PARTITION P2 AT (TO_DATE('25-08-2014', 'DD-MM-YYYY'))
INTO (PARTITION P4, PARTITION P5);
SELECT * FROM T_INTERVAL PARTITION(P4);
SELECT * FROM T_INTERVAL PARTITION(P5);
--9
CREATE TABLE T_LIST_NEW 
(
ID NUMBER,
SOME CHAR
);
ALTER TABLE T_LIST EXCHANGE PARTITION P2 WITH TABLE T_LIST_NEW WITHOUT VALIDATION;

SELECT * FROM T_LIST PARTITION(P2);
SELECT * FROM T_LIST_NEW;
--10
SELECT * FROM DBA_PART_TABLES;