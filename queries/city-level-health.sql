-------------------------City-level marketplace health-------------------------
select 
	pickup_city,
	
--1. no. of completed trips
	count(*) filter(
		where status = 'completed' and
		dropoff_time >= current_date - interval '30 days'
	) as completed_trips,

--2. cancellation rate
	count(*) filter(
		where status != 'completed' 
		and request_time >= current_date - interval '30 days'
	) * 1.0 / 
	count(*) filter(
		where request_time >= current_date - interval '30 days'
	) as cancellation_rate,

--3. average surge multiplier
	avg(surge_multiplier) filter(
		where status = 'completed' and
		request_time >= current_date - interval '30 days' 
	) as avg_surge_multiplier,

--4. Average platform_fee per trip and total platform_fee
	avg(platform_fee) filter(
		where status = 'completed' and
		dropoff_time >= current_date - interval '30 days' 
	) as avg_platform_fee,
	
	sum(platform_fee) filter(
		where status = 'completed' and
		dropoff_time >= current_date - interval '30 days' 
	) as total_platform_fee

from trips
group by pickup_city
order by
	completed_trips desc,
	cancellation_rate asc,
	total_platform_fee desc;
---------------------------------------------------------------------------------