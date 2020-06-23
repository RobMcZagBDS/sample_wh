{% snapshot quote_snapshot %}

{{
    config(
      unique_key='quote_id',
      strategy='check',
      check_cols = 'all'
    )
}}

select
    {{ dbt_utils.surrogate_key(['provider', 'quotetype', 'symbol', 'date']) }} as quote_id,
    *
from {{ source('spytm', 'daily_quote') }}

{% endsnapshot %}