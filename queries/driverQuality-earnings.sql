WITH trips_60d AS (
  SELECT
    driver_id,
    COUNT(*) AS total_trips,
	count(*) filter(
	where status in ('completed')
	) as completed_trips,
    COUNT(*) FILTER (
      WHERE status IN ('driver_cancelled','rider_cancelled')
    ) AS cancelled_trips
  FROM trips
  WHERE request_time >= current_date - interval '60 days'
  GROUP BY driver_id
),

ratings_60d as (
	SELECT
	    t.driver_id,
	    AVG(r.rating) AS avg_rider_rating
	  FROM trips t
	  JOIN ratings r
	    ON r.trip_id = t.trip_id
	   AND r.rated_by = 'rider'
	  WHERE t.request_time >= current_date - interval '60 days'
	    AND t.status = 'completed'
	  GROUP BY t.driver_id
),

payouts_60d AS (
  SELECT
    driver_id,
    SUM(total_earnings) AS total_earnings,
    SUM(bonuses) AS total_bonus
  FROM driver_payouts
  WHERE payout_period_end >= current_date - interval '60 days'
  GROUP BY driver_id
),

driver_view as(
	SELECT
	  t.driver_id,
	  t.completed_trips,
	  p.total_earnings,
	  p.total_bonus,
	  r.avg_rider_rating,
	  t.cancelled_trips * 1.0 / NULLIF(t.total_trips, 0) AS cancellation_rate,
	  ntile(4) over(order by avg_rider_rating desc) as driver_rank
	FROM trips_60d t
	LEFT JOIN payouts_60d p
	  ON t.driver_id = p.driver_id
	left join ratings_60d r
		on t.driver_id = r.driver_id
	where t.completed_trips >= 10
)

select 
	driver_rank,
	count(*) as total_drivers,
	sum(completed_trips) as completed_trips,
	avg(total_earnings) as avg_earnings,
	avg(avg_rider_rating) as avg_ratings,
	avg(cancellation_rate) * 100 as avg_cancellation_rate
from driver_view
where avg_rider_rating is not null
group by driver_rank
order by driver_rank