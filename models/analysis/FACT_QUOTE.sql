WITH
lnk as (
    SELECT * FROM {{ ref('LNK_DAILY_QUOTE') }}
),
sat as (
    SELECT * FROM {{ ref('SAT_DAILY_QUOTE') }}
)
SELECT
    lnk.security_pk,
    sat.symbol,         -- stored in sat to avoid HUB lookup
    sat.date,           -- stored in sat to avoid HUB lookup
    sat.open,
    sat.close,
    sat.low,
    sat.high,
    sat.volume,
    sat.effective_from,
    sat.load_ts,
    sat.record_source
FROM lnk
LEFT JOIN sat ON (lnk.daily_quote_pk = sat.daily_quote_pk)