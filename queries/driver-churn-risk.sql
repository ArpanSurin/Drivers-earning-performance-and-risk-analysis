
WITH driver_data AS (
    SELECT
        driver_id,
        dropoff_time,
        driver_earnings,
		extract(epoch from (dropoff_time -
        LAG(dropoff_time) OVER (
            PARTITION BY driver_id
            ORDER BY dropoff_time
        ) )) / 86400 as gap_days
    FROM trips
    WHERE status = 'completed'
),

driver_lifecycle as (
SELECT
    d.driver_id,
	count(*) as total_trips,
    MIN(d.dropoff_time) AS first_trip,
    MAX(d.dropoff_time) AS last_trip,
    SUM(d.driver_earnings) AS total_earnings,
    ROUND(AVG(gap_days), 2) AS avg_days_between_trips,
	case when max(dropoff_time) >= current_date - interval '7 days' then 'very-active'
		 when max(dropoff_time) >= current_date - interval '30 days' then 'active'
		 when max(dropoff_time) >= current_date - interval '90 days' then 'at-risk'
		else 'churned'
	end as driver_status,
	ntile(10) over(order by sum(d.driver_earnings) desc) as driver_rank
FROM driver_data d
GROUP BY d.driver_id
),

top_drivers as (
select
	'Top ' || (driver_rank * 10) || '%' as top_percentile_group,
	count(*) as driver_count,
	sum(total_earnings) as total_earnings,
	count(*) filter(where driver_status in ('at-risk', 'churned')) as drivers_at_risk,
	sum(total_earnings) filter(where driver_status in ('at-risk', 'churned')) as revenue_at_risk,
	count(*) filter(where driver_status in ('at-risk', 'churned')) * 100.0 /
	count(*) percent_of_drivers_at_risk
from driver_lifecycle
group by driver_rank
order by driver_rank
)

select 
	*
from top_drivers