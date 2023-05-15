SELECT /*+ hash(ba,anl) */ ba.ban,
       nd.first_name,
       nd.last_business_name,
       nd.birth_date,
       ad.adr_zip
  FROM billing_account ba,
       address_name_link anl,
       name_data nd,
       address_data ad
 WHERE (
         ba.ban_status IN ( 'O', 'S' )
     OR (ba.ban_status = 'N' AND ba.col_delinq_status = 'D')
   )
   AND (
         ba.account_type = 'I'
     OR (ba.account_type = 'H' AND ba.account_sub_type = 'PC')
   )
   AND ba.ban         = anl.ban
   AND SYSDATE  BETWEEN anl.effective_date AND NVL (anl.expiration_date, SYSDATE + 1)
   AND anl.link_type  = 'L'
   AND anl.name_id    = nd.name_id
   AND anl.address_id = ad.address_id
   AND nd.comp_reg_id IS NULL
;

--== Investigative query...
SELECT ba.ban, ba.ban_status, ba.account_type, ba.account_sub_type
     , NVL(nd.comp_reg_id, '(NULL)') AS "COMP_REG_ID"
     , nd.first_name, nd.last_business_name, nd.birth_date, ad.adr_zip
  FROM billing_account ba, address_name_link anl, name_data nd, address_data ad
 WHERE ba.ban IN ( 623115904 )
   AND ba.ban         = anl.ban
       AND SYSDATE  BETWEEN anl.effective_date AND NVL (anl.expiration_date, SYSDATE + 1)
       AND anl.link_type  = 'L'
       AND anl.name_id    = nd.name_id
       AND anl.address_id = ad.address_id
;

-- CREATE MATERIALIZED VIEW "DATA_NO"."DR_INFO_X" TABLESPACE "DATA_NO_TS" PCTFREE 10 INITRANS 1 MAXTRANS 255 STORAGE ( INITIAL 5120K BUFFER_POOL DEFAULT) NOLOGGING USING NO INDEX REFRESH FORCE START WITH to_date('04-20-2016 00:00:00','MM-dd-yyyy hh24:mi:ss') NEXT trunc(sysdate + 1) AS SELECT /*+ hash(ba,anl) */ ba.ban, nd.first_name, nd.last_business_name, nd.birth_date, ad.adr_zip
-- FROM billing_account ba, address_name_link anl, name_data nd, address_data ad
-- WHERE ba.ban_status = 'O'
-- AND ( ba.account_type = 'I' or (ba.account_type='H' and ba.account_sub_type='PC'))
-- AND ba.ban = anl.ban
-- AND SYSDATE BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
-- AND anl.link_type = 'L'
-- AND anl.name_id = nd.name_id
-- AND anl.address_id = ad.address_id
-- AND nd.comp_reg_id IS NULL

