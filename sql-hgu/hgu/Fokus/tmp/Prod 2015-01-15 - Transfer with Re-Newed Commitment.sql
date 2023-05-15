-- Locate a subscription in a test environment that matches the errored in prod
select a.*
  from service_agreement a
 where 1 = 1
   and a.soc = 'PSTB'
   and a.effective_date between (sysdate - 1000) and (sysdate - 730)
   and nvl(a.expiration_date, sysdate + 1) > sysdate
   and a.commit_orig_no_month = '24'   
   and rownum < 10
;
/*
-->
414230011	GSM04793242705	PSTB     	133521433	0	2013-01-14 08:09		401589	Ninja 	CS099		2557	PSTB24OP 	24	2013-01-14 00:00	414230011	2013-01-14 00:00	P	4700-12-31 00:00	C	OT20 
414230011	GSM04798240959	PSTB     	129000284	0	2012-08-28 12:55		500475		CS017		2557	PSTB24OP 	24	2012-08-28 00:00	414230011	2012-08-28 00:00	P	4700-12-31 00:00	C	OT20 
439073503	GSM04745280551	PSTB     	134628412	0	2013-02-13 11:32		400543	Ninja 	CS099		2569	PSTB24NY 	24	2013-02-13 00:00	439073503	2013-02-13 00:00	P	4700-12-31 00:00	C	N180 
439073503	GSM04746441319	PSTB     	132106087	0	2012-11-28 14:34		400543	Ninja 	CS099		2569	PSTB24NY 	24	2012-11-28 00:00	439073503	2012-11-28 00:00	P	4700-12-31 00:00	C	N180 
499910701	GSM04792290422	PSTB     	133701909	0	2013-01-18 11:00		402038	Ninja 	CS099		2569	PSTB24NY 	24	2013-01-18 00:00	499910701	2013-01-18 00:00	P	4700-12-31 00:00	C	TB89 
519077705	GSM04793242670	PSTB     	134393314	0	2013-02-05 10:13		401589	Ninja 	CS099		2557	PSTB24OP 	24	2013-02-05 00:00	519077705	2013-02-05 00:00	P	4700-12-31 00:00	C	NETL 
519077705	GSM04741637775	PSTB     	132826775	0	2012-12-19 00:50		1	FUTRX 	CS099		2569	PSTB24NY 	24	2012-12-19 00:00	519077705	2012-12-19 00:00	P	4700-12-31 00:00	C	OT20 
519077705	GSM04795209718	PSTB     	129493810	0	2012-09-12 12:30		401589	Ninja 	CS099		2557	PSTB24OP 	24	2012-09-12 00:00	519077705	2012-09-12 00:00	P	4700-12-31 00:00	C	OT20 
522513902	GSM04792210819	PSTB     	132642086	0	2012-12-13 10:08		401553	Ninja 	CS099		2557	PSTB24OP 	24	2012-12-13 00:00	522513902	2012-12-13 00:00	P	4700-12-31 00:00	C	F346 
*/

select a.*
  from billing_account a
 where a.ban = '522513902'
;

select a.*
  from service_agreement a
 where 1 = 1
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   and a.subscriber_no = 'GSM047' || '93242705'
order by a.soc
;

select a.customer_id, a.subscriber_no, a.effective_date, a.sub_status,
       a.sub_status_date, a.original_init_date, a.commit_start_date,
       a.commit_end_date, a.commit_orig_no_month
  from subscriber a
 where a.customer_id   = '522513902'
   and a.subscriber_no = 'GSM047' || '93242705'
   and a.sub_status    = 'A'
;