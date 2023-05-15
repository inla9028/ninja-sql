--==
--== Insert records into DSP_REQUEST...
--==
INSERT INTO dsp_request (
SELECT /*+ driving_site(anl) */ NULL AS "REQUEST_ID", anl.ban AS "CUSTOMER_ID", nd.first_name AS "ADR_FIRST_NAME"
     , nd.last_business_name AS "ADR_LAST_NAME", TO_CHAR(nd.birth_date,  'YYYYMMDD') AS "ADR_BIRTH_DATE"
     , ad.adr_zip, SYSDATE AS "RECORD_CREATION_DATE", 'WAITING' AS "PROCESS_STATUS"
     , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_USER_ID", NULL AS "PROCESS_TIME", NULL AS "STATUS_DESC"
  FROM DATA_NO.address_name_link@nrep11 anl, DATA_NO.name_data@nrep11 nd, DATA_NO.address_data@nrep11 ad, ninjateam.hgu_tmp_bans hgu
 WHERE hgu.ban        = anl.ban
   AND SYSDATE  BETWEEN anl.effective_date AND NVL (anl.expiration_date, SYSDATE + 1)
   AND anl.link_type  = 'L'
   AND anl.name_id    = nd.name_id
   AND anl.address_id = ad.address_id
   AND nd.comp_reg_id IS NULL
   --
   AND nd.first_name IS NOT NULL -- We encountered test-data with no first name...
);

COMMIT WORK;

--==
--== Check the number of registered vs unregistered based on the BAN list (i.e. the table ninjateam.hgu_tmp_bans hgu)
--==


