
-- Use the `ref` function to select from other models

select *
from "sales_db"."raw_sales"."my_first_dbt_model"
where id = 1