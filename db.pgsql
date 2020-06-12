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
    distiction_name VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
/* */
CREATE TABLE specialities(
    id serial PRIMARY KEY,
    speciality_name VARCHAR (255) NOT NULL,
    distinction_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (distinction_id) REFERENCES distictions (id)
);
/* */
CREATE TABLE groups(
    id serial PRIMARY KEY,
    group_name VARCHAR (255) NOT NULL,
    speciality_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (speciality_id) REFERENCES specialities (id)
);
/* */
CREATE TABLE students(
    id serial PRIMARY KEY,
    first_name VARCHAR (255) NOT NULL,
    last_name VARCHAR (255) NOT NULL,
    group_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (group_id) REFERENCES groups (id)
);
CREATE TABLE teachers(
    id serial PRIMARY KEY,
    first_name VARCHAR (255) NOT NULL,
    last_name VARCHAR (255) NOT NULL,
    phone_number VARCHAR(255) NULL,
    experience_cumulative_days INTEGER DEFAULT 0 NOT NULL CHECK (experience_cumulative_days >= 0),
    experience_current_started_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
/* */
CREATE TABLE lesson_types(
    id serial PRIMARY KEY,
    lesson_type_name VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
INSERT INTO lesson_types (id, lesson_type_name)
VALUES (1, 'Lection'),
    (2, 'Practice');
/* */
CREATE TABLE courses(
    id serial PRIMARY KEY,
    course_name VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
    /* 
     No link to distinction/speciality!
     */
);
/* */
CREATE TABLE teachers_abilities(
    teacher_id INTEGER,
    course_id INTEGER,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (teacher_id, course_id)
);
;
;
/* 
 Sample data 
 
 */
INSERT INTO distictions (id, distiction_name)
VALUES (1, 'Distiction 1');
INSERT INTO specialities (id, distinction_id, speciality_name)
VALUES (1, 1, 'Speciality 1');
INSERT INTO groups (id, group_name, speciality_id)
VALUES (1, 'Group 1', 1);
INSERT INTO students (id, first_name, last_name, group_id)
VALUES (1, 'Vasilii', 'Rogin', 1),
    (2, 'Maria', 'Rogina', 1);
INSERT INTO teachers (id, first_name, last_name)
VALUES (100, 'Bob', 'Martin'),
    (101, 'Steve', 'McConnell');
INSERT INTO courses (id, course_name)
VALUES (1000, 'Clean code'),
    (1001, 'Code complete');
INSERT INTO teachers_abilities (teacher_id, course_id)
VALUES (100, 1000),
    (101, 1001);
/* */