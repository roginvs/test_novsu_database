select 
"teachers"."id" as teacher_id,
"teachers"."first_name",
"teachers"."last_name",
count(*) as hours
 from "teachers" left join  "weekly_schedule" on "teachers"."id" = "weekly_schedule"."teacher_id"
 group by "teachers"."id";