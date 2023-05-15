INSERT INTO dsp_request
SELECT rq.request_id, rq.customer_id, rq.adr_first_name, rq.adr_last_name,
       rq.adr_birth_date, rq.adr_zip, SYSDATE AS "RECORD_CREATION_DATE",
       rq.process_status, 'First- and Middle Name Repair' AS "REQUEST_USER_ID", 
       SYSDATE AS "PROCESS_TIME",
       rq.status_desc
  FROM dsp_request rq, dsp_response rs
 WHERE 1 = 1
--   AND rs.request_id  BETWEEN 500 AND 599
   AND rs.request_id        = rq.request_id
   AND rq.adr_first_name   != rs.adr_first_name
   AND rq.adr_first_name LIKE '% %'
   AND rq.process_status    = 'PRSD_SUCCESS'
   AND rs.process_status    = 'PRSD_SUCCESS'
;

INSERT INTO dsp_response
SELECT UNIQUE rq2.request_id, rq.adr_last_name, rq.adr_first_name, rs.adr_birth_date
     , NULL AS "ADR_CITY", NULL AS "ADR_ZIP", NULL AS "ADR_HOUSE_NO"
     , NULL AS "ADR_STREET_NAME", NULL AS "ADR_POB", NULL AS "ADR_COUNTRY"
     , NULL AS "ADR_HOUSE_LETTER", NULL AS "ADR_STOREY", NULL AS "ADR_DOOR_NO"
     , NULL AS "ADR_DISTRICT", rs.adr_gender, NULL AS "ADR_STAT"
     , rs.dsp_id, SYSDATE AS "RECORD_CREATION_DATE", 'ON_HOLD' AS "PROCESS_STATUS"
     , NULL AS "PROCESS_TIME", NULL AS "STATUS_DESC"
  FROM dsp_request rq, dsp_response rs, dsp_request rq2
 WHERE 1 = 1
--   AND rs.request_id  BETWEEN 500 AND 599
   AND rs.request_id        = rq.request_id
   AND rq.adr_first_name   != rs.adr_first_name
   AND rq.adr_first_name LIKE '% %'
   AND rq.process_status    = 'PRSD_SUCCESS'
   AND rs.process_status    = 'PRSD_SUCCESS'
   AND rq.request_user_id   = 'Ninja DSP Extract'
   AND rq.customer_id       = rq2.customer_id
   AND rq2.request_user_id  = 'First- and Middle Name Repair'
   AND rq2.process_status   = 'PRSD_SUCCESS'
;

UPDATE dsp_response rs
   SET rs.process_status = 'WAITING'
 WHERE rs.process_status = 'ON_HOLD'
   AND rs.record_creation_date > trunc(SYSDATE)
;
