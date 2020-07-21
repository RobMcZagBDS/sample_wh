{% snapshot quote_lnk_load_dates %}

{{
    config(
      unique_key='load_ts',
      strategy='timestamp',
      updated_at = 'load_ts'
    )
}}

SELECT distinct load_ts FROM {{ ref('LNK_DAILY_QUOTE') }}   -- rz_dwh."LNK_DAILY_QUOTE"

{% endsnapshot %}
