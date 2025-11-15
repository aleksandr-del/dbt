# dbt PostgreSQL Project

A complete dbt (data build tool) development environment with PostgreSQL database, containerized using Docker Compose.

## Project Structure

```
├── test_dbt_project/          # Main dbt project directory
│   └── test_dbt_project/
│       ├── models/            # dbt models (SQL transformations)
│       ├── tests/             # Data quality tests
│       ├── macros/            # Reusable SQL macros
│       ├── seeds/             # CSV files for reference data
│       └── dbt_project.yml    # Project configuration
├── .dbt/
│   └── profiles.yml           # Database connection profiles
├── docker-compose.yml         # Docker services configuration
├── .env                       # Environment variables
└── requirements.txt           # Python dependencies
```

## Services

- **PostgreSQL 17**: Main database (port 5433)
- **dbt-postgres**: dbt transformation engine
- **pgAdmin**: Database management interface (port 5050)

## Quick Start

1. **Initialize dbt project (if needed):**
   ```bash
   docker compose run --rm dbt init test_dbt_project
   ```

2. **Start the services:**
   ```bash
   docker compose up --detach
   ```


## dbt Commands

### Build Models
Compiles and executes all dbt models, creating tables and views in PostgreSQL according to your model definitions:
```bash
docker compose run --rm dbt run --project-dir /usr/app/test_dbt_project
```

### Run Tests
Executes all configured data quality tests (uniqueness, null checks, data consistency). Tests validate data without modifying it:
```bash
docker compose run --rm dbt test --project-dir /usr/app/test_dbt_project
```

### Full Refresh
Drops and recreates all tables/materialized views instead of incremental updates. Useful after major model changes:
```bash
docker compose run --rm dbt run --project-dir /usr/app/test_dbt_project --full-refresh
```

### Interactive Shell
Access the dbt container for debugging, running multiple commands, or exploring the environment:
```bash
docker compose run --rm --entrypoint /bin/bash dbt
```

## Database Access

- **pgAdmin**: http://localhost:5050
- **PostgreSQL**: localhost:5433
- **Credentials**: Check `.env.example` file

## Development

The project includes example models demonstrating:
- Basic data transformations
- Model references using `{{ ref() }}`
- Data quality tests
- Model materialization strategies

Start by modifying files in `test_dbt_project/test_dbt_project/models/` or create new ones following dbt conventions.

## Environment Variables

Configure database connection and ports in `.env`:
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`
- `POSTGRES_PORT`, `PGADMIN_PORT`, `DBT_POSTGRES_PORT`
- `DBT_HOST_PROJECT_DIR`, `DBT_HOST_PROFILES_FILE`, `DBT_WORKDIR`
