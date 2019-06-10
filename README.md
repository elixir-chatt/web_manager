# To start the app
`docker-compose up`

# Postgres through docker

`docker run --name some-postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=web_manager_dev -p 5432 -d postgres`
