WITH raw_quotes AS (
    SELECT * FROM {{ source('spytm', 'daily_quote') }}
)
SELECT
    symbol,
    min(date) as min_date,
    max(date) as max_date,
    count(date) as num_quotes,
    min(open) as min_open,
    max(open) as max_open,
    min(close) as min_close,
    max(close) as max_close,
    min(low) as min_low,
    max(high) as max_high,
    avg(open) as avg_open,
    avg(close) as avg_close,
    min(volume) as min_volume,
    max(volume) as max_volume,
    avg(volume) as avg_volume,
    'spytm.daily_quote' as RECORD_SOURCE,
    (max(date)||' 16:30:00.000')::timestamp as LOAD_TS,
    max(date) as EFFECTIVE_FROM,
    {{ dbt_utils.surrogate_key(['symbol']) }} as SECURITY_PK
FROM raw_quotes
GROUP BY symbol
