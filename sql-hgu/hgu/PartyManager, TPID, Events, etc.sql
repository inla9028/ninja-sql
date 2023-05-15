
--== Check the TPID queue from Fokus into Party Manager
SELECT process_time, process_status, mycount AS "COUNT"
     , round(     mycount /   60 , 0) AS "RPM"
     , round(     mycount / 3600 , 2) AS "RPS"
     , round(1 / (mycount / 3600), 3) AS "SPR"
  FROM (
SELECT b.process_time, b.process_status, count(1) AS "MYCOUNT"
  FROM (SELECT to_char(a.process_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "PROCESS_TIME", a.process_status
          FROM batch_tpid_extract A
         WHERE a.request_time > trunc(SYSDATE - 1)
           AND nvl(a.process_time, SYSDATE) > trunc(SYSDATE)
--           AND nvl(a.process_time, SYSDATE) > trunc(SYSDATE - 1/3, 'HH')
--           AND nvl(a.process_time, SYSDATE) > to_date('2021-04-29 15:06', 'YYYY-MM-DD HH24:MI')
           AND a.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS', 'WAITING' )) b
GROUP BY b.process_time, b.process_status
ORDER BY b.process_time, b.process_status
)
;


--== Check the TPID queue from Ninja/Party Manager into Fokus
SELECT b.process_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(a.process_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "PROCESS_TIME", a.process_status
          FROM batch_tpid_update A
         WHERE a.request_time > trunc(SYSDATE - 1)
           AND trunc(SYSDATE) < nvl(a.process_time, SYSDATE)
           AND a.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS', 'WAITING' )) b
GROUP BY b.process_time, b.process_status
ORDER BY b.process_time, b.process_status
;


--== Check the events caused by processing by/via Ninja.
SELECT b.request_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(a.request_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "REQUEST_TIME", a.process_status
          FROM party_manager_events A
         WHERE a.request_time > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
           AND trunc(SYSDATE) < nvl(a.process_time, SYSDATE)
           AND a.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS', 'WAITING' )) b
GROUP BY b.request_time, b.process_status
ORDER BY b.request_time, b.process_status
;

--== List the kinds of errors
select error_message, count(1) as "COUNT"
  from (
select substr(substr(a.status_desc, 0, instr(a.status_desc, '. Ignored')), 73) AS "ERROR_MESSAGE"
  from batch_tpid_extract a
 where a.request_time between to_date('2022-03-01 11:15', 'YYYY-MM-DD HH24:MI')ß
                          and to_date('2022-03-01 16:00', 'YYYY-MM-DD HH24:MI')
--                          and sysdate
   and a.process_status = 'PRSD_ERROR'
--   and a.status_desc like '%Invalid name%'
)
group by error_message
order by 2 desc,1
;




-- Look at the events for someone...
select action_type, customer_id, account_type, subscriber_no, first_name, last_business_name, request_time, process_status
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (status_desc,
                           0,
                           INSTR (status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (status_desc,
                               0,
                               INSTR (status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
     , request_id, old_tpid, tpid, process_time
     , old_comp_reg_id, comp_reg_id, old_birth_date, birth_date
  from party_manager_events
 where request_time between to_date('2022-09-01', 'YYYY-MM-DD') and to_date('2022-09-02', 'YYYY-MM-DD')
   and customer_id  IN ( 893324517 )
   and subscriber_no = 'GSM04740583948'
order by request_id
;


select a.*
  from batch_tpid_extract a
 where 1 = 1
   and a.request_time between to_date('2022-09-01', 'YYYY-MM-DD') and to_date('2022-09-02', 'YYYY-MM-DD')
   and a.ban           IN ( 893324517 )
   and a.subscriber_no = 'GSM04740583948'
order by a.request_time
;

select a.*
     , to_char(a.process_time, 'YYYY-MM-DD HH24:MI:SS') AS "PROC_TIME"
  from batch_tpid_update a  
 where 1 = 1
   and a.request_time between to_date('2022-09-01', 'YYYY-MM-DD') and to_date('2022-09-02', 'YYYY-MM-DD')
   and a.ban           IN ( 893324517 )
   and a.subscriber_no = 'GSM04740583948'
;

select *
  from party_manager_events
 where 1 = 1
   and request_time between to_date('2022-09-01', 'YYYY-MM-DD') and to_date('2022-09-02', 'YYYY-MM-DD')
   and customer_id   IN ( 893324517 )
   and subscriber_no = 'GSM04740583948'
order by request_id
;






-- Clear the TPID for someone....
insert into batch_tpid_update (BAN, SUBSCRIBER_NO, LINK_TYPE, REQUEST_ID, PROCESS_STATUS)
values (648415412, 'GSM04792994245', 'U', 'HGU' || TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'WAITING');

select a.*
  from batch_tpid_update a
 where a.request_id = 'HGU' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
order by a.request_time
;

with my_filter AS (
  select a.ban, a.subscriber_no, a.link_type, a.request_time
    from batch_tpid_update a
   where a.request_id = 'HGU' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
)
select a.customer_id, a.account_type, a.account_sub_type, a.subscriber_no
     , a.link_type, a.old_tpid, a.tpid, a.request_time, a.process_status, a.status_desc
  from party_manager_events a, my_filter mf
 where a.request_time  between trunc(mf.request_time) and trunc(mf.request_time + 1)
   and a.customer_id   = mf.ban
--   and a.subscriber_no = mf.subscriber_no
--   and a.link_type     = mf.link_type
order by a.request_id
;

with my_filter AS (
  select a.ban, a.subscriber_no, a.link_type, a.request_time
    from batch_tpid_update a
   where a.request_id = 'HGU' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
)
select a.*
  from batch_tpid_extract a, my_filter mf
 where a.request_time  between trunc(mf.request_time) and trunc(mf.request_time + 1)
   and a.ban           = mf.ban
   and a.subscriber_no = mf.subscriber_no
   and a.link_type     = mf.link_type
order by a.request_time
;