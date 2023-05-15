/*
NO AT:
725126304	GSM047 46463783	PPUB     	PPUB12OP 	2012-07-10 00:00	4700-12-31 00:00
612027607	GSM047 90887318	PPUB     	PPUB12OP 	2012-04-27 00:00	4700-12-31 00:00
217344407	GSM047 98407928	PPUB     	PPUB12OP 	2012-04-20 00:00	4700-12-31 00:00
235940707	GSM047 90591747	PPUB     	PPUB12OP 	2012-05-22 00:00	4700-12-31 00:00
780050605	GSM047 92082227	PPUB     	PPUB12OP 	2012-06-28 00:00	4700-12-31 00:00
698078508	GSM047 45611064	PPUB     	PPUB12OP 	2012-04-12 00:00	4700-12-31 00:00
825430705	GSM047 93873878	PPUB     	PPUB12OP 	2012-05-21 00:00	4700-12-31 00:00
716110705	GSM047 97731371	PPUB     	PPUB12OP 	2012-06-25 00:00	4700-12-31 00:00
605646603	GSM047 93220481	PPUB     	PPUB12OP 	2012-05-21 00:00	4700-12-31 00:00
383442308	GSM047 92038923	PPUB     	PPUB12OP 	2012-06-05 00:00	4700-12-31 00:00
378568000	GSM047 92202049	PPUB     	PPUB12OP 	2012-06-14 00:00	4700-12-31 00:00

NO ST:
437090012	GSM047 45392141	PPUB     	PPUB12SPS	2012-07-17 00:00	4700-12-31 00:00
993190016	GSM047 45391136	PPUB     	PPUB12SPS	2012-08-08 00:00	4700-12-31 00:00
*/
SELECT a.ban, b.account_type, b.account_sub_type, a.subscriber_no, a.soc,
       a.campaign, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date, a.act_reason_code
  from service_agreement a, billing_account b
  WHERE a.subscriber_no = 'GSM047' || '92202049'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.ban = b.ban
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;

select a.memo_ban, a.memo_date, a.memo_subscriber, a.memo_system_txt, a.memo_manual_txt
  from memo a
 where a.memo_subscriber = 'GSM047' || '92202049'
-- */   and a.memo_ban = 378568000
   and a.memo_date       > sysdate - 3;

select a.*
  from charge a
 where 1 = 1
   and a.ban = 378568000
   and a.subscriber_no = 'GSM047' || '92202049'
   and a.sys_creation_date > trunc(sysdate - 1)
;

/*
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.effective_date, a.expiration_date
  FROM service_agreement a
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    and a.effective_date  > sysdate - 182
    AND a.service_type    = 'P' -- 'P'riceplan Soc, 'R'egular Soc
    AND RTRIM(a.soc)     IN ('PPUB')
    and a.campaign     LIKE RTRIM(a.soc) || '12OP%'
    AND a.subscriber_no  != '0000000000'
    AND ROWNUM           <= 11
  ORDER BY dbms_random.value()
;
*/