DESC NTCAPPO.subscriber_rank@fokus
;

DESC NTCREFWAIT.price_level@fokus
;

SELECT /*+ driving_site(a)*/ a.*
  FROM all_tables@fokus a
 WHERE a.table_name IN ( 'SUBSCRIBER_RANK', 'PRICE_LEVEL' )
;


SELECT /*+ driving_site(a)*/ a.*
  FROM NTCAPPO.subscriber_rank@fokus a
;

SELECT /*+ driving_site(a)*/ a.*
  FROM NTCREFWAIT.price_level@fokus a
;

SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.rank, a.effective_date, a.expiration_date
  FROM NTCAPPO.subscriber_rank@fokus a
 WHERE a.ban = 289998411
ORDER BY a.ban, a.soc, a.rank
;

