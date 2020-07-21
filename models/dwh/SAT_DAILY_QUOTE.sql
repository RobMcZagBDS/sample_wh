-- depends_on: {{ ref('DAILY_QUOTE_HASHED_INCR') }} {{ ref('DAILY_QUOTE_HASHED_FULL') }}

{{ config(materialized='incremental') }}

{% if is_incremental() %} {%  set source_table_name = 'DAILY_QUOTE_HASHED_INCR' %}
{% else %} {%  set source_table_name = 'DAILY_QUOTE_HASHED_FULL' %}
{% endif %}

{{  dbtvault.sat(
        src_pk = 'DAILY_QUOTE_PK',

        src_hashdiff = 'DAILY_QUOTE_HDiff',
        src_payload = [ 'open', 'close', 'low', 'high', 'volume',       'date', 'symbol'],

        src_eff = 'EFFECTIVE_FROM',
        src_ldts = 'LOAD_TS',
        src_source = 'RECORD_SOURCE',
        source_model = source_table_name
    )
}}