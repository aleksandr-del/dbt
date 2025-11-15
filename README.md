# dbt PostgreSQL Project with Instacart Dataset

A complete dbt (data build tool) development environment with PostgreSQL database and real-world Instacart Market Basket Analysis dataset, containerized using Docker Compose.

## Project Structure

```
├── test_dbt_project/          # Main dbt project directory
│   └── test_dbt_project/
│       ├── models/            # dbt models (SQL transformations)
│       ├── tests/             # Data quality tests
│       ├── macros/            # Reusable SQL macros
│       ├── seeds/             # CSV files for reference data
│       └── dbt_project.yml    # Project configuration
├── initdb/                    # Database initialization files
│   ├── pre-seed.sql          # Creates tables and loads CSV data
│   ├── aisles.csv            # Product aisles (134 categories)
│   ├── departments.csv       # Store departments (21 departments)
│   ├── products.csv          # Product catalog (~50k products)
│   ├── orders.csv            # Customer orders (~3.4M orders)
│   ├── order_products__*.csv # Order line items (~33M records)
├── .dbt/
│   └── profiles.yml           # Database connection profiles
├── docker-compose.yml         # Docker services configuration
├── download-instacart-data.sh # Script to download Instacart dataset
├── .env                       # Environment variables
└── requirements.txt           # Python dependencies
```

## Dataset

This project uses the **Instacart Market Basket Analysis** dataset, which contains real e-commerce data including:

- **Orders**: 3.4M grocery orders from 200k+ users
- **Products**: 50k products across 134 aisles and 21 departments  
- **Order Products**: 33M order line items with reorder patterns
- **User Behavior**: Order timing, frequency, and shopping patterns

The dataset is automatically loaded into a `raw` schema with proper relationships and foreign keys.

## Services

- **PostgreSQL 17**: Main database (port 5433)
- **dbt-postgres**: dbt transformation engine
- **pgAdmin**: Database management interface (port 5050)

## Quick Start

1. **Download the Instacart dataset (optional - data is included):**
   ```bash
   ./download-instacart-data.sh
   ```

2. **Initialize dbt project (if needed):**
   ```bash
   docker compose run --rm dbt init test_dbt_project
   ```

3. **Start the services:**
   ```bash
   docker compose up --detach
   ```

The PostgreSQL container will automatically:
- Create the `raw` schema
- Load all CSV files into database tables
- Set up proper relationships and indexes


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

## Database Schema

The `raw` schema contains the following tables:

- `raw.aisles` - Product categories (aisle_id, aisle)
- `raw.departments` - Store departments (department_id, department)  
- `raw.products` - Product catalog with aisle/department references
- `raw.orders` - Customer orders with timing and user info
- `raw.order_products` - Order line items with reorder flags

## Development

The project includes example models demonstrating:
- Basic data transformations
- Model references using `{{ ref() }}`
- Data quality tests
- Model materialization strategies

Start by modifying files in `test_dbt_project/test_dbt_project/models/` or create new ones following dbt conventions.

**Example Analytics Use Cases:**
- Customer segmentation and lifetime value
- Product recommendation systems
- Market basket analysis
- Reorder prediction models
- Sales forecasting and trends

## Environment Variables

Configure database connection and ports in `.env`:
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`
- `POSTGRES_PORT`, `PGADMIN_PORT`, `DBT_POSTGRES_PORT`
- `DBT_HOST_PROJECT_DIR`, `DBT_HOST_PROFILES_FILE`, `DBT_WORKDIR`
