CREATE EXTENSION postgres_fdw;

SET ROLE dw_owner;

CREATE SERVER spytm
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'h-name', port '5432', dbname 'db-name');

CREATE USER MAPPING FOR dbt_executor
    SERVER spytm
    OPTIONS (USER 'u-name', PASSWORD 'u-pw');

CREATE USER MAPPING FOR dw_owner
    SERVER spytm
    OPTIONS (USER 'u-name', PASSWORD 'u-pw');

/* Import all tables -except excluded- into local schema */
CREATE SCHEMA spytm;

IMPORT FOREIGN SCHEMA spytm EXCEPT (flyway_schema_history)
    FROM SERVER spytm INTO spytm;