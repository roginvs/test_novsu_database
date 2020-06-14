DROP TABLE IF EXISTS joinA;

CREATE TABLE joinA (
    nameA varchar(255) NOT NULL,
    joinid integer NULL
);

DROP TABLE IF EXISTS joinB;

CREATE TABLE joinB (
    nameB varchar(255) NOT NULL,
    joinid integer NULL
);

INSERT INTO joina (namea, joinid)
    VALUES ('A 1 x', 1), ('A 1 y', 1), ('A 2', 2), ('A 3', 3), ('A 5 x', 5), ('A 5 y', 5);

INSERT INTO joinb (nameb, joinid)
    VALUES ('B 1', 1), ('B 2 x', 2), ('B 2 y', 2), ('B 4', 4), ('B 5 x', 5), ('B 5 y', 5);

SELECT
    *
FROM
    joina;

SELECT
    *
FROM
    joinb;

SELECT
    *,
    'inner join' AS mode
FROM
    joina
    INNER JOIN joinb ON "joina"."joinid" = "joinb"."joinid";

SELECT
    *,
    'outer join' AS mode
FROM
    joina
    FULL OUTER JOIN joinb ON "joina"."joinid" = "joinb"."joinid";

SELECT
    *,
    'left join' AS mode
FROM
    joina
    LEFT OUTER JOIN joinb ON "joina"."joinid" = "joinb"."joinid";

SELECT
    *,
    'cross join' AS mode
FROM
    joina
    CROSS JOIN joinb;

