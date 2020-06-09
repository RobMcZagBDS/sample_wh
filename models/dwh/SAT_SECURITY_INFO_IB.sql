{{  dbtvault.sat(
        src_pk = 'SECURITY_PK',

        src_hashdiff = 'IB_INFO_HASHDIFF',
        src_payload =
            ['ib_exchange', 'notes', 'sector', 'industry','category', 'averagepricetarget', 'numberoftargets',
            'p_e', 'quickratio', 'epsgrowthpct', 'revenuegrowthratepct', 'returnonequitypct',
            'returnoninvestmentpct', 'cashflowpershare', 'payoutratiopct',
            'dividends', 'dividendyieldpct', 'dividendyield_5yravg', 'dividenddate', 'dividendamount',
            'beta', 'price_52weeklow', 'price_52weekhigh', 'price_1weekpricepercentchange',
            'price_4weekpricepercentchange', 'price_52weekpricepercentchange' ],
        src_eff = 'EFFECTIVE_FROM',
        src_ldts = 'LOAD_TS',
        src_source = 'RECORD_SOURCE',
        source_model = 'IB_INFO_HASHED'
    )
}}