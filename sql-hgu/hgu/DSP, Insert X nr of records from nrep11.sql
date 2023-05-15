INSERT INTO dsp_request (
SELECT NULL                                     AS "REQUEST_ID"
     , di.ban                                   AS "CUSTOMER_ID"
     , di.first_name                            AS "ADR_FIRST_NAME"
     , di.last_business_name                    AS "ADR_LAST_NAME"
     , TO_CHAR(di.birth_date,  'YYYYMMDD')      AS "ADR_BIRTH_DATE"
     , di.adr_zip                               AS "ADR_ZIP"
     , SYSDATE                                  AS "RECORD_CREATION_DATE"
     , 'WAITING'                                AS "PROCESS_STATUS"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_USER_ID"
     , NULL                                     AS "PROCESS_TIME"
     , NULL                                     AS "STATUS_DESC"
  FROM dsp_info di
 WHERE ROWNUM < 50001
   AND di.first_name IS NOT NULL
);

COMMIT WORK;

