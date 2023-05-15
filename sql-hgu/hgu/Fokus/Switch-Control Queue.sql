/*
Hi,
 
Here are the queries that need to be run against NTCAPPC_LNG5@P01OL1.
 
// this is the HIGH (NORMAL) priority queue
*/
select count(1) as "QUEUE_HIGH"
  from q3
 where phd_id   = 'hlri'
   and priority = 30
;
 
/*
// this is the LOW priority queue
*/
select count(1) as "QUEUE_LOW"
  from q3
 where phd_id   = 'hlri'
   and priority = 40
;

/* 
SC can process around 2.5trx/second or 10.000 trx/hour (both queues low and high combined).

Regards

*/

SELECT COUNT(1) AS "QUEUE"
  FROM q3
 WHERE phd_id    = 'hlri'
   AND priority IN (30, 40)
;