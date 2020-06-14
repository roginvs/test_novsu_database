
#!/bin/bash

echo "======== Initialization ======== "
cat init.pgsql | docker exec -i psql psql -U postgres

echo "======== Schema ======== "
cat schema.pgsql | docker exec -i psql psql -U postgres rogin

echo "======== Demo data ======== "
cat data.pgsql | docker exec -i psql psql -U postgres rogin

echo "======== Queries======== "
cat queries.pgsql | docker exec -i psql psql -U postgres rogin


for f in trigger*.pgsql; do
  echo "======== Triggers $f ======== "
  cat $f | docker exec -i psql psql -U postgres rogin
done

for f in view*.pgsql; do
  echo "======== Views $f ======== "
  cat $f | docker exec -i psql psql -U postgres rogin
done

