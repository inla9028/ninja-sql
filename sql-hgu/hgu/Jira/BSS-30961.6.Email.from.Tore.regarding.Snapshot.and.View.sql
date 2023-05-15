
Hei
Måtte endre litt, opprettet snapshotet på nrep11 databasen
 
create  MATERIALIZED VIEW dr_info tablespace data_no_ts
REFRESH FORCE START WITH to_date('10-02-2012 06:00:00',
'MM-dd-yyyy hh24:mi:ss') NEXT trunc(sysdate + 1) as
SELECT /*+ hash(ba,anl) */ ba.ban, nd.first_name, nd.last_business_name, nd.birth_date, ad.adr_zip
  FROM billing_account ba, address_name_link anl, name_data nd, address_data ad
WHERE ba.ban_status       = 'O'
   AND ba.account_type     = 'I'
   AND ba.ban              = anl.ban
   AND SYSDATE       BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.link_type       = 'L'
   AND anl.name_id         = nd.name_id
   AND anl.address_id      = ad.address_id
   AND nd.comp_reg_id      IS NULL
 
På ninjadata_at ligger et view dr_info
 
create view dr_info as select *
from dr_info@nrep11 ba where NOT EXISTS (
      SELECT ''
        FROM dsp_request dr
       WHERE dr.customer_id    = ba.ban
         AND dr.process_status = 'WAITING')
/
 
Burde fungere hvis du benytter dr_info på ninjadata_at
 
Når du har testet kan vi opprette det i prod
/

