select a.agreement_type, a.agreement_sub_type, count(*) as "COUNT"
  from agreements a
group by a.agreement_type, a.agreement_sub_type
order by 1, 2
;

select count(1) as "COUNT"
  from agreements a
;


select a.agreement_item, count(*) as "COUNT"
  from agreement_items a
group by a.agreement_item
order by 1
;

select a.*
  from agreements a, agreement_items ai
 where a.agreement_type     = 'PRIVATE'
   and a.agreement_sub_type = 'REGULAR'
   and a.agreement_id       = ai.agreement_id
   and ai.agreement_item    = 'TF'
   and rownum < 11
;
/*
2454053	PRIVATE	REGULAR	13806037				0	
467094	PRIVATE	REGULAR					0	
467131	PRIVATE	REGULAR	1954624				0	
467898	PRIVATE	REGULAR	1958062				0	
468078	PRIVATE	REGULAR	1958721				0	
468116	PRIVATE	REGULAR					0	
2452758	PRIVATE	REGULAR	13791091				0	
2453800	PRIVATE	REGULAR	13804193				0	
2453831	PRIVATE	REGULAR	13804258				0	
468446	PRIVATE	REGULAR					0	
*/

select o.*
  from orders o, agreements a, agreement_items ai
 where o.agreement_id       = a.agreement_id
   and a.agreement_type     = 'PRIVATE'
   and a.agreement_sub_type = 'REGULAR'
   and a.agreement_id       = ai.agreement_id
   and ai.agreement_item    = 'TF'
   and rownum < 11
;
