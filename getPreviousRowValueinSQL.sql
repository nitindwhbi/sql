
/* how to get previous row value in sql - using LAG function */

select 
 catid,
    lag(catid) over (order by catid) as previous_catid,
 catgroup,
    catname
from category;


/* how to get previous row value in sql without using LAG function */

select 
 catid,
    min(catid) over (order by catid rows between 1 preceding and 1 preceding) as previous_catid,
 catgroup,
    catname
from category;

/*
youtube link: https://youtu.be/otWACEg9gU4
*/
