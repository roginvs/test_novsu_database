
#!/bin/bash

cat init.pgsql | docker exec -i psql psql -U postgres
cat schema.pgsql data.pgsql | docker exec -i psql psql -U postgres rogin

cat queries.pgsql | docker exec -i psql psql -U postgres rogin

cat triggers.pgsql | docker exec -i psql psql -U postgres rogin