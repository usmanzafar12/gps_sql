
CREATE OR REPLACE FUNCTION test_value (avl_id int, imei_id text, col_name varchar(10), col_val varchar(10))
RETURNS TABLE (record_id int, avl int, val int)  AS 
$$

BEGIN
RETURN QUERY EXECUTE '
WITH get_pos AS 
	(select car_data.record_id, array_position('||quote_ident(col_name)||','|| avl_id ||') as pos from car_data where imei = '|| quote_literal(imei_id) ||'),
rmv_null AS 
	(select * from get_pos where get_pos.pos is not NULL),
get_val AS 
	(select car_data.record_id,'||quote_ident(col_name)||'[pos], '||quote_ident(col_val)||'[pos] from rmv_null, car_data where car_data.record_id = rmv_null.record_id)

select * from (select * from get_val) q1;';

END;
$$ LANGUAGE plpgsql;
-- speed is id 24, 37 
-- odometer is  16
-- engine rpm 36 
-- fuel level 48
select record_id, val from test_value(16 , '**************', 'n4_ids', 'n4_values'); --order by record_id;
--select * from car_data where imei='' order by time;
