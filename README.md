## 1. РАЗРАБОТКА ЛОГИЧЕСКОЙ МОДЕЛИ ПРЕДМЕТНОЙ ОБЛАСТИ

```

- students
  - name
  - group_id

- groups
  - name
  - speciality_id

- specialities
  - name
  - distiction_id

- distictions
  - name

- teachers
  - first_name
  - last_name
  - phone_number
  - experience_cumulative
  - experience_current_started_at

- lesson_types : lecture or practice

- courses (предметы)
  - name

- teachers_abilities (unique concurrently)
  - teacher_id
  - course_id

- timeslots : weekly slots

- weekly_schedule
  - timeslot_id
  - group_id
  - teacher_id
  - course_id
  - lesson_type_id
    (check uniqueness: timeslot+group_id, timeslot+teacher_id)
    (check courseId+teacherId)
    foreign keys:
      - timeslot_id
      - group_id
      - teacher_id, course_id



- tariffs
  - course_id
  - lesson_type_id
  - price

```

## 2. РАЗРАБОТКА ФИЗИЧЕСКОЙ МОДЕЛИ ДАННЫХ И РЕАЛИЗАЦИЯ БАЗЫ ДАННЫХ

## 3. ФОРМИРОВАНИЕ SQL-ЗАПРОСОВ

## 4. ДОБАВЛЕНИЕ ТРИГГЕРОВ В БАЗУ ДАННЫХ

## 5. СОЗДАНИЕ ПРЕДСТАВЛЕНИЙ В БАЗЕ ДАННЫХ
