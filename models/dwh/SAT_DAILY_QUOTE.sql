
{{  dbtvault.sat(
        src_pk = 'DAILY_QUOTE_PK',

        src_hashdiff = 'DAILY_QUOTE_HDiff',
        src_payload = [ 'open', 'close', 'low', 'high', 'volume',       'date', 'symbol'],

        src_eff = 'EFFECTIVE_FROM',
        src_ldts = 'LOAD_TS',
        src_source = 'RECORD_SOURCE',
        source_model = 'DAILY_QUOTE_HASHED'
    )
}}