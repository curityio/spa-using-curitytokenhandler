# Updating Keycloak Data

Keycloak is deployed in this example with a Postgres database.

## Querying

After running the `external-client` deployment scenario, you can get a Postgres container shell like this:

```bash
POSTGRES_CONTAINER_ID=$(docker ps | grep postgres | awk '{print $1}')
docker exec -it $POSTGRES_CONTAINER_ID bash
```

Then connect to the database:

```bash
export PGPASSWORD=Password1 && psql -p 5432 -d keycloak -U postgres
```

Then run `\dt` to get to know the Keycloak schema, via tables such as these:

| Table | Contains |
| ----- | -------- |
| client | Details abour registered clients |
| user_entity | The starting point for user accounts |
| authentication_flow | Various authentication behaviors including verification,  |
| protocol_mapper | The starting point for claims |

## Backup

When changes are made in the admin UI, backup the data like this to replace the `data-backup.sql` file:

```bash
POSTGRES_CONTAINER_ID=$(docker ps | grep postgres | awk '{print $1}')
docker exec -it $POSTGRES_CONTAINER_ID bash -c "export PGPASSWORD=Password1 && pg_dump -U postgres -d keycloak" > ./data-backup.sql
```
