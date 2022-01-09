
/* first method : to_char */
select current_date as c1,
  to_char(current_date,'Day') as c2;
     
/* second method : date dimension */
select current_date as c1,
     day_name as c2
     from dim_calendar
     where 
     "date"= current_date;

/* third method : custom function */
/* create a function in language supported by your database
   in this example, used python
 */
CREATE OR REPLACE FUNCTION fn_dayname(my_date DATE)
RETURNS varchar
STABLE
AS $$
    import calendar
    return calendar.day_name[my_date.weekday()]
$$ LANGUAGE plpythonu;

select current_date as c1, fn_dayname(c1) as c2;

/* youtube link : https://youtu.be/2ZLgUibKCIc */
