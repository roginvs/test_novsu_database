;
DROP schema IF EXISTS "rogin" CASCADE;
DROP USER IF EXISTS vasilii;
DROP DATABASE IF EXISTS "rogin";
CREATE USER vasilii WITH PASSWORD '123123';
CREATE database "rogin" ;
grant all privileges on database rogin to vasilii;