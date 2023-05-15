CREATE OR REPLACE VIEW dsf_info (
   ban,
   link_type,
   subscriber_no,
   comp_reg_id,
   first_name,
   last_business_name,
   birth_date,
   adr_zip )
AS
SELECT "BAN","LINK_TYPE","SUBSCRIBER_NO","COMP_REG_ID","FIRST_NAME","LAST_BUSINESS_NAME","BIRTH_DATE","ADR_ZIP"
      FROM dsf_info@nrep11 di
     WHERE NOT EXISTS
                   (SELECT ''
                      FROM dsp_request req
                     WHERE req.customer_id          = di.ban
                       AND req.link_type            = di.link_type
                       AND req.subscriber_no        = di.subscriber_no
                       -- AND req.record_creation_date > TRUNC(SYSDATE)
                       AND req.record_creation_date > TRUNC(SYSDATE, 'DAY')
                       -- AND req.process_status = 'WAITING'
                   )
/

