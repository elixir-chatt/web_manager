# Dockerized Elixir/Phoenix Development Environment

### Support for VS Code Remote Extension
After cloning this repository, open the folder in Visual Studio Code's Remote Extension to get a
full Development Environment (with PostgreSQL Database) spun up automatically.

See [https://code.visualstudio.com/docs/remote/containers](https://code.visualstudio.com/docs/remote/containers)
for more details.

## Getting Started

### Alternative: Existing Application
Copy your existing code Phoenix application code to the `src/` directory in the cloned repository.

**NOTE:** the `src/` directory won't exist so you'll have to create it first.


### Database

#### Preparation
The `docker-compose.yml` file defines a database service container named `db` running a PostgreSQL database that is available to the main application container via the hostname `db`. By default Phoenix assumes that you are running a database locally.

Modify the Ecto configuration `src/config/dev.exs` to point to the DB container:
```
# Configure your database
config :test, Test.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "test_dev",
  hostname: "db",
  pool_size: 10
```

#### Initialize the Database with Ecto
When you first start out, the `db` container will have no databases. Let's initialize a development DB using Ecto:
```
./mix ecto.create
```

If you copied an existing application, now would be the time to run your database migrations.
```
./mix ecto.migrate
```


### Starting the Application
Starting your application is incredibly easy:
```
docker-compose up
```
Once up, it will be available under http://localhost:4000


## Notes

### Executing custom commands
To run commands other than `mix` tasks, you can use the `./run` script.
```
./run iex -S mix
```
