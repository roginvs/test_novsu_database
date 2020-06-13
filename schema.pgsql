CREATE TABLE distictions (
    id serial PRIMARY KEY,
    distiction_name varchar(255) NOT NULL,
    created_at timestamp NOT NULL DEFAULT NOW()
);

CREATE TABLE specialities (
    id serial PRIMARY KEY,
    speciality_name varchar(255) NOT NULL,
    distinction_id integer NOT NULL,
    created_at timestamp NOT NULL DEFAULT NOW(),
    FOREIGN KEY (distinction_id) REFERENCES distictions (id)
);

CREATE TABLE GROUPS (
    id serial PRIMARY KEY,
    group_name varchar(255) NOT NULL,
    speciality_id integer NOT NULL,
    created_at timestamp NOT NULL DEFAULT NOW(),
    FOREIGN KEY (speciality_id) REFERENCES specialities (id)
);

CREATE TABLE students (
    id serial PRIMARY KEY,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    group_id integer NOT NULL,
    created_at timestamp NOT NULL DEFAULT NOW(),
    FOREIGN KEY (group_id) REFERENCES GROUPS (id)
);

CREATE TABLE teachers (
    id serial PRIMARY KEY,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    phone_number varchar(255) NULL,
    experience_cumulative_days integer DEFAULT 0 NOT NULL CHECK (experience_cumulative_days >= 0),
    experience_current_started_at timestamp NOT NULL DEFAULT NOW(),
    created_at timestamp NOT NULL DEFAULT NOW()
);

CREATE TABLE lesson_types (
    id serial PRIMARY KEY,
    lesson_type_name varchar(255) NOT NULL,
    created_at timestamp NOT NULL DEFAULT NOW()
);

CREATE TABLE courses (
    id serial PRIMARY KEY,
    course_name varchar(255) NOT NULL,
    created_at timestamp NOT NULL DEFAULT NOW()
    /* 
     No link to distinction/speciality because course can be shared
     */
);

CREATE TABLE teachers_abilities (
    teacher_id integer NOT NULL,
    course_id integer NOT NULL,
    created_at timestamp NOT NULL DEFAULT NOW(),
    PRIMARY KEY (teacher_id, course_id)
);

CREATE TABLE timeslots (
    id serial PRIMARY KEY,
    day_of_week integer NOT NULL CHECK (day_of_week >= 1 AND day_of_week <= 5),
    lesson_number integer NOT NULL CHECK (lesson_number >= 0 AND lesson_number <= 5),
    created_at timestamp NOT NULL DEFAULT NOW(),
    UNIQUE (day_of_week, lesson_number)
);

CREATE TABLE weekly_schedule (
    id serial PRIMARY KEY,
    timeslot_id integer NOT NULL,
    group_id integer NOT NULL,
    teacher_id integer NOT NULL,
    course_id integer NOT NULL,
    lesson_type_id integer NOT NULL,
    FOREIGN KEY (timeslot_id) REFERENCES timeslots (id),
    FOREIGN KEY (group_id) REFERENCES GROUPS (id),
    FOREIGN KEY (teacher_id) REFERENCES teachers (id),
    FOREIGN KEY (lesson_type_id) REFERENCES lesson_types (id),
    FOREIGN KEY (teacher_id, course_id) REFERENCES teachers_abilities (teacher_id, course_id),
    UNIQUE (group_id, timeslot_id),
    UNIQUE (teacher_id, timeslot_id)
);

CREATE TABLE tariffs (
    id serial PRIMARY KEY,
    course_id integer NOT NULL,
    lesson_type_id integer NOT NULL,
    price integer NOT NULL CHECK (price > 0),
    FOREIGN KEY (lesson_type_id) REFERENCES lesson_types (id),
    FOREIGN KEY (course_id) REFERENCES courses (id)
);

