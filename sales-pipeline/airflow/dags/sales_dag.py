from datetime import datetime
from pathlib import Path
from cosmos import DbtDag, ProjectConfig, ProfileConfig, RenderConfig, ExecutionConfig
from cosmos.profiles import PostgresUserPasswordProfileMapping
from cosmos.constants import LoadMode

DBT_PROJECT_PATH = Path("/usr/local/airflow/dbt/dbt_sales")

# Connect database
profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=PostgresUserPasswordProfileMapping(
        conn_id="my_postgres_conn", 
        profile_args={"schema": "public"},
    ),
)

execution_config = ExecutionConfig(
    dbt_executable_path="/usr/local/bin/dbt",
)


dbt_sales_cosmos_dag = DbtDag(
    project_config=ProjectConfig(
        DBT_PROJECT_PATH,
    ),
    profile_config=profile_config,
    execution_config=execution_config,
    render_config=RenderConfig(
        load_method=LoadMode.DBT_LS, 
        select=["path:seeds", "path:models"] 
    ),
    operator_args={
        "install_deps": True, 
    },
    schedule="@daily",
    start_date=datetime(2024, 1, 1),
    catchup=False,
    dag_id="dbt_sales_cosmos",
)