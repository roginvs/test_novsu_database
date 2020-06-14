/* 
 
 Sample data 
 */
INSERT INTO lesson_types (id, lesson_type_name)
    VALUES (1, 'Lection'), (2, 'Practice');

;

INSERT INTO timeslots (id, day_of_week, lesson_number)
    VALUES (1, 1, 0), (2, 1, 1), (3, 1, 2), (4, 1, 3), (5, 2, 0), (6, 2, 1), (7, 2, 2), (8, 2, 3), (9, 3, 0), (10, 3, 1), (11, 3, 2), (12, 3, 3), (13, 4, 0), (14, 4, 1), (15, 4, 2), (16, 4, 3), (17, 5, 0), (18, 5, 1), (19, 5, 2), (20, 5, 3);

INSERT INTO distictions (id, distiction_name)
    VALUES (1, 'Distiction 1');

INSERT INTO specialities (id, distinction_id, speciality_name)
    VALUES (1, 1, 'Speciality 1');

INSERT INTO GROUPS (id, group_name, speciality_id)
    VALUES (1, 'Group 1', 1);

ALTER SEQUENCE groups_id_seq
    RESTART WITH 2;

INSERT INTO students (id, first_name, last_name, group_id)
    VALUES (1, 'Vasilii', 'Rogin', 1), (2, 'Maria', 'Rogina', 1);

INSERT INTO teachers (id, first_name, last_name)
    VALUES (100, 'Bob', 'Martin'), (101, 'Steve', 'McConnell'), (102, 'Donald', 'Knuth'), (103, 'Slowpoke', 'Pokemon'), (104, 'Superman', 'Knowseverything');

INSERT INTO courses (id, course_name)
    VALUES (1000, 'Clean code'), (1001, 'Code complete'), (1002, 'The Art of Computer Programming part1'), (1003, 'How to be very slow'), (1004, 'The Art of Computer Programming part2');

INSERT INTO teachers_abilities (teacher_id, course_id)
    VALUES (100, 1000), (101, 1001), (102, 1002), (103, 1003), (104, 1000), (104, 1001), (104, 1002), (104, 1003), (102, 1004);

INSERT INTO tariffs (course_id, lesson_type_id, price)
    VALUES (1000, 1, 400), (1000, 2, 450), (1001, 1, 600), (1001, 2, 650), (1002, 1, 2000), (1002, 2, 2050), (1004, 1, 2000), (1004, 2, 2050), (1003, 1, 10);

INSERT INTO weekly_schedule (timeslot_id, group_id, teacher_id, course_id, lesson_type_id)
    VALUES (1, 1, 100, 1000, 1), (2, 1, 100, 1000, 2), (3, 1, 101, 1001, 1), (4, 1, 101, 1001, 2), (5, 1, 101, 1001, 2), (8, 1, 102, 1002, 1), (9, 1, 102, 1002, 1), (10, 1, 102, 1002, 2), (11, 1, 102, 1002, 2), (13, 1, 104, 1000, 1), (14, 1, 104, 1001, 1), (15, 1, 104, 1002, 1), (16, 1, 104, 1003, 1), (17, 1, 104, 1000, 1), (18, 1, 104, 1001, 1), (19, 1, 104, 1002, 1), (20, 1, 104, 1003, 1);

