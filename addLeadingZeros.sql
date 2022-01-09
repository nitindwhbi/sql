-- 3 ways to add leading zeros in SQL

-- Ouptut should be 4 digit , add leading 0s if required to make it 4 digit.

/* using to_char function */
select catid,
to_char(catid,'0000') as catid_1
from category
order by 1 desc;

/* using case statement */
select catid,
case when length(catid)=1 then '000'||catid
when length(catid)=2 then '00'||catid
when length(catid)=3 then '0'||catid
when length(catid)=4 then ''||catid
end as catid_1
from category
order by 1 desc;

/* using right function */
select catid,
right('0000'||catid,4) as catid_1
from category
order by 1 desc;
