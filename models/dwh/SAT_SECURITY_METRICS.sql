{{  dbtvault.sat(
        src_pk = 'SECURITY_PK',

        src_hashdiff = 'QUOTE_METRICS_HASHDIFF',
        src_payload =
            ['min_date', 'max_date', 'num_quotes', 'min_open', 'max_open', 'min_close', 'max_close',
             'min_low', 'max_high', 'avg_open', 'avg_close', 'min_volume', 'max_volume', 'avg_volume' ],
        src_eff = 'EFFECTIVE_FROM',
        src_ldts = 'LOAD_TS',
        src_source = 'RECORD_SOURCE',
        source_model = 'DAILY_QUOTE_METRICS_HASHED'
    )
}}