SELECT rq.request_id, rq.customer_id
     , rs.adr_birth_date, TO_CHAR(anl.birth_date,  'YYYYMMDD') AS "FOKUS_BIRTH_DATE"
     , rs.adr_gender, nd.gender AS "FOKUS_GENDER"
     , rs.dsp_id, nd.comp_reg_id AS "FOKUS_DSP_ID"
     , rs.adr_first_name, nd.first_name AS "FOKUS_FIRST_NAME"
     , rs.adr_last_name, nd.last_business_name AS "FOKUS_LAST_NAME"
     , rs.adr_city, ad.adr_city AS "FOKUS_CITY"
     , rs.adr_zip, ad.adr_zip AS "FOKUS_ZIP"
  FROM dsp_request rq
     , dsp_response rs
     , address_name_link@fokus anl
     , name_data@fokus nd
     , address_data@fokus ad
 WHERE rs.process_status       = 'PRSD_ERROR'
   AND rs.status_desc       LIKE '%Exception%'
   AND rs.request_id           = rq.request_id
   AND rq.customer_id          = anl.ban
   AND SYSDATE           BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id             = nd.name_id
   AND anl.address_id          = ad.address_id
   AND anl.link_type           = 'L'
ORDER BY 1, 2
;

SELECT rq.request_id, rq.customer_id
     , nd.identify AS "FOKUS_IDENTIFY", nd.id_type AS "FOKUS_ID_TYPE"
     , rs.adr_birth_date, TO_CHAR(anl.birth_date,  'YYYYMMDD') AS "FOKUS_BIRTH_DATE"
     , rs.adr_gender, nd.gender AS "FOKUS_GENDER"
     , rs.dsp_id, nd.comp_reg_id AS "FOKUS_DSP_ID"
     , rs.adr_first_name, nd.first_name AS "FOKUS_FIRST_NAME"
     , rs.adr_last_name, nd.last_business_name AS "FOKUS_LAST_NAME"
     , rs.adr_zip, ad.adr_zip AS "FOKUS_ZIP"
     , rs.adr_city, ad.adr_city AS "FOKUS_CITY"
     , SUBSTR(RTRIM(SUBSTR(rs.status_desc, 0, INSTR(rs.status_desc || ' [ID', ' [ID'))), INSTR(rs.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM dsp_request rq
     , dsp_response rs
     , address_name_link@fokus anl
     , name_data@fokus nd
     , address_data@fokus ad
 WHERE rs.process_status       = 'PRSD_ERROR'
   AND rs.status_desc       LIKE '%Exception%'
   AND rs.request_id           = rq.request_id
   AND rq.customer_id          = anl.ban
   AND SYSDATE           BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id             = nd.name_id
   AND anl.address_id          = ad.address_id
   AND anl.link_type           = 'L'
ORDER BY 1, 2
;

SELECT rq.request_id, rq.customer_id
     , ba.account_type, ba.account_sub_type
     , rs.adr_birth_date, TO_CHAR(anl.birth_date,  'YYYYMMDD') AS "FOKUS_BIRTH_DATE"
     , rs.adr_gender, nd.gender AS "FOKUS_GENDER"
     , rs.dsp_id, nd.comp_reg_id AS "FOKUS_DSP_ID"
     , rs.adr_first_name, nd.first_name AS "FOKUS_FIRST_NAME"
     , rs.adr_last_name, nd.last_business_name AS "FOKUS_LAST_NAME"
     , rs.adr_city, ad.adr_city AS "FOKUS_CITY"
     , rs.adr_zip, ad.adr_zip AS "FOKUS_ZIP"
     , rq.status_desc
     , nd.identify, nd.id_type
     , nd.*
  FROM dsp_request rq
     , dsp_response rs
     , billing_account@fokus ba
     , address_name_link@fokus anl
     , name_data@fokus nd
     , address_data@fokus ad
 WHERE rs.process_status       = 'PRSD_ERROR'
   AND rs.status_desc       LIKE '%Exception%'
   AND rs.request_id           = rq.request_id
   AND rq.customer_id          = anl.ban
   AND ba.ban                  = rq.customer_id
   AND SYSDATE           BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id             = nd.name_id
   AND anl.address_id          = ad.address_id
   AND anl.link_type           = 'L'
ORDER BY 1, 2
;

/**
 * List a comparison of the names for a "random" number of users processed today.
 */
SELECT rq.request_id, rq.customer_id
     , ba.account_type, ba.account_sub_type
     , rs.adr_birth_date, TO_CHAR(anl.birth_date,  'YYYYMMDD') AS "FOKUS_BIRTH_DATE"
     , rs.adr_gender, nd.gender AS "FOKUS_GENDER"
     , rs.dsp_id, nd.comp_reg_id AS "FOKUS_DSP_ID"
     , rs.adr_first_name, nd.first_name AS "FOKUS_FIRST_NAME"
     , rs.adr_last_name, nd.last_business_name AS "FOKUS_LAST_NAME"
     , rs.adr_city, ad.adr_city AS "FOKUS_CITY"
     , rs.adr_zip, ad.adr_zip AS "FOKUS_ZIP"
     , rq.status_desc, rq.process_status
     , nd.identify, nd.id_type
     , nd.*
  FROM dsp_request rq
     , dsp_response rs
     , billing_account@fokus ba
     , address_name_link@fokus anl
     , name_data@fokus nd
     , address_data@fokus ad
 WHERE rs.process_time         > TRUNC(SYSDATE)
   AND rs.request_id           = rq.request_id
   AND rq.customer_id          = anl.ban
   AND ba.ban                  = rq.customer_id
   AND SYSDATE           BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id             = nd.name_id
   AND anl.address_id          = ad.address_id
   AND anl.link_type           = 'L'
   AND ROWNUM                  < 21
-- ORDER BY DBMS_RANDOM.VALUE
;



