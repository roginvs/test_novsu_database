;
CREATE TABLE distictions(
    id serial PRIMARY KEY,
    distiction_name VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
;
CREATE TABLE specialities(
    id serial PRIMARY KEY,
    speciality_name VARCHAR (255) NOT NULL,
    distinction_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (distinction_id) REFERENCES distictions (id)
);
;
CREATE TABLE groups(
    id serial PRIMARY KEY,
    group_name VARCHAR (255) NOT NULL,
    speciality_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (speciality_id) REFERENCES specialities (id)
);
;
CREATE TABLE students(
    id serial PRIMARY KEY,
    first_name VARCHAR (255) NOT NULL,
    last_name VARCHAR (255) NOT NULL,
    group_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (group_id) REFERENCES groups (id)
);
;
CREATE TABLE teachers(
    id serial PRIMARY KEY,
    first_name VARCHAR (255) NOT NULL,
    last_name VARCHAR (255) NOT NULL,
    phone_number VARCHAR(255) NULL,
    experience_cumulative_days INTEGER DEFAULT 0 NOT NULL CHECK (experience_cumulative_days >= 0),
    experience_current_started_at TIMESTAMP NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
;
CREATE TABLE lesson_types(
    id serial PRIMARY KEY,
    lesson_type_name VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE courses(
    id serial PRIMARY KEY,
    course_name VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
    /* 
     No link to distinction/speciality because course can be shared
     */
);
;
CREATE TABLE teachers_abilities(
    teacher_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (teacher_id, course_id)
);
;
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
CREATE TABLE tariffs (
    id serial primary key,
    course_id INTEGER NOT NULL,
    lesson_type_id INTEGER NOT NULL,
    price INTEGER NOT NULL check (price > 0),
    FOREIGN KEY (lesson_type_id) REFERENCES lesson_types (id),
    FOREIGN KEY (course_id) REFERENCES courses (id)
);
;
;
;
