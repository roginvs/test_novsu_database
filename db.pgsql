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
CREATE TABLE sudents(
    student_id serial PRIMARY KEY,
    first_name VARCHAR (255) UNIQUE NOT NULL,
    last_name VARCHAR (255) UNIQUE NOT NULL,
    group_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (group_id) REFERENCES groups (id)
);