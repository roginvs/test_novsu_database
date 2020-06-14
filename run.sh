
#!/bin/bash

cat init.pgsql | docker exec -i psql psql -U postgres
cat schema.pgsql data.pgsql | docker exec -i psql psql -U postgres rogin

cat queries.pgsql | docker exec -i psql psql -U postgres rogin

cat trigger*.pgsql | docker exec -i psql psql -U postgres rogin

cat view*.pgsql | docker exec -i psql psql -U postgres rogin
