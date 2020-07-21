-- depends_on: {{ ref('DAILY_QUOTE_HASHED_INCR') }} {{ ref('DAILY_QUOTE_HASHED_FULL') }}

{{ config(materialized='incremental') }}

{% if is_incremental() %} {%  set source_table_name = 'DAILY_QUOTE_HASHED_INCR' %}
{% else %} {%  set source_table_name = 'DAILY_QUOTE_HASHED_FULL' %}
{% endif %}

{{  dbtvault.link(
        src_pk = 'DAILY_QUOTE_PK',
        src_fk = ['SECURITY_PK', 'date'],
        src_ldts = 'LOAD_TS',
        src_source = 'RECORD_SOURCE',
        source_model = source_table_name
    )
}}
