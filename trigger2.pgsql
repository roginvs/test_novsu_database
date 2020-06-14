/* Проверка имени группы */
CREATE OR REPLACE FUNCTION validate_group_name ()
    RETURNS TRIGGER
    AS $BODY$
BEGIN
    IF NEW.group_name = '' THEN
        RAISE EXCEPTION 'Empty name is not allowed';
    END IF;
    IF position('keke' IN lower(NEW.group_name)) > 0 THEN
        RAISE EXCEPTION 'No keke in group name! (%)', NEW.group_name;
    END IF;
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_validate_group_name ON GROUPS;

CREATE TRIGGER tr_validate_group_name
    AFTER INSERT ON GROUPS
    FOR EACH ROW
    EXECUTE PROCEDURE validate_group_name ();

INSERT INTO GROUPS (group_name, speciality_id)
    VALUES ('Valid group', 1);

INSERT INTO GROUPS (group_name, speciality_id)
    VALUES ('', 1);

INSERT INTO GROUPS (group_name, speciality_id)
    VALUES ('Lol keke lol', 1);

