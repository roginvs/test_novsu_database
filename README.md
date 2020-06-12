## 1. РАЗРАБОТКА ЛОГИЧЕСКОЙ МОДЕЛИ ПРЕДМЕТНОЙ ОБЛАСТИ

- students

  - name
  - groupId

- groups

  - name
  - specialityId

- specialities

  - name
  - distinctId

- distictions

  - name

- teachers

  - name
  - lastname
  - phone
  - experience (startedAt ?)

- lessonTypes

- timeslots

- weekly_schedule

  - timeslotId
  - groupId
  - teacherId
  - courseId
  - lessonTypeId
    (check uniqueness: timeslot+groupId, timeslo+teacherId)
    (check courseId+teacherId)

- courses (предметы)

- teachersAbilities

  - teacherId
  - courseId

- tariffs
  - courseId
  - lessonTypeId
  - price

## 2. РАЗРАБОТКА ФИЗИЧЕСКОЙ МОДЕЛИ ДАННЫХ И РЕАЛИЗАЦИЯ БАЗЫ ДАННЫХ

## 3. ФОРМИРОВАНИЕ SQL-ЗАПРОСОВ

## 4. ДОБАВЛЕНИЕ ТРИГГЕРОВ В БАЗУ ДАННЫХ

## 5. СОЗДАНИЕ ПРЕДСТАВЛЕНИЙ В БАЗЕ ДАННЫХ
