
WITH
    source as (
        SELECT * FROM {{ ref('countries') }}
    ),
    staging as (
        SELECT
            'SEEDS:countries' as RECORD_SOURCE,
            '2020-01-01 00:00:00.000'::timestamp as LOAD_TS,
            '1999-09-09'::date as EFFECTIVE_FROM,
            {{ dbt_utils.surrogate_key(['country_code_3_letter']) }} as COUNTRY_HKey,
            {{ dbt_utils.surrogate_key(['country_name', 'country_code_2_letter', 'country_code_numeric', 'iso_3166_2',
                                        'region', 'sub_region', 'intermediate_region']
                ) }} as COUNTRY_HASHDIFF,
            source.*
        FROM source
    )

SELECT * FROM staging
