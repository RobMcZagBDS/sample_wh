ALTER SCHEMA dbt_rz OWNER TO dw_owner;
GRANT ALL ON SCHEMA dbt_rz TO dbt_executor;
GRANT ALL ON ALL TABLES IN SCHEMA dbt_rz TO dbt_executor;

ALTER SCHEMA spytm OWNER TO dw_owner;
GRANT USAGE ON SCHEMA spytm TO dbt_executor;
GRANT SELECT ON ALL TABLES IN SCHEMA spytm TO dbt_executor;
