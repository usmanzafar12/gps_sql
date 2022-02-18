# gps_sql
### SQL to extract trips and weekly data from gps data

- fetch_avl_value.sql contains a test function that fetches a value from a denormalized database and makes it available for use in further queries
- get_trace_statistics.sql contains a CTE that breaks down task of fetching the weeks that have used the maximum mileage from the data
- One interesting aspect in this task was the interplay between pandas as sql. Some tasks are easily done in pandas and some in sql. 

