/* */
CREATE OR REPLACE FUNCTION create_tariffs_for_course ()
    RETURNS TRIGGER
    AS $BODY$
DECLARE
    lesson RECORD;
BEGIN
    FOR lesson IN
    SELECT
        id
    FROM
        lesson_types LOOP
            INSERT INTO tariffs (course_id, lesson_type_id, price)
                VALUES (NEW.id, lesson.id, 5);
        END LOOP;
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_create_tariffs_for_courses ON courses;


/** Demo data **/
CREATE TRIGGER trigger_create_tariffs_for_courses
    AFTER INSERT ON courses
    FOR EACH ROW
    EXECUTE PROCEDURE create_tariffs_for_course ();

SELECT
    *
FROM
    tariffs;

INSERT INTO courses (id, course_name)
    VALUES (1100, 'Trigger demo course');

SELECT
    *
FROM
    tariffs;

