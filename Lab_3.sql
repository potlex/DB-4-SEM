SELECT name, OPEN_MODE FROM   v$PDBS;

select * from dict;
select * from dba_tablespaces;
select * from dba_roles;
select * from dba_users;
SELECT * FROM DBA_PDBS;
select * from dba_data_files;
select * from dba_profiles;
alter session set container = pdb_pot;
select grantee, granted_role from dba_role_privs;

grant create table to C##PAV;
grant insert on Something to C##PAV;

SELECT * FROM V$PDBS;

GRANT CREATE SESSION TO C##KDA;

select * from v$session

