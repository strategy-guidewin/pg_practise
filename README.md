# pg_practise
pg_practise docker

```bash
cd postgres_interview_lab
docker compose up -d --build
```

```bash
docker exec -it postgres_interview_lab \
  psql -U postgres -d interview_lab
```

```bash

\l or \l+

\c

\dt

exercises.sql

psql -U user_name -d database_name -f file.sql

docker exec -it postgres_interview_lab \
  psql -U postgres -d interview_lab  -f file.sql

psql -U postgres -d my_database -f /path/to/setup.sql

\i /path/to/setup.sql

```

Requirements
------------
Docker Desktop or Docker Engine with Docker Compose.

Start the lab
-------------

From this directory:

    docker compose up -d --build

Connect using psql
------------------

    docker exec -it postgres_interview_lab \
      psql -U postgres -d interview_lab

Useful commands
---------------

List tables:

    \dt

Describe a table:

    \d orders

Run a query:

    SELECT * FROM customers;

Exit psql:

    \q

Stop lab:

    docker compose down

Stop and delete database data:

    docker compose down -v

Rebuild from scratch:

    docker compose down -v
    docker compose up -d --build

Files
-----

init/01_schema.sql
    Creates the practice schema.

init/02_seed.sql
    Loads sample data.

exercises.sql
    Contains 14 broken queries plus bonus exercises.

answers.sql
    Corrected versions and short explanations.

Suggested practice
------------------

Do not open answers.sql at first.

For each exercise:
1. Run the broken query.
2. Inspect the result.
3. Explain why it is wrong.
4. Rewrite it.
5. Compare your answer with answers.sql.

For performance exercises, also try:

    EXPLAIN (ANALYZE, BUFFERS)
    SELECT ...;

The data set is deliberately small for logic practice.
You can later expand it for query-plan and indexing practice.

---
