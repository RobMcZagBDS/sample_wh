
{{  dbtvault.link(
        src_pk = 'DAILY_QUOTE_PK',
        src_fk = ['SECURITY_PK', 'date'],
        src_ldts = 'LOAD_TS',
        src_source = 'RECORD_SOURCE',
        source_model = 'DAILY_QUOTE_HASHED'
    )
}}
