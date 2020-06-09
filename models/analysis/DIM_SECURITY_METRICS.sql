WITH
    hub as (
        SELECT * FROM {{ ref('HUB_SECURITY') }}
    ),
    sat_metrics as (
        SELECT * FROM {{ ref('SAT_SECURITY_METRICS') }}
    ),
    sat_info_ib as (
        SELECT * FROM {{ ref('SAT_SECURITY_INFO_IB') }}
    )
SELECT
    hub.security_pk,
    hub.symbol,

    metrics.min_date,
    metrics.max_date,
    metrics.num_quotes,
    metrics.min_open,
    metrics.max_open,
    metrics.min_close,
    metrics.max_close,
    metrics.min_low,
    metrics.max_high,
    metrics.avg_open,
    metrics.avg_close,
    metrics.min_volume,
    metrics.max_volume,
    metrics.avg_volume,
    metrics.effective_from,
    metrics.load_ts,
    metrics.record_source,

    ib.averagepricetarget,
    ib.numberoftargets,
    ib.p_e,
    ib.quickratio,
    ib.epsgrowthpct,
    ib.revenuegrowthratepct,
    ib.returnonequitypct,
    ib.returnoninvestmentpct,
    ib.cashflowpershare,
    ib.payoutratiopct,
    ib.dividends,
    ib.dividendyieldpct,
    ib.dividendyield_5yravg,
    ib.dividenddate,
    ib.dividendamount,
    ib.beta,
    ib.price_52weeklow,
    ib.price_52weekhigh,
    ib.price_1weekpricepercentchange,
    ib.price_4weekpricepercentchange,
    ib.price_52weekpricepercentchange,

    ib.effective_from as ib_effective_from,
    ib.load_ts as ib_load_ts,
    ib.record_source as ib_record_source

FROM hub
         LEFT JOIN sat_metrics as metrics ON (hub.security_pk = metrics.security_pk)
         LEFT JOIN sat_info_ib as ib ON (hub.security_pk = ib.security_pk)