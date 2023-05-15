--CREATE TABLE hgu_tmp_ban_sub_etc
--(
--  ban              NUMBER(9,0),
--  subscriber_no    VARCHAR2(20 CHAR),
--  link_type        CHAR(1 CHAR),
--  customer_telno   VARCHAR2(20 CHAR), 
--  process_status   CHAR(12 CHAR)
--)
--;

--DELETE 
--  FROM hgu_tmp_ban_sub_etc
--;

--DROP table hgu_tmp_ban_sub_etc PURGE
--;

--CREATE SYNONYM hgu_tmp_ban_sub_etc
--  FOR ninjateam.hgu_tmp_ban_sub_etc
--;

DESC hgu_tmp_ban_sub_etc
;

SELECT A.*
  FROM hgu_tmp_ban_sub_etc A
;

--== Flag all rows as waiting...
UPDATE hgu_tmp_ban_sub_etc A
   SET A.process_status = 'WAITING'
;

--== Find and flag duplicates.
UPDATE hgu_tmp_ban_sub_etc x
   SET x.process_status = 'DUPLICATE'
 WHERE x.process_status = 'WAITING'
   AND x.ROWID         IN (SELECT A.ROWID
                             FROM hgu_tmp_ban_sub_etc A, hgu_tmp_ban_sub_etc b
                            WHERE A.process_status            = b.process_status
                              AND b.process_status            = 'WAITING'
                              AND A.ban                       = b.ban
                              AND nvl(A.subscriber_no, 'N/A') = nvl(b.subscriber_no, 'N/A')
                              AND A.link_type                 = b.link_type
                              AND A.ROWID                     < b.ROWID)
;

--== Populate customer telno from Fokus.
UPDATE hgu_tmp_ban_sub_etc A
   SET A.customer_telno = (SELECT trim(c.customer_telno)
                             FROM customer@nrep11 c
                            WHERE c.customer_id    = A.ban
                              and a.process_status = 'WAITING')
;


--== Discard rows without a customer telno.
UPDATE hgu_tmp_ban_sub_etc A
   SET A.process_status = 'ON_HOLD'
 WHERE A.customer_telno IS NULL
;

-- Display an overview...
SELECT A.process_status, count(1) AS "COUNT"
  FROM hgu_tmp_ban_sub_etc A
GROUP BY A.process_status
ORDER BY A.process_status
;

--== Insert events. Use Nrep11 for perfomance.
INSERT INTO party_manager_events (action_type, customer_id, account_type, account_sub_type, 
                                  subscriber_no, link_type, old_tpid, tpid, name_format, 
                                  request_user_id, old_customer_telno, customer_telno,
                                  process_status )
SELECT 'M'         AS "ACTION_TYPE"
     , h.ban       AS "CUSTOMER_ID"
     , ba.account_type, ba.account_sub_type, h.subscriber_no, h.link_type
     , nd.tpid     AS "OLD_TPID"
     , nd.tpid     AS "TPID"
     , decode(nd.name_format
            , 'P', 'I'
            , 'D', 'C'
            , 'I') AS "NAME_FORMAT"
     , 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD') AS "REQUEST_USER_ID"
     , NULL        AS "OLD_CUSTOMER_TELNO"
     , h.customer_telno
     , 'ON_HOLD'   AS "PROCESS_STATUS"
  FROM hgu_tmp_ban_sub_etc      h
     , billing_account@nrep11   ba
     , address_name_link@nrep11 anl
     , name_data@nrep11         nd 
 WHERE /*h.ban             = 427147012
   AND */h.process_status  = 'WAITING'
   and ba.ban            = h.ban
   AND anl.ban           = h.ban
   AND anl.link_type     = h.link_type
   AND anl.subscriber_no = decode(h.subscriber_no, NULL, '0000000000', h.subscriber_no)
   AND SYSDATE     BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND nd.name_id        = anl.name_id
;

--== Flag all inserted rows as processed.
UPDATE hgu_tmp_ban_sub_etc h
   SET h.process_status = 'PRSD_SUCCESS'
 WHERE h.process_status = 'WAITING'
   AND (h.ban, /*h.subscriber_no,*/ h.link_type) IN (SELECT A.customer_id, /*A.subscriber_no,*/ A.link_type
                                                   FROM party_manager_events A
                                                  WHERE A.process_status  = 'ON_HOLD'
                                                    AND A.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD'))
;

--== List affected rows in the event table.
SELECT A.*
  FROM party_manager_events A
 WHERE A.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD')
   AND A.process_status  = 'ON_HOLD'
;

--== Display an overview...
SELECT A.process_status, count(1) AS "COUNT"
  FROM hgu_tmp_ban_sub_etc A
GROUP BY A.process_status
ORDER BY A.process_status
;

--== Flag duplicates as, well, duplicates.
UPDATE party_manager_events x
   SET x.process_status  = 'PRSD_ERROR'
     , x.status_desc     = 'HGU: Duplicate'
 WHERE x.process_status  = 'ON_HOLD'
   AND x.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD')
   AND x.ROWID         IN (SELECT A.ROWID
                             FROM party_manager_events A, party_manager_events b
                            WHERE A.process_status            = b.process_status
                              AND b.process_status            = 'ON_HOLD'
                              AND A.request_user_id           = b.request_user_id
                              AND b.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD')
                              AND A.customer_id               = b.customer_id
                              AND A.tpid                      = b.tpid
                              AND A.ROWID                     < b.ROWID)
;

--== Check the event table...
SELECT A.request_user_id, A.process_status, A.status_desc, count(1) AS "COUNT"
  FROM party_manager_events A
 WHERE A.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD')
GROUP BY A.request_user_id, A.process_status, A.status_desc
ORDER BY A.request_user_id, A.process_status, A.status_desc
;

SELECT A.request_user_id, A.process_status, count(1) AS "COUNT"
  FROM party_manager_events A
 WHERE A.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD')
GROUP BY A.request_user_id, A.process_status
ORDER BY A.request_user_id, A.process_status
;

SELECT b.request_user_id, b.process_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT A.request_user_id, to_char(A.process_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "PROCESS_TIME", A.process_status
          FROM party_manager_events A
         WHERE A.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD')) b
GROUP BY b.request_user_id, b.process_time, b.process_status
ORDER BY b.request_user_id, b.process_time, b.process_status
;

SELECT A.request_user_id, A.process_status, count(1) AS "COUNT"
  FROM party_manager_events A
 WHERE A.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD')
GROUP BY A.request_user_id, A.process_status
ORDER BY A.request_user_id, A.process_status
;


--== Start processing...
UPDATE party_manager_events A
   SET A.process_status  = 'WAITING'
 WHERE A.process_status  = 'ON_HOLD'
   AND A.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD')
;

--== Reprocess certain issues.
UPDATE party_manager_events A
   SET A.process_status = 'WAITING'
     , A.process_time   = NULL
     , A.status_desc    = NULL
 WHERE A.request_time   > trunc(SYSDATE - 1)
   AND A.request_user_id = 'HGU ' || to_char(SYSDATE - 1, 'YYYY-MM-DD')
   AND A.process_status = 'PRSD_ERROR'
   AND A.status_desc LIKE '%I/O%'
;

--==
--== Misc...
--==
SELECT /*+ driving_site(anl)*/
       anl.ban
     , decode(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
     , anl.link_type, anl.birth_date, nd.id_type, nd.tpid, nd.comp_reg_id, nd.first_name
     , nd.last_business_name, nd.additional_title
     , ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email
--     , nd.id_type, nd.identify
--     , nd.name_format
  FROM address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
 WHERE anl.ban           IN ( 466390515 )
--   AND anl.subscriber_no  = '0000000000'
   AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
ORDER BY anl.ban, anl.subscriber_no, anl.link_type
;

SELECT A.*
  FROM hgu_tmp_ban_sub_etc A
 WHERE A.ban             = 427147012
ORDER BY 1,3,2,4,5
;

SELECT A.*
  FROM hgu_tmp_ban_sub_etc A
 WHERE A.ban             = 166732115
   and A.process_status  = 'WAITING'
ORDER BY 1,3,2,4,5
;

SELECT A.*
  FROM hgu_tmp_ban_sub_etc A
 WHERE A.process_status = 'DUPLICATE'
;

SELECT A.*
  FROM party_manager_events A
;

SELECT c.*
 FROM  customer@nrep11 c
;