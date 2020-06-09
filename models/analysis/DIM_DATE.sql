WITH
ref as (
    SELECT * FROM {{ ref('DATE_CALENDAR') }}
)
SELECT * FROM ref