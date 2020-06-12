/*
 
 cat db.pgsql | docker exec -i psql psql -U postgres
 
 */
DROP schema IF EXISTS "rogin" CASCADE;
CREATE schema "rogin";
SET search_path TO "rogin",
    public;
/* ==== */
/* */
CREATE TABLE distictions(
    id serial PRIMARY KEY,
    distiction_name VARCHAR (255) UNIQUE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
/* */
CREATE TABLE specialities(
    id serial PRIMARY KEY,
    speciality_name VARCHAR (255) UNIQUE NOT NULL,
    distinction_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (distinction_id) REFERENCES distictions (id)
);
/* */
CREATE TABLE groups(
    id serial PRIMARY KEY,
    group_name VARCHAR (255) UNIQUE NOT NULL,
    speciality_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (speciality_id) REFERENCES specialities (id)
);
/* */
CREATE TABLE students(
    id serial PRIMARY KEY,
    first_name VARCHAR (255) UNIQUE NOT NULL,
    last_name VARCHAR (255) UNIQUE NOT NULL,
    group_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (group_id) REFERENCES groups (id)
);
/* Sample data */
INSERT INTO distictions (id, distiction_name)
VALUES (1, 'Distiction 1');
INSERT INTO specialities (id, distinction_id, speciality_name)
VALUES (1, 1, 'Speciality 1');
INSERT INTO groups (id, group_name, speciality_id)
VALUES (1, 'Group 1', 1);
INSERT INTO students (id, first_name, last_name, group_id)
VALUES (1, 'Vasilii', 'Rogin', 1),
    (2, 'Bob', 'Martin', 1);