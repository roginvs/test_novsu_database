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


/*
 2. Сколько денег получит преподаватель за проведенные занятия по определенной
дисциплине.
 */
SELECT
    "teachers"."id" AS teacher_id,
    "teachers"."first_name",
    "teachers"."last_name",
    "weekly_schedule"."course_id",
    count(*) AS lessons_count,
    sum("tariffs"."price")
FROM
    "weekly_schedule"
    LEFT JOIN "teachers" ON "teachers"."id" = "weekly_schedule"."teacher_id"
    LEFT JOIN "tariffs" ON "weekly_schedule"."course_id" = "tariffs"."course_id"
        AND "weekly_schedule"."lesson_type_id" = "tariffs"."lesson_type_id"
GROUP BY
    "teachers"."id",
    "weekly_schedule"."course_id"
ORDER BY
    "teachers"."id"
