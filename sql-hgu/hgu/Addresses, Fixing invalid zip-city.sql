select a.requestor_id, a.process_status, count(1) AS "CNT"
     , TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.110) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.110) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  from batch_address_update a
group by a.requestor_id, a.process_status
order by 1,2
;

update batch_address_update a
   set a.process_status = 'WAITING'
 where a.requestor_id   = 'HGU 2020-03-20'
   and a.process_status = 'ON_HOLD'
   and a.zip_code       > '7999'
;


select a.*
  from batch_address_update a
 where a.requestor_id   = 'HGU 2020-03-20'
   and a.process_status = 'PRSD_ERROR'
;

select a.ban, a.subscriber_no, a.link_type
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (a.status_desc,
                               0,
                               INSTR (a.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  from batch_address_update a
 where a.requestor_id   = 'HGU 2020-03-20'
   and a.process_status = 'PRSD_ERROR'
;



select a.requestor_id, a.process_status, a.zip_code, a.city, count(1) AS "CNT"
  from batch_address_update a
group by a.requestor_id, a.process_status, a.zip_code, a.city
order by 1,2,3,4
;

SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"),      '9999999,999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999,999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_address_update a
     WHERE a.requestor_id   = 'HGU 2020-03-20'
       AND a.process_status != 'WAITING'
       AND a.process_time   BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
     GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
     ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);








select a.*
  from batch_address_update a
-- where a.subscriber_no = 'GSM04792041328'
-- where a.subscriber_no = '0000000000'
 where a.zip_code = '9982'
;

DELETE
  FROM batch_address_update a
 WHERE a.process_status = 'ON_HOLD'
   AND a.requestor_id   = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
;

select anl.*
  from address_name_link@fokus anl
 where anl.link_seq_no IN (select w.link_seq_no
                             from ap_tmp_anl_200320_wrong@fokus w
                            where w.link_seq_no IN ( 294501539, 294310724, 281910519 )
                              and rownum < 101)
;

select ad.*
  from address_name_link@fokus anl, address_data@fokus ad
 where anl.link_seq_no IN (select w.link_seq_no
                             from ap_tmp_anl_200320_wrong@fokus w
                            where w.link_seq_no IN ( 294501539, 294310724, 281910519 )
                              and rownum < 101)
   and anl.address_id = ad.address_id
;

select a.*
  from address_data@fokus a
;
 
INSERT
  INTO batch_address_update
SELECT anl.ban
     , NULL AS "SUBSCRIBER_NO"
     , anl.link_type
     , ad.adr_type AS "ADDRESS_TYPE"
     , NULL AS "ACCOMMODATION_TYPE"
     , NULL AS "AREA_DISTRICT"
     , zd.city AS "CITY"
     , NULL AS "COUNTRY_CODE"
     , NULL AS "CO_NAME"
     , NULL AS "DIRECTION"
     , NULL AS "DOOR_NUMBER"
     , NULL AS "EMAIL"
     , NULL AS "FLOOR_NUMBER"
     , NULL AS "HOUSE_LETTER"
     , NULL AS "HOUSE_NUMBER"
     , NULL AS "POB"
     , NULL AS "POB_NAME"
     , NULL AS "SINCE_DATE"
     , NULL AS "STREET_NAME"
     , anl.adr_zip AS "ZIP_CODE"
     , NULL AS "ENTER_TIME"
     , NULL AS "REQUEST_TIME"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUESTOR_ID"
     , NULL AS "PROCESS_TIME"
     , 'ON_HOLD' AS "PROCESS_STATUS"
     , TO_CHAR(anl.link_seq_no) AS "STATUS_DESC"
  FROM address_name_link@fokus anl, address_data@fokus ad, zip_decode@fokus zd, billing_account@fokus ba
 WHERE anl.link_seq_no IN (SELECT * FROM ap_tmp_anl_200320_wrong@fokus /* WHERE ROWNUM < 501 */)
   AND anl.expiration_date IS NULL
   AND REGEXP_LIKE(anl.adr_zip, '[0-9]')
   AND RTRIM(anl.adr_zip) = zd.zip_code
   AND anl.address_id     = ad.address_id
   AND anl.expiration_date IS NULL
   AND anl.subscriber_no = '0000000000'
   and anl.ban           = ba.ban
   and ba.ban_status    IN ( 'O', 'T', 'S' )
ORDER BY 1,2,3,4
;

INSERT
  INTO batch_address_update
SELECT anl.ban
     , anl.subscriber_no
     , anl.link_type
     , ad.adr_type AS "ADDRESS_TYPE"
     , NULL AS "ACCOMMODATION_TYPE"
     , NULL AS "AREA_DISTRICT"
     , zd.city AS "CITY"
     , NULL AS "COUNTRY_CODE"
     , NULL AS "CO_NAME"
     , NULL AS "DIRECTION"
     , NULL AS "DOOR_NUMBER"
     , NULL AS "EMAIL"
     , NULL AS "FLOOR_NUMBER"
     , NULL AS "HOUSE_LETTER"
     , NULL AS "HOUSE_NUMBER"
     , NULL AS "POB"
     , NULL AS "POB_NAME"
     , NULL AS "SINCE_DATE"
     , NULL AS "STREET_NAME"
     , anl.adr_zip AS "ZIP_CODE"
     , NULL AS "ENTER_TIME"
     , NULL AS "REQUEST_TIME"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUESTOR_ID"
     , NULL AS "PROCESS_TIME"
     , 'ON_HOLD' AS "PROCESS_STATUS"
     , TO_CHAR(anl.link_seq_no) AS "STATUS_DESC"
  FROM address_name_link@fokus anl, address_data@fokus ad, zip_decode@fokus zd, subscriber@fokus s
 WHERE anl.link_seq_no IN (SELECT * FROM ap_tmp_anl_200320_wrong@fokus /* WHERE ROWNUM < 501 */)
   AND anl.expiration_date IS NULL
   AND REGEXP_LIKE(anl.adr_zip, '[0-9]')
   AND RTRIM(anl.adr_zip) = zd.zip_code
   AND anl.address_id     = ad.address_id
   AND anl.expiration_date IS NULL
   AND anl.subscriber_no != '0000000000'
   AND anl.ban            = s.customer_id
   AND anl.subscriber_no  = s.subscriber_no
   AND s.cnt_seq_no       = (SELECT MAX(s2.cnt_seq_no)
                              FROM subscriber@fokus s2
                             WHERE s2.subscriber_no = s.subscriber_no)
   AND s.sub_status      IN ( 'A', 'S', 'R' )
ORDER BY 1,2,3,4
;
 

