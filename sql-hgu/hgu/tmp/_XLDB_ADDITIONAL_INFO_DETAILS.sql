SELECT a.master_trx_id, a.org_membership_code, a.org_membership_no,
       a.org_member_eff_date, a.action, b.ban, d.customer_id, b.subscriber_no, b.request_status_date,
       c.field_name, c.field_value
  FROM ninjadata.xldb_additional_info_details a, ninjadata.xldb_master_transactions b,
       additional_info@prod.world c
       , subscriber@prod.world d
  WHERE a.master_trx_id = b.transaction_id
    AND b.xldb_order_id = 1243453
    AND b.process_indicator IN ('M', 'U')
    AND b.request_status = 'PRSD_SUCCESS'
--    AND d.customer_id = c.ban(+)
    AND 'GSM'||b.subscriber_no =  c.subscriber_no(+)
    AND 'GSM'||b.subscriber_no =  d.subscriber_no
    AND c.field_name(+) = 'organisation'
    AND c.field_value(+) = 'COOP'
    AND c.sys_creation_date is NULL
aND rownum<2


--SELECT * from xldb_master_transactions where transaction_id=277486


--
/*
SELECT COUNT(*) 
  FROM ninjadata.xldb_additional_info_details a, ninjadata.xldb_master_transactions b
  WHERE a.master_trx_id = b.transaction_id
    AND b.process_indicator IN ('M', 'U')
    AND b.request_status = 'PRSD_SUCCESS'
*/
