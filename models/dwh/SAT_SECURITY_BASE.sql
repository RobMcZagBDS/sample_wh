{{  dbtvault.sat(
        src_pk = 'SECURITY_PK',

        src_hashdiff = 'SECURITY_HASHDIFF',
        src_payload =
            ['description', 'exchange', 'type', 'underlying',
            'multiplier', 'minimum', 'expiration'],

        src_eff = 'EFFECTIVE_FROM',
        src_ldts = 'LOAD_TS',
        src_source = 'RECORD_SOURCE',
        source_model = 'SECURITY_HASHED'
    )
}}