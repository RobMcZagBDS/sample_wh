WITH
dim_security as (
    SELECT * FROM {{ ref('DIM_SECURITY') }}
),
dim_date as (
    SELECT * FROM {{ ref('DIM_DATE') }}
),
fact_quote as (
    SELECT * FROM {{ ref('FACT_QUOTE') }}
)
SELECT q.*
FROM fact_quote q
INNER JOIN dim_security s ON (q.security_pk = s.security_pk)
INNER JOIN dim_date d ON (q.date = d.date_day)
WHERE
    s.symbol = 'AM'
    and d.year_actual = 2020
ORDER BY date DESC ;
