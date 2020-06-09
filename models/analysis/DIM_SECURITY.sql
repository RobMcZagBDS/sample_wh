WITH
hub as (
    SELECT * FROM {{ ref('HUB_SECURITY') }}
),
sat as (
    SELECT * FROM {{ ref('SAT_SECURITY_BASE') }}
)
SELECT
    hub.security_pk,
    hub.symbol,
    sat.description,
    sat.exchange,
    sat.type,
    sat.underlying,
    sat.multiplier,
    sat.minimum,
    sat.expiration,
    sat.effective_from,
    sat.load_ts,
    sat.record_source
FROM hub
LEFT JOIN sat ON (hub.security_pk = sat.security_pk)
