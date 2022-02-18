-- extract week with most mileage
-- first calculate weekly mileage
WITH get_odometer AS 
	(select record_id, val from test_value(16 , '************', 'n4_ids', 'n4_values')),
	join_odo_data AS 
	(select * from get_odometer inner join car_data using (record_id)),
	extract_week AS
	(select *, extract('isoyear' from time) as year, extract('week' from time) as week from join_odo_data),
	weekly_distance AS
	(select week, (max(val)-min(val)) week_distance from extract_week  group by week), 
	max_week AS 
	(select max(week_distance) as max_distance from weekly_distance),
	get_week_and_max AS
	(select week, max_distance from max_week inner join weekly_distance on weekly_distance.week_distance = max_week.max_distance )
select * from get_week_and_max;

--select * from max_week;

