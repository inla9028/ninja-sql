SELECT /*+ driving_site(anl) */ COUNT(1) AS "COUNT"
  FROM tmp_addresses_invalid_w_names@nrep11 a
;

INSERT INTO dsp_request
(
SELECT NULL                                     AS "REQUEST_ID"
     , a.ban                                    AS "CUSTOMER_ID"
     , TRIM(a.first_name)                       AS "ADR_FIRST_NAME"
     , TRIM(a.last_business_name)               AS "ADR_LAST_NAME"
     , TO_CHAR(a.birth_date,  'YYYYMMDD')       AS "ADR_BIRTH_DATE"
     , TRIM(a.adr_zip)                          AS "ADR_ZIP"
     , SYSDATE                                  AS "RECORD_CREATION_DATE"
     , 'WAITING'                                AS "PROCESS_STATUS"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_USER_ID"
     , NULL                                     AS "PROCESS_TIME"
     , NULL                                     AS "STATUS_DESC"
     , a.subscriber_no                          AS "SUBSCRIBER_NO"
     , a.link_type                              AS "LINK_TYPE"
     , a.comp_reg_id                            AS "COMP_REG_ID"
  FROM tmp_addresses_invalid_w_names@nrep11 a
 WHERE a.subscriber_no LIKE '000%'
-- where rownum < 11
)
;

COMMIT WORK
;

SELECT a.request_user_id, a.process_status, COUNT(1) 
  FROM dsp_request a
 WHERE a.request_user_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY a.request_user_id, a.process_status
ORDER BY 1, 2
;
