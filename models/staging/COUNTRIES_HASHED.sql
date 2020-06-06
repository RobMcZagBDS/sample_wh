{%  set load_ts = "'2020-06-06 13:39:44.466902'::timestamp"  %}

WITH
source as (
    SELECT * FROM {{ ref('countries') }}
),
staging as (
    SELECT
        'SEEDS.countries' as RECORD_SOURCE,
        {{ load_ts }} as LOAD_TS,
        {{ dbt_utils.surrogate_key(['country_name']) }} as COUNTRY_HKey,
        source.*
    FROM source
)

SELECT * FROM staging
