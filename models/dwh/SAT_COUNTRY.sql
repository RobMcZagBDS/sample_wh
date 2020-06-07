
{{  dbtvault.sat(
        src_pk = 'COUNTRY_HKey',

        src_hashdiff = 'COUNTRY_HASHDIFF',
        src_payload =
            ['country_name', 'country_code_2_letter', 'country_code_numeric', 'iso_3166_2',
            'region', 'sub_region', 'intermediate_region'],
        src_eff = None,
        src_ldts = 'LOAD_TS',
        src_source = 'RECORD_SOURCE',
        source_model = 'COUNTRIES_HASHED'
    )
}}