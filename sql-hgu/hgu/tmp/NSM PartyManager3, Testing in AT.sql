SELECT bte.ban, bte.subscriber_no, bte.link_type, bte.process_status, bte.process_time
--     , REPLACE( RTRIM (
--           SUBSTR (
--               SUBSTR (bte.status_desc,
--                       0,
--                       INSTR (bte.status_desc || ' [ID', ' [ID')),
--               INSTR (
--                   SUBSTR (bte.status_desc,
--                           0,
--                           INSTR (bte.status_desc || ' [ID', ' [ID')),
--                   'Exception: '))), 'Exception: ', '')
--           AS "STATUS_DESC"
     , btu.tpid, btu.link_type AS "UPDATE_LINK_TYPE", btu.process_status AS "UPDATE_STATUS"
  FROM batch_tpid_extract bte, batch_tpid_update btu
 WHERE bte.request_time > trunc(SYSDATE)
   AND bte.ban          = btu.ban(+)
   AND bte.request_time < btu.request_time(+)
ORDER BY nvl(bte.process_time, SYSDATE), btu.request_time
;

SELECT bte.ban, bte.subscriber_no, bte.link_type, bte.process_status, bte.process_time
--     , REPLACE( RTRIM (
--           SUBSTR (
--               SUBSTR (bte.status_desc,
--                       0,
--                       INSTR (bte.status_desc || ' [ID', ' [ID')),
--               INSTR (
--                   SUBSTR (bte.status_desc,
--                           0,
--                           INSTR (bte.status_desc || ' [ID', ' [ID')),
--                   'Exception: '))), 'Exception: ', '')
--           AS "STATUS_DESC"
     , btu.tpid, btu.link_type AS "UPDATE_LINK_TYPE", btu.process_status AS "UPDATE_STATUS"
  FROM batch_tpid_extract bte, batch_tpid_update btu
 WHERE bte.request_time  > trunc(SYSDATE)
   AND bte.request_time  > SYSDATE - 3/24
   AND bte.subscriber_no IS NOT NULL
   AND bte.ban           = btu.ban(+)
   AND bte.request_time  < btu.request_time(+)
--   AND bte.subscriber_no = btu.subscriber_no(+)
--   and bte.process_time  < btu.request_time(+)
ORDER BY nvl(bte.process_time, SYSDATE), btu.request_time
;

SELECT bte.ban, bte.subscriber_no, bte.link_type, bte.process_status, bte.process_time
     , REPLACE( RTRIM (
           SUBSTR (
               SUBSTR (bte.status_desc,
                       0,
                       INSTR (bte.status_desc || ' [ID', ' [ID')),
               INSTR (
                   SUBSTR (bte.status_desc,
                           0,
                           INSTR (bte.status_desc || ' [ID', ' [ID')),
                   'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM batch_tpid_extract bte
 WHERE bte.request_time   > trunc(SYSDATE)
   AND bte.process_status = 'PRSD_ERROR'
ORDER BY nvl(bte.process_time, SYSDATE)
;

--INSERT INTO batch_tpid_extract (ban,subscriber_no,link_type) 
--VALUES ('803620905','GSM04793879479','U');
--
--INSERT INTO batch_tpid_extract (ban,link_type) 
--VALUES ('803620905','B');
--
--INSERT INTO batch_tpid_extract (ban,subscriber_no,link_type)
--VALUES ('596481507','GSM04793429970','U');
--INSERT INTO batch_tpid_extract (ban,subscriber_no,link_type)
--VALUES ('594534216','GSM04793879479','U');

UPDATE batch_tpid_extract A
   SET A.process_status = 'WAITING', A.process_time = NULL, A.status_desc = NULL
--     , A.request_time = SYSDATE
 WHERE A.ban            = 946052412
--   AND A.subscriber_no IS NULL 
   AND A.subscriber_no  = 'GSM04746504311'
   AND A.PROCESS_STATUS = 'PRSD_ERROR'
--   AND A.PROCESS_STATUS = 'PRSD_SUCCESS'
;

SELECT A.*
  FROM batch_tpid_extract A
 WHERE A.ban            = 452229412
;

INSERT INTO batch_tpid_extract (ban,link_type)
WITH ninja_filter AS (
  SELECT ban FROM batch_tpid_extract WHERE ban IS NOT NULL
  UNION 
  SELECT ban FROM batch_tpid_update  WHERE ban IS NOT NULL
)
SELECT b.ban, b.link_type
  FROM (SELECT /*+ driving_site(anl)*/
               ba.ban, 'B' AS "LINK_TYPE"
          FROM billing_account@fokus ba, ninja_filter f
         WHERE ba.ban_status      = 'O'
           AND ba.ban        NOT IN (f.ban)
           AND ROWNUM             < 1001
        ORDER BY dbms_random.VALUE) b
  WHERE ROWNUM < 2
;

INSERT INTO batch_tpid_extract (ban, link_type, subscriber_no)
WITH ninja_filter AS (
  SELECT subscriber_no FROM batch_tpid_extract WHERE subscriber_no IS NOT NULL
  UNION
  SELECT subscriber_no FROM batch_tpid_update  WHERE subscriber_no IS NOT NULL
)
SELECT a.customer_id as "BAN", 'U' AS "LINK_TYPE", a.subscriber_no
  FROM (SELECT /*+ driving_site(s)*/
               s.customer_id, s.subscriber_no
          FROM subscriber@fokus s, ninja_filter f
         WHERE s.sub_status         = 'A'
           AND s.subscriber_no   LIKE 'GSM%'
           AND s.subscriber_no NOT IN (f.subscriber_no) 
           AND ROWNUM               < 5001
        ORDER BY dbms_random.VALUE) A
  WHERE ROWNUM < 2
;

--DELETE
--  FROM batch_tpid_extract A 
-- WHERE A.subscriber_no  = 'CDA04755584991'
--   AND A.process_status = 'WAITING'
--;

SELECT A.ban, a.tpid, a.process_status
  FROM batch_tpid_update A
 WHERE A.request_time > TRUNC(SYSDATE)
ORDER BY NVL(A.process_time, SYSDATE)
;

SELECT A.*
  FROM batch_tpid_update A
 WHERE A.ban            = 364180513
;

UPDATE batch_tpid_update A
   SET A.process_status = 'WAITING'
 WHERE A.request_time > trunc(SYSDATE)
   AND A.process_status = 'ON_HOLD'
   AND A.ban            = 364180513
;

UPDATE ninja_jobs A
   SET A.next_exec_time = trunc(SYSDATE)
 WHERE A.machine_id     = 'NINJAAT2_SH1'
   AND A.job_id         = 88
   AND A.job_status     = 'SLEEPING'
;

SELECT A.*
  FROM ninja_jobs A
 WHERE A.machine_id     = 'NINJAAT2_SH1'
   AND A.job_id         = 88
;


SELECT /*+ driving_site(s)*/
       anl.ban, anl.subscriber_no, anl.link_type, anl.birth_date, anl.effective_date, 
       nd.tpid, nd.id_type, nd.identify, nd.name_format, nd.first_name, nd.last_business_name,
       ad.adr_city, ad.adr_country, ad.adr_house_letter, ad.adr_house_no, ad.adr_pob, ad.adr_street_name, ad.adr_type, ad.adr_zip,
       ad.adr_email
  FROM subscriber@fokus        s
     , address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
 WHERE s.subscriber_no    = 'GSM04795434360'
   AND s.cnt_seq_no       = (SELECT MAX(s2.cnt_seq_no)
                              FROM subscriber@fokus s2
                             WHERE s2.subscriber_no = s.subscriber_no)
   AND anl.ban            = s.customer_id 
   AND anl.subscriber_no IN ( '0000000000', s.subscriber_no )
   AND SYSDATE      BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
--   AND anl.effective_date > trunc(sysdate, 'MON')
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
ORDER BY anl.ban, anl.subscriber_no, anl.link_type
;

SELECT /*+ driving_site(anl)*/
       anl.ban, anl.subscriber_no, anl.link_type, anl.birth_date, anl.effective_date, 
       nd.tpid, nd.id_type, nd.identify, nd.name_format, nd.first_name, nd.last_business_name,
       ad.adr_city, ad.adr_country, ad.adr_house_letter, ad.adr_house_no, ad.adr_pob, ad.adr_street_name, ad.adr_type, ad.adr_zip,
       ad.adr_email, c.customer_telno
  FROM address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
     , customer@fokus          c
 WHERE anl.ban           IN ( 246180517 )
   AND c.customer_id      = anl.ban
   AND anl.link_type     IN ( 'B', 'L', 'U')
   AND SYSDATE      BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
--   AND anl.effective_date > trunc(sysdate, 'MON')
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
ORDER BY anl.ban, anl.subscriber_no, anl.link_type
;

SELECT /*+ driving_site(a)*/ a.*
  FROM name_data@fokus a
 --where 
;

SELECT A.*
  FROM nsm_jobs A
 WHERE A.job_id IN ( 0, 2, 3 )
ORDER BY 1,2
;

UPDATE nsm_jobs A
   SET A.running  = 'Y'
 WHERE A.hostname = 'no-neo-at-01'
   AND A.job_id   = 2
;



--INSERT INTO nsm_jobs (hostname,job_id,job_status,running,sleep_time,time_frames,next_exec_time,status_time,fixed_start,job_fqcn,job_arg1,job_arg2,job_arg3,job_arg4,job_arg5)
--VALUES ('no-neo-at-01','3','STOPPED','Y','60000',NULL,to_date('2021-02-10 14:48','YYYY-MM-DD HH24:MI'),to_date('2021-02-10 14:47','YYYY-MM-DD HH24:MI'),'N','no.netcom.ipl.ninjasyncmanager.jobs.partymanager.PartyManager3EventJob',NULL,NULL,NULL,NULL,NULL);



SELECT bte.ban, bte.subscriber_no, bte.link_type, bte.process_status, bte.process_time
     , '-->' AS " "
     , btu.tpid, btu.link_type AS "UPDATE_LINK_TYPE", btu.process_status AS "UPDATE_STATUS"
  FROM batch_tpid_extract bte, batch_tpid_update btu
 WHERE 1                = 1
--   AND bte.request_time > trunc(SYSDATE)
   AND bte.ban          = 952735413
   AND BTE.BAN          = BTU.BAN(+)
ORDER BY nvl(bte.process_time, SYSDATE), btu.request_time
;

-- 252229414, 352229413, 452229412, 552229411, 242229417, 342229416, 142229418, 581229416, 232229419, 432229417, 532229416, 652229410, 544229412, 778029413,852229418, 752229419, 554229419, 442029419, 700329410, 800329419
INSERT INTO batch_tpid_extract (ban,link_type)
SELECT b.ban, b.link_type
  FROM (SELECT /*+ driving_site(anl)*/
               ba.ban, 'B' AS "LINK_TYPE"
          FROM billing_account@fokus ba
--         WHERE ba.ban        IN ( 442029419, 452229412 )
--         WHERE ba.ban        IN ( 252229414, 352229413, 452229412, 552229411, 242229417, 342229416, 142229418, 581229416, 232229419, 432229417, 532229416, 652229410, 544229412, 778029413,852229418, 752229419, 554229419, 442029419, 700329410, 800329419, 189719412 )
--         WHERE ba.ban        IN ( 452229412, 862276318, 532576311, 589486315, 998862411, 916009418, 998239313,997867312, 997475413, 999728413, 997744412, 442029419 )
         WHERE ba.ban        IN ( 252229414, 352229413, 452229412, 552229411, 242229417, 342229416, 142229418, 581229416, 232229419, 432229417, 532229416, 189719412 )
           and ba.ban_status IN ( 'O' ) -- Open only...
        ) b
;

INSERT INTO batch_tpid_extract (ban, link_type, subscriber_no)
SELECT b.ban, b.link_type, b.subscriber_no
  FROM (SELECT /*+ driving_site(anl)*/
               s.customer_id as "BAN", 'U' AS "LINK_TYPE", s.subscriber_no
          FROM subscriber@fokus s
--         WHERE s.customer_id IN ( 946052412 )
--         WHERE s.customer_id IN ( 352229413 )
--         WHERE s.customer_id IN ( 442029419, 452229412 )
--         WHERE s.customer_id IN ( 252229414, 352229413, 452229412, 552229411, 242229417, 342229416, 142229418, 581229416, 232229419, 432229417, 532229416, 652229410, 544229412, 778029413,852229418, 752229419, 554229419, 442029419, 700329410, 800329419, 189719412 )
--         WHERE s.customer_id IN ( 452229412, 862276318, 532576311, 589486315, 998862411, 916009418, 998239313,997867312, 997475413, 999728413, 997744412, 442029419 )
--         WHERE s.customer_id IN ( 862276318, 532576311, 589486315 , 998862411, 998862411, 916009418, 998239313, 997867312, 997475413, 999728413, 997744412, 442029419 )
         WHERE s.customer_id IN ( 592159214 )
           and s.sub_status  IN ( 'A' )
        ) b
;

SELECT A.*
  FROM party_manager_events A
 WHERE A.action_type = 'M'
   AND A.tpid IS NOT NULL
;

UPDATE party_manager_events A
   SET A.process_status = 'ON_HOLD'
 WHERE A.process_status = 'WAITING'
;

UPDATE party_manager_events A
   SET A.process_status = 'WAITING'
 WHERE A.process_status = 'ON_HOLD'
   AND A.request_id     = 13369
;

--INSERT INTO party_manager_events (request_id,action_type,customer_id,account_type,account_sub_type,subscriber_no,link_type,old_comp_reg_id,comp_reg_id,old_tpid,tpid,old_birth_date,birth_date,old_status,status,name_format,old_first_name,first_name,old_last_business_name,last_business_name,old_email,email,request_time,process_time,process_status,request_user_id,status_desc) 
--values ('13030','M','703678417','B','R','GSM04793401922','U',null,null,null,'891c1f24-4976-4144-b1b7-9f173f9a7805',null,null,null,null,'I','DOBB','DOBB','DOBBELSEN','DOBBELSEN',null,null,to_date('2021-02-11 09:20','YYYY-MM-DD HH24:MI'),null,'ON_HOLD','NINJA 2021-02-11',null);
--INSERT INTO party_manager_events (request_id,action_type,customer_id,account_type,account_sub_type,subscriber_no,link_type,old_comp_reg_id,comp_reg_id,old_tpid,tpid,old_birth_date,birth_date,old_status,status,name_format,old_first_name,first_name,old_last_business_name,last_business_name,old_email,email,request_time,process_time,process_status,request_user_id,status_desc) 
--values ('13395','M','703678417','B','R','GSM04793401922','U',null,null,null,'eb119c0e-f31e-4c1a-8aed-1b62ec4a6aa4',null,null,null,null,'I','DOBB','DOBB','DOBBELSEN','DOBBELSEN',null,null,to_date('2021-02-11 14:21','YYYY-MM-DD HH24:MI'),null,'ON_HOLD','NINJA 2021-02-11',null);
INSERT INTO party_manager_events (request_id,action_type,customer_id,account_type,account_sub_type,subscriber_no,link_type,old_comp_reg_id,comp_reg_id,old_tpid,tpid,old_birth_date,birth_date,old_status,status,name_format,old_first_name,first_name,old_last_business_name,last_business_name,old_email,email,request_time,process_time,process_status,request_user_id,status_desc) 
VALUES ('13369','M','703678417','B','R','GSM04793401922','U',NULL,NULL,NULL,'2d19aff2-5968-406a-a577-349f19eaf3a0',NULL,NULL,NULL,NULL,'I','DOBB','DOBB','DOBBELSEN','DOBBELSEN',NULL,NULL,to_date('2021-02-11 13:58','YYYY-MM-DD HH24:MI'),NULL,'WAITING','NINJA 2021-02-11',NULL);
