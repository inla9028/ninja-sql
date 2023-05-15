SELECT a.transaction_no, a.ban, a.subscriber_no, a.price_plan,
       a.tb_cug_code, a.vpn_code, a.cug_code, a.adt_soc_1, a.adt_soc_2,
       a.adt_soc_3, a.adt_soc_4, a.dealer_code, a.sales_agent,
       a.publish_level, a.user_first, a.surname, a.bill_info,
       a.role_ind, a.birth_date, a.adr_type, a.city, a.zip_code,
       a.country, a.street_name, a.house_no, a.house_letter, a.floor,
       a.door_no, a.p_o_box, a.area_pob_name, a.email, a.co_name,
       a.requestor_id, a.process_time, a.process_status, a.status_desc
  FROM ninjadata.cda_batch_activations a
  WHERE a.requestor_id   = 'GSC 15.12.2006'
    AND a.subscriber_no LIKE 'GSM%'
    AND a.process_status NOT IN ('PRSD_SUCCESS')



--
SELECT a.process_status, COUNT(*) AS "Count"
  FROM ninjadata.cda_batch_activations a
  WHERE a.requestor_id   = 'GSC 15.12.2006'
  GROUP BY a.process_status

/*
UPDATE ninjadata.cda_batch_activations a
  SET a.process_status = 'IN_PROGRESS'
  WHERE a.requestor_id   = 'GSC 15.12.2006'
    AND a.process_status = 'WAITING';
COMMIT;
*/
