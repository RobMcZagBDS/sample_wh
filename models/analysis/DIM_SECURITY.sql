WITH
hub as (
    SELECT * FROM {{ ref('HUB_SECURITY') }}
),
sat_base as (
    SELECT * FROM {{ ref('SAT_SECURITY_BASE') }}
),
sat_info_ib as (
    SELECT * FROM {{ ref('SAT_SECURITY_INFO_IB') }}
)
SELECT
    hub.security_pk,
    hub.symbol,
    base.description,
    base.exchange,
    base.type,
    base.underlying,
    base.multiplier,
    base.minimum,
    base.expiration,
    base.effective_from,
    base.load_ts,
    base.record_source,
    ib.ib_exchange,
    ib.notes,
    ib.sector,
    ib.industry,
    ib.category
FROM hub
LEFT JOIN sat_base as base ON (hub.security_pk = base.security_pk)
LEFT JOIN sat_info_ib as ib ON (hub.security_pk = ib.security_pk)
