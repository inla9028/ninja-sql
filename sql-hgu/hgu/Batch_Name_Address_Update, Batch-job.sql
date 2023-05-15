SELECT a.transaction_number, a.link_type, a.ban_no, a.subscriber_no,
       a.last_business_name, a.first_name, a.birth_date, a.adr_city,
       a.adr_zip, a.adr_house_no, a.adr_street_name, a.adr_pob,
       a.adr_district, a.adr_country, a.adr_house_letter, a.adr_storey,
       a.adr_door_no, a.adr_gender, a.allow_advertising_ind,
       a.adr_home_phone, a.email_addr, a.adr_listed_ind,
       a.publish_level, a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.request_user_id,
       a.role_ind, a.company_id, a.adr_co_name, a.dsp_ind,
       a.additional_title
  FROM batch_name_address_update a
  WHERE a.request_id      = '2018-08-31'
    AND a.request_user_id = 'HGU'
--    AND a.record_creation_date > trunc(SYSDATE)
--    AND a.process_status  = 'WAITING'
;

--== Display the waiting records...
SELECT a.request_id, a.request_user_id, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.970) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.970) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_name_address_update a
  WHERE a.process_status  = 'WAITING'
  GROUP BY a.request_id, a.request_user_id
  ORDER BY a.request_id, a.request_user_id
;

--== Display today's records, and the time they had to wait for processing.
SELECT a.record_creation_date, a.process_time
     , TO_CHAR(TRUNC(SYSDATE) + (NVL(a.process_time, SYSDATE) - a.record_creation_date), 'MI:SS') AS "DURATION"
     , a.process_status, a.request_id, a.request_user_id
  FROM batch_name_address_update a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
ORDER BY a.record_creation_date
;

--== Display today's records
SELECT a.request_user_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.970) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.970) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_name_address_update a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY a.request_user_id, a.process_status
  ORDER BY a.request_user_id, a.process_status
;

--==
SELECT a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.970) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.970) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_name_address_update a
  WHERE a.request_id      = '2018-08-31'
    AND a.request_user_id = 'HGU'
--    AND a.record_creation_date > trunc(SYSDATE)
  GROUP BY a.process_status
;
--
SELECT a.ban_no, a.subscriber_no, substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')) AS "STATUS_DESC"
  FROM batch_name_address_update a
  WHERE a.request_id      = '2018-08-31'
    AND a.request_user_id = 'HGU'
    AND a.process_status  = 'PRSD_ERROR'
    AND a.record_creation_date > trunc(SYSDATE)
  ORDER BY a.subscriber_no
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_name_address_update a
      WHERE a.record_creation_date > TRUNC(SYSDATE)
        AND a.process_status      != 'WAITING'
        AND a.process_time        > SYSDATE - (15 / 1440)  
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

--==
UPDATE batch_name_address_update a
  SET a.process_status = 'IN_PROGRESS', a.status_desc = NULL,
      a.process_time = NULL
  WHERE a.request_id      = '2018-08-31'
    AND a.request_user_id = 'HGU'
    AND a.process_status  = 'PRSD_ERROR'
;

--== Correct the msisdn's, was 'GSM040451504', should be 'GSM04740451504'.
UPDATE batch_name_address_update a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
      , a.subscriber_no = 'GSM047'||SUBSTR(a.subscriber_no, 5)
  WHERE a.request_id            = '2018-08-31'
    AND a.request_user_id       = 'HGU'
    AND a.process_status        = 'PRSD_ERROR'
    AND LENGTH(a.subscriber_no) = 12
;

--== Switch the request_id & request_user_id... :-)
UPDATE batch_name_address_update a
  SET a.request_id = a.request_user_id, a.request_user_id = a.request_id
  WHERE a.request_id            = '2018-08-31'
    AND a.request_user_id       = 'HGU';
COMMIT;

--== Reprocess records that failed to to BAN-locks, and similar...
UPDATE batch_name_address_update a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
--    , a.link_type      = 'U'
--    , a.adr_city       = 'KRISTIANSAND S'
--      , a.last_business_name = '.'
  WHERE a.request_id            = '2018-08-31'
    AND a.request_user_id       = 'HGU'
    AND a.process_status        = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%BAN%in use%'
      OR a.status_desc LIKE '%Last business name is mandatory and cannot be null%'
    )
    AND a.record_creation_date > trunc(SYSDATE)
;
