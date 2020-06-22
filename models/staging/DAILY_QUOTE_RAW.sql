
WITH
    daily_quotes AS (
        SELECT * FROM {{ source('spytm', 'daily_quote') }}
            WHERE quotetype = 'DAILY_ADJUSTED' OR quotetype = 'DAILY'
    ),
    sat AS (
        SELECT
            symbol,
            min(date) as minDate,
            max(date) as maxDate
        FROM rz_dwh."SAT_DAILY_QUOTE"
        GROUP BY symbol
    )
SELECT dq.*
FROM daily_quotes dq
LEFT JOIN sat ON (dq.symbol = sat.symbol)
WHERE   (dq.date >= sat.maxDate OR sat.maxDate is null)
   OR   (dq.date < sat.minDate OR sat.minDate is null)