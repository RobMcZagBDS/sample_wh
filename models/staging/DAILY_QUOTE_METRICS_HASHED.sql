WITH
raw_quotes AS (
    SELECT * FROM {{ source('spytm', 'daily_quote') }}
),
quote_values AS (
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
        avg(volume) as avg_volume
    FROM raw_quotes
    GROUP BY symbol
)
SELECT
    symbol,
    min_date,
    max_date,
    num_quotes,
    min_open,
    max_open,
    min_close,
    max_close,
    min_low,
    max_high,
    avg_open,
    avg_close,
    min_volume,
    max_volume,
    avg_volume,
    'spytm.daily_quote' as RECORD_SOURCE,
    (qv.max_date||' 16:30:00.000')::timestamp as LOAD_TS,
    qv.max_date as EFFECTIVE_FROM,
    {{ dbt_utils.surrogate_key(['symbol']) }} as SECURITY_PK,
    {{ dbt_utils.surrogate_key(['min_date', 'max_date', 'num_quotes', 'min_open', 'max_open', 'min_close',
        'max_close', 'min_low', 'max_high', 'avg_open', 'avg_close', 'min_volume', 'max_volume', 'avg_volume'
        ]) }} as QUOTE_METRICS_HASHDIFF

FROM quote_values as qv
