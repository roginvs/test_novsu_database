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
    teacher_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (teacher_id, course_id)
);
;
/* */
CREATE TABLE timeslots(
    id serial primary key,
    day_of_week INTEGER NOT NULL CHECK (
        day_of_week >= 1
        and day_of_week <= 5
    ),
    lesson_number INTEGER NOT NULL CHECK (
        lesson_number >= 0
        and lesson_number <= 5
    ),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    unique(day_of_week, lesson_number)
);
INSERT INTO timeslots(id, day_of_week, lesson_number)
VALUES (1, 1, 0),
    (2, 1, 1),
    (3, 1, 2),
    (4, 1, 3),
    (5, 2, 0),
    (6, 2, 1),
    (7, 2, 2),
    (8, 2, 3),
    (9, 3, 0),
    (10, 3, 1),
    (11, 3, 2),
    (12, 3, 3);
;
;
/* */
CREATE TABLE weekly_schedule (
    id serial primary key,
    timeslot_id INTEGER NOT NULL,
    group_id INTEGER NOT NULL,
    teacher_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    lesson_type_id INTEGER NOT NULL,
    FOREIGN KEY (timeslot_id) REFERENCES timeslots (id),
    FOREIGN KEY (group_id) REFERENCES groups (id),
    FOREIGN KEY (teacher_id) REFERENCES teachers (id),
    FOREIGN KEY (lesson_type_id) REFERENCES lesson_types (id),
    FOREIGN KEY (teacher_id, course_id) REFERENCES teachers_abilities (teacher_id, course_id),
    UNIQUE(group_id, timeslot_id),
    UNIQUE(teacher_id, timeslot_id)
);
;
/* */
CREATE TABLE tariffs (
    id serial primary key,
    course_id INTEGER NOT NULL,
    lesson_type_id INTEGER NOT NULL,
    price INTEGER NOT NULL check (price > 0),
    FOREIGN KEY (lesson_type_id) REFERENCES lesson_types (id),
    FOREIGN KEY (course_id) REFERENCES courses (id)
);
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