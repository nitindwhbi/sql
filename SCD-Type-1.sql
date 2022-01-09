
/*
How to implement SCD Type 1 in SQL
*/

/* 
 Slowly changing Dimension - Type 1
 No need to track & store history
 */
 
select *
from stg_users_day1;
-- 5 new records

select *
from stg_users_day2;
-- 2 new records and 2 updates

select *
from stg_users_day3;
-- 3 new records and 1 update

CREATE TABLE "sch_edw"."edw_users_scd1" (
    userid integer,
    /* new column - surrogate key */
    username character(8),
    firstname varchar(30),
    lastname varchar(30),
    city varchar(30),
    state varchar(2),
    email varchar(100),
    phone varchar(14)
);

select *
from edw_users_scd1;

    /* 
     always run update BEFORE insert 
     update any old record
     You can also use MERGE statement
     */

update edw_users_scd1 t2
set phone = t1.phone
from stg_users_day3 t1
where t2.username = t1.username
    and coalesce(t2.phone, '-1') <> coalesce(t1.phone, '-1');

/*
 insert new record only 
 */
insert into edw_users_scd1 with cte_max as (
        select coalesce(max(userid), 0) as max_userid
        from edw_users_scd1
    )
select t3.max_userid + row_number() over(
        order by userid
    ) as userid,
    t1.*
from stg_users_day3 t1
    left outer join edw_users_scd1 t2 on t1.username = t2.username
    inner join cte_max t3 on 1 = 1
where t2.username is null;

