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

CREATE OR REPLACE FUNCTION alter_view1 ()
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

DROP TRIGGER IF EXISTS tr_view1 ON view1;

CREATE TRIGGER tr_view1
    INSTEAD OF UPDATE ON view1
    FOR EACH ROW
    EXECUTE PROCEDURE alter_view1 ();


/* ----- Демонстрация ----- */
SELECT
    *
FROM
    view1;

UPDATE
    view1
SET
    "course_name" = 'Cleanest code'
WHERE
    course_id = 1000;

SELECT
    *
FROM
    view1;

