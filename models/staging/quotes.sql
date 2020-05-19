
select * from {{ source('spytm', 'daily_quote') }}