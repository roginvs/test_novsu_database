/*
 1. Сколько часов занятий проводит каждый преподаватель с соответствующими группами.
 */
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

