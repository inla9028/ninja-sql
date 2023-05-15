SELECT /*+ driving_site(s)*/
       anl.ban, anl.subscriber_no, anl.link_type, anl.birth_date,
       nd.comp_reg_id, nd.name_format, nd.first_name, nd.last_business_name, nd.additional_title,
       ad.adr_type, ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email -- , ad.*
  FROM subscriber@fokus        s
     , address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
 WHERE s.subscriber_no   IN ( 'GSM047'||'93001860', 'GSM047'||'95174240' )
   AND s.cnt_seq_no       = (SELECT MAX(s2.cnt_seq_no)
                              FROM subscriber@fokus s2
                             WHERE s2.subscriber_no = s.subscriber_no)
   AND anl.ban            = s.customer_id 
   AND anl.subscriber_no IN ( '0000000000', s.subscriber_no )
   AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
ORDER BY anl.ban, anl.subscriber_no, anl.link_type
;

SELECT /*+ driving_site(a)*/
       a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus a, users@fokus u
 WHERE a.memo_subscriber IN ( 'GSM047'||'93001860', 'GSM047'||'95174240' )
   AND a.memo_date       > TRUNC(SYSDATE)
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;


select a.*
  from batch_address_update a
;

UPDATE batch_address_update a
   SET a.PROCESS_TIME = NULL, a.PROCESS_STATUS = 'WAITING'
 WHERE a.requestor_id   = 'HGU 2019-10-21'
   and a.subscriber_no  = 'GSM04795174240'
   and a.process_Status = 'PRSD_SUCCESS' -- 'PRSD_ERROR'
;

SELECT *
  FROM (SELECT rowid, ban, subscriber_no, link_type, address_type
             , accommodation_type, area_district, city, country_code, co_name, direction
             , door_number, email, floor_number, house_letter, house_number, pob
             , pob_name, since_date, street_name, zip_code
          FROM batch_address_update
         WHERE process_status = 'WAITING'
           AND request_time   < SYSDATE
      ORDER BY request_time)
 WHERE ROWNUM < 21
;