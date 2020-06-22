/*
    Calendar Weeks and Weekdays
    https://docs.snowflake.com/en/sql-reference/functions-date-time.html#label-calendar-weeks-weekdays

    The behavior of week-related functions in Snowflake is controlled by the WEEK_START and WEEK_OF_YEAR_POLICY session parameters.
-- ALTER SESSION SET WEEK_START = 1 ;      -- set week start on Monday. Default is 0 = Sunday.

    An important aspect of understanding how these parameters interact is the concept of ISO weeks.

    ISO Weeks
    As defined in the ISO 8601standard (for dates and time formats), ISO weeks always start on Monday and
    “belong” to the year that contains the Thursday of that week.

    Snowflake provides a special set of week-related date functions (and equivalent data parts)
    whose behavior is consistent with the ISO week semantics: DAYOFWEEKISO , WEEKISO , YEAROFWEEKISO.
    These functions (and date parts) disregard the session parameters (i.e. they always follow the ISO semantics).
 */

{{ config(materialized='table') }}


WITH
date_spine AS (
    {{
        dbt_utils.date_spine(
             datepart="day",
             start_date="to_date('01/01/2000', 'mm/dd/yyyy')",
             end_date="to_date('12/31/2030', 'mm/dd/yyyy')",
        )
    }}
),

calculation as (
    SELECT
        date_day::DATE,

        TO_CHAR(date_day, 'Dy') AS day_name,
        TO_CHAR(date_day, 'Mon') AS month_name,

        EXTRACT(day FROM date_day)::int AS day,
        EXTRACT(month FROM date_day)::int AS month,
        EXTRACT(quarter FROM date_day)::int AS quarter_number,
        EXTRACT(year FROM date_day)::int AS year,

        DATE_TRUNC('week', date_day)::DATE as first_day_of_week,  -- Mon
        (DATE_TRUNC('week', date_day) + INTERVAL '1 WEEK - 1 day')::DATE as last_day_of_week,  -- Mon  based ???

        DATE_TRUNC('month', date_day)::DATE AS first_day_of_month,
        (DATE_TRUNC('month', date_day) + INTERVAL '1 MONTH - 1 day')::DATE as last_day_of_month,

        DATE_TRUNC('quarter', date_day)::DATE AS first_day_of_quarter,
        (DATE_TRUNC('quarter', date_day) + INTERVAL '3 MONTH - 1 day')::DATE AS last_day_of_quarter,

        DATE_TRUNC('year', date_day)::DATE AS first_day_of_year,
        (DATE_TRUNC('year', date_day) + INTERVAL '1 YEAR - 1 day')::DATE AS last_day_of_year,

        EXTRACT(week FROM date_day)::int AS week_of_year,

        -- The year to which the week belongs to, according to ISO rules.
        EXTRACT(isoyear FROM date_day)::int AS year_of_week,

        EXTRACT(ISODOW FROM date_day)::int AS day_of_week, -- Day of week =>  Mon 1 - Sun 7
        EXTRACT(doy FROM date_day)::int AS day_of_year,

        EXTRACT(DAY FROM (date_day - DATE_TRUNC('quarter', date_day)))::int +1 AS day_of_quarter,
        EXTRACT(DAY FROM (DATE_TRUNC('quarter', date_day + INTERVAL '3 MONTH') - DATE_TRUNC('quarter', date_day)))::int AS days_in_quarter,
        EXTRACT(DAY FROM (DATE_TRUNC('year', date_day + INTERVAL '1 YEAR') - DATE_TRUNC('year', date_day)))::int AS days_in_year,

        /* ** HOLIDAYS ** */
        (CASE   WHEN EXTRACT(MONTH FROM date_day) = 1 AND EXTRACT(DAY FROM date_day) = 1 THEN 'New Year''s Day'
                WHEN EXTRACT(MONTH FROM date_day) = 12 AND EXTRACT(DAY FROM date_day) = 25 THEN 'Christmas Day'
                WHEN EXTRACT(MONTH FROM date_day) = 12 AND EXTRACT(DAY FROM date_day) = 26 THEN 'Boxing Day'
        ELSE NULL END)::varchar AS holiday_desc

    FROM date_spine
)
SELECT
    calculation.*,
    ('Q' || quarter_number) AS quarter,
    (year || '-Q' || quarter_number) AS year_quarter,
    (CASE WHEN HOLIDAY_DESC IS NULL THEN 0 ELSE 1 END)::boolean AS is_holiday
FROM calculation
