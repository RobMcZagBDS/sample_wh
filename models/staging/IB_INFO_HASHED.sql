WITH
    ib as (
        SELECT * FROM {{ ref('ib_info') }}
    ),
    parsed as (
        SELECT
            split_part(ib.financialinstrument, ' ', 1) as symbol,
            split_part(ib.financialinstrument, ' ', 2) as ib_exchange,
            ib.*
        FROM ib
    )
SELECT
    'seed.ib_info' as RECORD_SOURCE,
    '2020-06-07 21:00:00.000'::timestamp as LOAD_TS,
    '2020-01-01 00:00:00.000'::timestamp as EFFECTIVE_FROM,
    {{ dbt_utils.surrogate_key(['symbol']) }} as SECURITY_PK,
    parsed.*
FROM parsed