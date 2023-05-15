/*
DK AT:
650791809	GSM045 60187715	SIMALONE 	FLEX2    	2012-05-31 00:00	4700-12-31 00:00
474500907	GSM045 26122441	SIMALONE 	FLEX2    	2012-05-24 00:00	4700-12-31 00:00
936729805	GSM045 27628001	SIMALONE 	SIMALONE 	2012-05-31 00:00	4700-12-31 00:00
574500906	GSM045 27146694	SIMALONE 	FLEX2    	2012-05-27 00:00	4700-12-31 00:00
832500904	GSM045 23951438	SIMALONE 	FLEX2    	2012-05-03 00:00	4700-12-31 00:00
344461603	GSM045 26394337	SIMALONE 	FLEX2    	2012-06-01 00:00	4700-12-31 00:00
993500909	GSM045 26120664	SIMALONE 	FLEX2    	2012-05-18 00:00	4700-12-31 00:00
100691622	GSM045 28150832	SIMALONE 	SIMALONE 	2012-05-22 00:00	4700-12-31 00:00
932500903	GSM045 23950921	SIMALONE 	SIMALONE 	2012-05-03 00:00	4700-12-31 00:00
993500909	GSM045 28400012	SIMALONE 	FLEX2    	2012-05-18 00:00	4700-12-31 00:00
411459803	GSM045 26354844	SIMALONE 	FLEX2    	2012-06-01 00:00	4700-12-31 00:00
*/
SELECT a.ban, b.account_type, b.account_sub_type, a.subscriber_no, a.soc,
       a.campaign, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date, a.act_reason_code
  from service_agreement a, billing_account b
  WHERE a.subscriber_no = 'GSM045' || '60187715'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.ban = b.ban
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;

select a.memo_ban, a.memo_date, a.memo_subscriber, a.memo_system_txt, a.memo_manual_txt
  from memo a
 where a.memo_subscriber = 'GSM045' || '60187715'
-- */   and a.memo_ban = 650791809
   and a.memo_date       > sysdate - 3;

select a.*
  from charge a
 where 1 = 1
   and a.ban = 650791809
   and a.subscriber_no = 'GSM045' || '60187715'
   and a.sys_creation_date > trunc(sysdate - 1)
;

/*
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.effective_date, a.expiration_date
  FROM service_agreement a
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    and a.effective_date  > sysdate - 182
    AND a.service_type    = 'P' -- 'P'riceplan Soc, 'R'egular Soc
    AND RTRIM(a.soc)     IN ('SIMALONE')
--    and a.campaign     LIKE RTRIM(a.soc) || '12OP%'
    AND a.subscriber_no  != '0000000000'
    AND ROWNUM           <= 11
  ORDER BY dbms_random.value()
;
*/
SELECT * FROM TMDREFSS1.zip_decode
where zip_code = '2800'
;
SELECT * FROM TMDREFSS2.zip_decode
where zip_code = '2800'
;
SELECT * FROM TMDREFWAIT.zip_decode
where zip_code = '2800'
;

select a.* from all_tables a
where a.table_name = 'ZIP_DECODE'
ORDER BY A.OWNER
;