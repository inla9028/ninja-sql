SELECT a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus a, users@fokus u
 WHERE a.memo_ban        = 528665417
   AND a.memo_date       > TRUNC(SYSDATE, 'MON')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;

-- GSM04741308686

SELECT a.subscriber_no, a.customer_id, a.sub_status, a.sub_status_date
     , a.operator_id, u.user_full_name, a.dealer_code, a.sales_agent
     , a.subscriber_id
 FROM subscriber@fokus a, users@fokus u
WHERE a.subscriber_no = 'GSM047'||'41308686'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.operator_id   = u.user_id(+)
;

SELECT s.subscriber_no, a.subscriber_id, a.sys_creation_date, a.loan_seq_no
     , a.soc, a.full_amt, a.first_install_rate, a.other_install_rate
     , a.last_install_rate, a.no_of_installments
  FROM subscriber_loan@fokus a, subscriber@fokus s
 WHERE a.subscriber_id = s.subscriber_id
   AND s.subscriber_no = 'GSM047'||'41308686'
   AND s.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = s.subscriber_no)
ORDER BY s.subscriber_no, a.loan_seq_no
;


select a.*
  from service_agreement@fokus a
 where a.soc LIKE 'LOPFLX%'
   and SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   and rownum < 11
;
/*
533357315	GSM04741381853	LOPFLX01 	199931789	0	2017-12-27 00:00		200900		CS017		-1	000000000	0	2017-12-27 00:00	533357315	2017-12-27 00:00	G	2019-12-28 00:00	C	DRFT 	A    	2017-12-27 00:00	2017-12-27 00:00	141695649	141695649		726	4112618					
126947316	GSM04793098897	LOPFLX01 	199891711	0	2018-02-11 00:00		200900		CS017		-1	000000000	0	2018-02-11 00:00	126947316	2018-02-11 00:00	G	2020-02-12 00:00	C	DRFT 	A    	2018-02-11 00:00	2018-02-11 00:00	141685352	141685352		726	4111494					
399257310	GSM04741381975	LOPFLX01 	199932079	0	2018-04-01 00:00		200900		CS017		-1	000000000	0	2018-04-01 00:00	399257310	2018-04-01 00:00	G	2020-04-01 00:00	C	X139 	A    	2018-04-01 00:00	2018-04-01 00:00	141695720	141695720		726	4112627					
286945415	0000000000	LOPFLX01 	229364132	0	2019-04-24 07:00		988610		CS017		-1	000000000	0	2019-04-24 00:00	286945415	2019-04-24 00:00	G	2020-04-23 00:00	C	X139 	A    	2018-04-23 00:00	2018-04-23 00:00	157169059	157169059		701	4428377			17925971		
816947311	GSM04793095689	LOPFLX01 	199891660	0	2018-03-10 00:00		200900		CS017		-1	000000000	0	2018-03-10 00:00	816947311	2018-03-10 00:00	G	2020-03-10 00:00	C	DRFT 	A    	2018-03-10 00:00	2018-03-10 00:00	141685337	141685337		726	4111492					
800855413	GSM04741389581	LOPFLX01 	229436556	0	2018-03-11 00:00		200900		CS017		-1	000000000	0	2018-03-11 00:00	800855413	2018-03-11 00:00	G	2020-03-11 00:00	C	DRFT 	A    	2018-03-11 00:00	2018-03-11 00:00	157188451	157188451		701	4430514					
616357315	GSM04741382370	LOPFLX01 	199935115	0	2018-03-29 00:00		200900		CS017		-1	000000000	0	2018-03-29 00:00	616357315	2018-03-29 00:00	G	2020-03-29 00:00	C	DRFT 	A    	2018-03-29 00:00	2018-03-29 00:00	141696479	141696479		726	4112785					
385437314	0000000000	LOPFLX01 	199958282	0	2019-04-15 12:27		988610		CS017		-1	000000000	0	2019-04-15 00:00	385437314	2019-04-15 00:00	G	2020-04-15 00:00	C	KSA1 	A    	2018-04-15 00:00	2018-04-15 00:00	141702679	141702679		701	4113568			16849375		
196845416	0000000000	LOPFLX01 	229363833	0	2019-04-23 14:41		988610		CS017		-1	000000000	0	2019-04-23 00:00	196845416	2019-04-23 00:00	G	2020-04-23 00:00	C	KSA1 	A    	2018-04-23 00:00	2018-04-23 00:00	157168985	157168985		701	4428373			17925961		
286945415	GSM04741383617	LOPFLX01 	229363929	0	2018-04-23 00:00		200900	Ninja 	CS099		-1	000000000	0	2018-04-23 00:00	286945415	2018-04-23 00:00	G	2020-04-23 00:00	C	X139 	A    	2018-04-23 00:00	2018-04-23 00:00	157169005	157169005		701	4428379					
*/

SELECT ba.ban, ba.ban_status, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
     , a.loan_sub_id
  FROM service_agreement@fokus a, users@fokus u, billing_account@fokus ba
 WHERE ba.ban          = 385437314
   and ba.ban_status   = 'O'
   and a.ban           = ba.ban
   and a.subscriber_no = '0000000000'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.soc        LIKE 'LOPFLX%'
   and a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

select a.*
  from subscriber@fokus a
 where a.customer_id   = 385437314
   and a.subscriber_id = 16849375
;


SELECT s.subscriber_no, a.subscriber_id, a.sys_creation_date, a.loan_seq_no
     , a.soc, a.full_amt, a.first_install_rate, a.other_install_rate
     , a.last_install_rate, a.no_of_installments
  FROM subscriber_loan@fokus a, subscriber@fokus s
 WHERE a.subscriber_id = s.subscriber_id
   AND s.subscriber_no = 'GSM047'||'45412018'
   AND s.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = s.subscriber_no)
ORDER BY s.subscriber_no, a.loan_seq_no
;

SELECT a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus a, users@fokus u
 WHERE a.memo_ban        = 385437314
   AND a.memo_date       > TRUNC(sysdate, 'MON')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;
