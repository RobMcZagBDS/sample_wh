
{{  dbtvault.hub(
        src_pk = 'SECURITY_PK',
        src_nk = 'symbol',
        src_ldts = 'LOAD_TS',
        src_source = 'RECORD_SOURCE',
        source_model = ['SECURITY_HASHED', 'IB_INFO_HASHED', 'QUOTE_METRICS_HASHED']
    )
}}