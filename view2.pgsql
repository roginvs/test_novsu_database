DROP VIEW IF EXISTS view2;

CREATE VIEW view2 AS
SELECT
    "teachers"."id" AS teacher_id,
    "teachers"."first_name",
    "teachers"."last_name",
    count(*) AS hours
FROM
    "teachers"
    LEFT JOIN "weekly_schedule" ON "teachers"."id" = "weekly_schedule"."teacher_id"
GROUP BY
    "teachers"."id";

SELECT
    *
FROM
    view2;

CREATE OR REPLACE FUNCTION alter_view2 ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    IF (OLD.teacher_id != NEW.teacher_id) THEN
        RAISE EXCEPTION 'Not allowed to change teacher_id here';
    END IF;
    IF (OLD.first_name != NEW.first_name OR OLD.last_name != OLD.last_name) THEN
        UPDATE
            teachers
        SET
            first_name = NEW.first_name,
            last_name = NEW.last_name
        WHERE
            id = NEW.teacher_id;
    END IF;
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_view2 ON view2;

CREATE TRIGGER tr_view2
    INSTEAD OF UPDATE ON view2
    FOR EACH ROW
    EXECUTE PROCEDURE alter_view2 ();


/* ----- Демонстрация ----- */
SELECT
    *
FROM
    view2;

UPDATE
    view2
SET
    first_name = 'Bobby'
WHERE
    teacher_id = 100;

SELECT
    *
FROM
    view2;

