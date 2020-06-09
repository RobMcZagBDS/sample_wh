WITH
    ib as (
        SELECT * FROM {{ ref('ib_info') }}
    ),
    parsed as (
        SELECT
            split_part(ib.financialinstrument, ' ', 1) as symbol,
            split_part(ib.financialinstrument, ' ', 2) as ib_exchange,
            ib.notes,
            ib.sector,
            ib.industry,
            ib.category,
            -- ib.position,
            -- ib.avgprice,
            -- ib.last,
            -- ib.analysttarget_pricedisparitypct,
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
            ib.price_52weekpricepercentchange
        FROM ib
    )
SELECT
    'seed.ib_info' as RECORD_SOURCE,
    '2020-06-07 21:00:00.000'::timestamp as LOAD_TS,
    '2020-01-01 00:00:00.000'::timestamp as EFFECTIVE_FROM,
    {{ dbt_utils.surrogate_key(['symbol']) }} as SECURITY_PK,
    {{ dbt_utils.surrogate_key(['ib_exchange', 'notes', 'sector', 'industry','category', 'averagepricetarget', 'numberoftargets',
                                'p_e', 'quickratio', 'epsgrowthpct', 'revenuegrowthratepct', 'returnonequitypct',
                                'returnoninvestmentpct', 'cashflowpershare', 'payoutratiopct',
                                'dividends', 'dividendyieldpct', 'dividendyield_5yravg', 'dividenddate', 'dividendamount',
                                'beta', 'price_52weeklow', 'price_52weekhigh', 'price_1weekpricepercentchange',
                                'price_4weekpricepercentchange', 'price_52weekpricepercentchange'
                                ] ) }} as IB_INFO_HASHDIFF,
    parsed.*
FROM parsed