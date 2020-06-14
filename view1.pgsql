/* view */
DROP VIEW IF EXISTS view1;

CREATE VIEW view1 AS
SELECT
    "teachers"."id" AS teacher_id,
    "teachers"."first_name",
    "teachers"."last_name",
    "courses"."id" AS course_id,
    "courses"."course_name"
FROM
    "teachers_abilities"
    LEFT JOIN "teachers" ON "teachers"."id" = "teachers_abilities"."teacher_id"
    LEFT JOIN "courses" ON ("teachers_abilities"."course_id" = "courses"."id")
ORDER BY
    "teacher_id",
    "course_id";


/* view update */
CREATE OR REPLACE FUNCTION view1_update ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    IF (OLD.course_id != NEW.course_id) THEN
        RAISE EXCEPTION 'Not allowed to change course_id here';
    END IF;
    IF (OLD.course_name != NEW.course_name) THEN
        UPDATE
            courses
        SET
            course_name = NEW.course_name
        WHERE
            id = NEW.course_id;
    END IF;
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_view1_update ON view1;

CREATE TRIGGER tr_view1_update
    INSTEAD OF UPDATE ON view1
    FOR EACH ROW
    EXECUTE PROCEDURE view1_update ();


/* view insert */
CREATE OR REPLACE FUNCTION view1_insert ()
    RETURNS TRIGGER
    AS $BODY$
DECLARE
    teacher_id integer;
    course_id integer;
BEGIN
    IF NEW.teacher_id IS NOT NULL THEN
        RAISE EXCEPTION 'Not allowed to provide teacher_id';
    END IF;
    IF NEW.course_id IS NOT NULL THEN
        RAISE EXCEPTION 'Not allowed to provide course_id';
    END IF;
    INSERT INTO teachers (first_name, last_name)
        VALUES (NEW.first_name, NEW.last_name)
    RETURNING
        id INTO teacher_id;
    INSERT INTO courses (course_name)
        VALUES (NEW.course_name)
    RETURNING
        id INTO course_id;
    INSERT INTO teachers_abilities (teacher_id, course_id)
        VALUES (teacher_id, course_id);
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_view1_insert ON view1;

CREATE TRIGGER tr_view1_insert
    INSTEAD OF INSERT ON view1
    FOR EACH ROW
    EXECUTE PROCEDURE view1_insert ();


/* view delete */
CREATE OR REPLACE FUNCTION view1_delete ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    DELETE FROM teachers_abilities
    WHERE teacher_id = OLD.teacher_id
        AND course_id = OLD.course_id;
    RETURN OLD;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_view1_delete ON view1;

CREATE TRIGGER tr_view1_delete
    INSTEAD OF DELETE ON view1
    FOR EACH ROW
    EXECUTE PROCEDURE view1_delete ();


/* ----- Демонстрация ----- */
SELECT
    *
FROM
    view1;

UPDATE
    view1
SET
    "course_name" = CONCAT("course_name", ' X')
WHERE
    course_id = 1000;

SELECT
    *
FROM
    view1;


/* insert */
SELECT
    *
FROM
    teachers_abilities;

INSERT INTO view1 (first_name, last_name, course_name)
    VALUES ('New name', 'New last name', 'New course');

SELECT
    *
FROM
    view1;

