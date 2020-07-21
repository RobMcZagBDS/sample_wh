WITH
    raw_quotes AS (
        SELECT * FROM {{ source('spytm', 'daily_quote') }}
        WHERE quotetype = 'DAILY_ADJUSTED' OR quotetype = 'DAILY'
    )

SELECT
    'spytm.daily_quote:' || rq.provider || '/' || rq.quotetype as RECORD_SOURCE,
    current_timestamp                                                      as LOAD_TS,
    rq.date                                                          as EFFECTIVE_FROM,
    {{ dbt_utils.surrogate_key(['symbol']) }} as SECURITY_PK,
    {{ dbt_utils.surrogate_key(['symbol', 'date']) }} as DAILY_QUOTE_PK,
    {{ dbt_utils.surrogate_key(['open', 'close', 'low', 'high', 'volume']) }} as DAILY_QUOTE_HDiff,
    rq.*
FROM raw_quotes as rq