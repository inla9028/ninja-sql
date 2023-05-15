SELECT A.*
  FROM party_manager_events A
 WHERE A.customer_id IN ( 454680513 )
--   AND A.status_desc LIKE '%No-op%'
--   AND A.action_type = 'M'
   AND A.link_type = 'U'
ORDER BY A.request_id
;

SELECT A.action_type, A.link_type, A.customer_id, A.subscriber_no, A.request_time, A.status_desc
  FROM party_manager_events A
 WHERE A.customer_id IN ( 454680513 )
--   AND A.status_desc NOT LIKE '%No-op%'
   AND A.link_type = 'U'
ORDER BY A.request_id
;

SELECT A.action_type, A.subscriber_no, A.old_email, A.email, A.old_tpid, A.tpid ,A.request_time, A.status_desc
  FROM party_manager_events A
 WHERE A.customer_id IN ( 454680513 )
--   AND A.status_desc NOT LIKE '%No-op%'
   AND A.link_type = 'U'
ORDER BY A.request_id
;

SELECT A.link_type, A.customer_id, A.subscriber_no, A.old_status, A.status, A.request_time, A.status_desc
  FROM party_manager_events A
 WHERE A.customer_id IN ( 454680513 )
--   AND A.action_type = 'S'
   AND A.link_type = 'U'
ORDER BY A.request_id
;

SELECT A.*
 FROM batch_tpid_extract A
 WHERE A.ban IN ( 454680513 )
ORDER BY A.request_time
;

SELECT A.*
 FROM batch_tpid_update A
 WHERE A.ban IN ( 454680513 )
--   and A.request_time > trunc(sysdate)  
ORDER BY A.request_time
;

UPDATE party_manager_events A
   SET A.process_status = 'ON_HOLD'
 WHERE A.request_id = 21036
;

SELECT /*+ driving_site(s)*/
       anl.ban, anl.subscriber_no, anl.link_type, anl.birth_date,
       nd.tpid, nd.comp_reg_id, nd.first_name, nd.last_business_name,
       ad.adr_email, c.customer_telno, ad.adr_primary_ln, ad.adr_secondary_ln
--     , nd.*
--       , nd.role_ind
  FROM address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
     , customer@fokus          c
 WHERE anl.ban            IN ( 454680513 )
   AND c.customer_id      = anl.ban
   AND anl.link_type     IN ( 'B', 'L', 'U' )
   AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
ORDER BY anl.ban, anl.link_type, anl.subscriber_no
;

SELECT /*+ driving_site(a)*/
       a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus A, users@fokus u
 WHERE a.memo_ban        = 454680513
--   AND A.memo_date       > trunc(SYSDATE)
   AND a.memo_date       > TRUNC(SYSDATE, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE - 30, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE - 60, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE, 'YEAR')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;


UPDATE party_manager_events A
   set A.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
 WHERE A.request_id = 26079
;

INSERT INTO party_manager_events (action_type,customer_id,account_type,account_sub_type,subscriber_no,link_type,old_comp_reg_id,comp_reg_id,old_tpid,tpid,old_birth_date,birth_date,old_status,status,name_format,old_first_name,first_name,old_last_business_name,last_business_name,old_email,email,process_status,request_user_id)
VALUES ('M','357280510','I','R','GSM04747230371','U','66636759452','66636759452','3ae4bd98-c31e-492d-8e62-85c7bae0b37f','3ae4bd98-c31e-492d-8e62-85c7bae0b37f',to_date('1992-10-16 00:00','YYYY-MM-DD HH24:MI'),to_date('1992-10-16 00:00','YYYY-MM-DD HH24:MI'),NULL,NULL,'I','HOMER','HOMER','SEXUAL','SEXUAL','my.milkshake.is.better.than_yours@tine.no','my.milkshake@tine.no','WAITING','NINJA 2021-02-22');


SELECT A.*
  FROM soc_loan@fokus A
 WHERE A.soc LIKE 'LFDELB1%'
ORDER BY A.soc, A.effective_date
;

SELECT A.customer_id, A.subscriber_no, A.old_tpid, A.tpid, A.request_time, A.status_desc
  FROM party_manager_events A
 WHERE A.request_id  IN ( 26877, 26878, 26897 )
ORDER BY A.request_id
;