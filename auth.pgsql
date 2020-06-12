;
DROP schema IF EXISTS "rogin" CASCADE;
DROP USER IF EXISTS vasilii;
CREATE USER vasilii WITH PASSWORD '123123';
CREATE schema "rogin" AUTHORIZATION vasilii;
;
SET search_path TO "rogin",
    public;
;
;