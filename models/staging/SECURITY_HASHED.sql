
WITH
    staging as (
        SELECT
            'seed.securities' as RECORD_SOURCE,
            '2020-06-07 22:00:00.000'::timestamp as LOAD_TS,
            '2020-01-01 00:00:00.000'::timestamp as EFFECTIVE_FROM,
            {{ dbt_utils.surrogate_key(['symbol']) }} as SECURITY_PK,
            securities.*
        FROM {{ ref('securities') }}
    )

SELECT * FROM staging
